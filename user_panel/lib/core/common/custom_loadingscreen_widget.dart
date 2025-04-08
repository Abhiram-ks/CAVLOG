
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(
          top: screenHeight * .025, left:  screenWidth * 0.03,
          right: screenWidth * 0.03,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300] ?? AppPalette.greyClr,
          highlightColor: AppPalette.whiteClr,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.025),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenWidth * 0.24,
                      width: screenWidth * 0.24,
                      decoration: BoxDecoration(
                        color: AppPalette.hintClr,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              color: AppPalette.hintClr,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.012),
                          Container(
                            height: 14,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                              color: AppPalette.hintClr,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.012),
                          Row(
                            children: [
                              Container(
                                height: 14,
                                width: screenWidth * 0.2,
                                decoration: BoxDecoration(
                                  color: AppPalette.hintClr,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Container(
                                height: 14,
                                width: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  color: AppPalette.hintClr,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
  }
}