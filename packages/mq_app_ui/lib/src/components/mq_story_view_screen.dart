import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class MqStoryViewScreen extends StatefulWidget {
  const MqStoryViewScreen({
    required this.items,
    required this.initialIndex,
    super.key,
  });

  final List<MqStoryItem> items;
  final int initialIndex;

  static void view(
    BuildContext context, {
    required List<MqStoryItem> items,
    required int initialIndex,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.01),
        pageBuilder: (_, animation, _) => FadeTransition(
          opacity: animation,
          child: MqStoryViewScreen(
            items: items,
            initialIndex: initialIndex,
          ),
        ),
      ),
    );
  }

  @override
  State<MqStoryViewScreen> createState() => _MqStoryViewScreenState();
}

class _MqStoryViewScreenState extends State<MqStoryViewScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late int _currentUserIndex;
  late List<int> _currentStoryImageIndex;
  late AnimationController _animationController;

  final ValueNotifier<double> _dragOffset = ValueNotifier(0);
  bool _isHolding = false;
  DateTime? _pointerDownTime;
  Offset? _pointerDownPosition;

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentUserIndex);
    _currentStoryImageIndex = List.filled(widget.items.length, 0);

    _animationController = AnimationController(vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });

    _startAnimation();
  }

  void _updateTimerState() {
    if (!mounted) return;
    if (widget.items.isEmpty) return;

    final isDragging = _dragOffset.value.abs() > 0;
    final shouldPlay = !_isHolding && !isDragging;

    if (shouldPlay && !_animationController.isAnimating) {
      _animationController.forward();
    } else if (!shouldPlay && _animationController.isAnimating) {
      _animationController.stop();
    }
  }

  void _startAnimation() {
    final item = widget.items[_currentUserIndex];
    final imageIndex = _currentStoryImageIndex[_currentUserIndex];
    if (imageIndex < item.storyPagesImages.length) {
      final duration = imageIndex < item.storyPageDuration.length
          ? item.storyPageDuration[imageIndex]
          : const Duration(seconds: 3);

      _animationController.duration = duration.inMilliseconds == 0 ? const Duration(milliseconds: 10) : duration;
      _animationController.forward(from: 0);
    }
  }

  void _nextStory() {
    final item = widget.items[_currentUserIndex];
    final imageIndex = _currentStoryImageIndex[_currentUserIndex];

    if (imageIndex < item.storyPagesImages.length - 1) {
      setState(() => _currentStoryImageIndex[_currentUserIndex]++);
      _startAnimation();
    } else {
      if (_currentUserIndex < widget.items.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  void _previousStory() {
    final imageIndex = _currentStoryImageIndex[_currentUserIndex];

    if (imageIndex > 0) {
      setState(() => _currentStoryImageIndex[_currentUserIndex]--);
      _startAnimation();
    } else {
      if (_currentUserIndex > 0) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _startAnimation();
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _dragOffset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: (details) {
          _dragOffset.value += details.delta.dy;
          _updateTimerState();
        },
        onVerticalDragEnd: (_) {
          if (_dragOffset.value.abs() > 150) {
            Navigator.of(context).pop();
          } else {
            _dragOffset.value = 0.0;
            _updateTimerState();
          }
        },
        child: ValueListenableBuilder<double>(
          valueListenable: _dragOffset,
          builder: (context, offset, child) {
            final dragFactor = offset.abs();
            final isDragging = dragFactor > 0;
            final scale = (1 - (dragFactor / 1000)).clamp(0.8, 1.0);
            final opacity = (1 - (dragFactor / 500)).clamp(0.0, 1.0);
            final radius = (dragFactor / 200 * 32).clamp(0.0, 32.0);

            return ColoredBox(
              color: Colors.black.withValues(alpha: opacity),
              child: Transform.translate(
                offset: Offset(0, offset),
                child: Transform.scale(
                  scale: scale,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: isDragging ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _currentUserIndex = index;
                          _currentStoryImageIndex[index] = 0;
                        });
                        _startAnimation();
                      },
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final currentImageIndex = _currentStoryImageIndex[index];

                        if (item.storyPagesImages.isEmpty) {
                          return const SizedBox();
                        }

                        if ((index - _currentUserIndex).abs() > 1) {
                          return const SizedBox.shrink();
                        }

                        final imageUrl = item.storyPagesImages[currentImageIndex];

                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            var delta = 0.0;
                            if (_pageController.position.haveDimensions) {
                              delta = _pageController.page! - index;
                            } else {
                              delta = (_currentUserIndex - index).toDouble();
                            }

                            final rotation = delta.clamp(-1.0, 1.0) * (math.pi / 2);

                            return Transform(
                              alignment: delta > 0 ? Alignment.centerRight : Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(rotation),
                              child: child,
                            );
                          },
                          child: Listener(
                            onPointerDown: (details) {
                              _pointerDownTime = DateTime.now();
                              _pointerDownPosition = details.position;
                              _isHolding = true;
                              _updateTimerState();
                            },
                            onPointerUp: (details) {
                              _isHolding = false;
                              _updateTimerState();

                              if (_pointerDownTime != null && _pointerDownPosition != null) {
                                final duration = DateTime.now().difference(_pointerDownTime!);
                                final distance = (details.position - _pointerDownPosition!).distance;

                                final screenWidth = MediaQuery.of(context).size.width;
                                final isCloseButtonArea =
                                    details.position.dy < 120 && details.position.dx > screenWidth - 80;

                                if (duration.inMilliseconds < 250 && distance < 20 && !isCloseButtonArea) {
                                  if (details.position.dx < screenWidth / 3) {
                                    _previousStory();
                                  } else {
                                    _nextStory();
                                  }
                                }
                              }
                            },
                            onPointerCancel: (_) {
                              _isHolding = false;
                              _updateTimerState();
                            },
                            child: SafeArea(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, err) =>
                                          const Center(child: Icon(Icons.error, color: Colors.white)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    child: Row(
                                      children: List.generate(
                                        item.storyPagesImages.length,
                                        (i) => Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2),
                                            child: _StoryProgressIndicator(
                                              isActive: i == currentImageIndex,
                                              isPassed: i < currentImageIndex,
                                              controller: _animationController,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 30,
                                    left: 10,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: CachedNetworkImageProvider(item.cardImageLink),
                                          radius: 20,
                                          backgroundColor: Colors.grey.shade800,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            item.cardLabel.replaceAll('\n', ' '),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 4,
                                                  color: Colors.black54,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close, color: Colors.white),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StoryProgressIndicator extends StatelessWidget {
  const _StoryProgressIndicator({
    required this.isActive,
    required this.isPassed,
    required this.controller,
  });

  final bool isActive;
  final bool isPassed;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.5,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(1.5),
      ),
      child: isActive
          ? AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: controller.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                );
              },
            )
          : isPassed
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.5),
              ),
            )
          : null,
    );
  }
}
