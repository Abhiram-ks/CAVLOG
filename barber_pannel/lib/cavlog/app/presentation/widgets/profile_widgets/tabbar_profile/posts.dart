import 'package:flutter/material.dart';

import '../../../../../../core/utils/image/app_images.dart';

class TabbarImageShow extends StatelessWidget {
  const TabbarImageShow({super.key,});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.zero, 
                ),
                child: Image.asset(
                  AppImages.splashImage,
                  fit: BoxFit.cover, 
                ),
              );
            },
     );
  }
}