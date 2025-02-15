import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl, width: double.infinity, fit: BoxFit.fitWidth);
  }
}

class HeroLayoutCard extends StatefulWidget {
  const HeroLayoutCard({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  State<HeroLayoutCard> createState() => _HeroLayoutCardState();
}

class _HeroLayoutCardState extends State<HeroLayoutCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return OverflowBox(
      maxWidth: width * 7 / 8,
      minWidth: width * 7 / 8,
      child: CachedNetworkImage(imageUrl: widget.imageUrl, width: double.infinity, fit: BoxFit.fitWidth),
    );
  }
}
