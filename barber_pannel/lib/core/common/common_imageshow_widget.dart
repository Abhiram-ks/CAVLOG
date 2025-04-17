import 'package:flutter/material.dart';
import '../themes/colors.dart';

Image imageshow({required String imageUrl,required String imageAsset}) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
          height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: AppPalette.buttonClr,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          imageAsset,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
    );
  }