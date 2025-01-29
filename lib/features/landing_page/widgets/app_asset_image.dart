import 'package:flutter/material.dart';

class AppAssetImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;

  const AppAssetImage({
    super.key,
    required this.imagePath,
    this.width = 24,
    this.height = 24,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
