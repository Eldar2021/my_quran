import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      fit: BoxFit.fitWidth,
    );
  }
}
