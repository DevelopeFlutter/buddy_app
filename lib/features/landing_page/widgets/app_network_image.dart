import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imgPath;
  const AppNetworkImage({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        
        imgPath,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}
