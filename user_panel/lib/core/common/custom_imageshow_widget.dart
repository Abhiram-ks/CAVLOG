import 'package:flutter/cupertino.dart';

Image imageshow({required String imageUrl,required String imageAsset}) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
       if (loadingProgress != null) {
        return const Center(
          child: CupertinoActivityIndicator(
            radius: 18.0, 
            animating: true,
          ),
        );
      }
      return child;
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