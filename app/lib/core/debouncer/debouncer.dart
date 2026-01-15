import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;
  Timer? _timer;
  VoidCallback? _callback;

  void debounce(VoidCallback callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(delay, flush);
  }

  void flush() {
    _callback?.call();
    _timer = null;
  }

  void dispose() {
    _timer?.cancel();
  }
}
