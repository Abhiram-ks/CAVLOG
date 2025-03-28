import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';

class BannerBuilderWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String title;
  final int number;
  final List<String> imageWidgets;
  final Function(String url, int index, int imageIndex) onDoubleTap;

  const BannerBuilderWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.title,
    required this.number,
    required this.imageWidgets,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstantWidgets.hight20(context),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.25,
          width: screenWidth * 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageWidgets.length,
              itemBuilder: (context, imageIndex) {
                final imageUrl = imageWidgets[imageIndex];
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  hoverColor: AppPalette.whiteClr,
                  onLongPress: () {
                    onDoubleTap(imageUrl, number, imageIndex);
                  },
                  child: Container(
                       height: screenHeight * 0.25,
                      width: screenWidth * 0.87,
                    decoration: BoxDecoration(
                    color: AppPalette.trasprentClr,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
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
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.photo,
                                color: AppPalette.greyClr,
                                size: 50,
                              ),
                              Text('Oops! Image load failed...',style: TextStyle(color: AppPalette.blackClr),)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
