  import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/material.dart';

Image imageshow({required String imageUrl,required String imageAsset}) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
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
        );
      },
    );
  }