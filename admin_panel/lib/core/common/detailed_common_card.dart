import 'package:admin/core/utils/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../utils/media_quary/constant/constant.dart';

class RequestCardWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String barbername;
  final String emailId;
  final String phoneNumber;
  final String address;
  final String postive;
  final String imagePath;
  final String? time;
  final bool? isBlock;
  final Function() onPostive;
  final String negative;
  final Function() onNegative;

  const RequestCardWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.barbername,
    required this.emailId,
    required this.phoneNumber,
    required this.address,
    required this.postive,
    required this.onPostive,
    required this.negative,
    required this.onNegative,
    required this.imagePath,
    this.time,
    this.isBlock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border:
                Border.all(color: const Color.fromARGB(255, 242, 242, 242))),
        height: screenHeight * .15,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * .01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: imagePath.startsWith("http")
                        ? Image.network(
                            imagePath,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppPalette.buttonClr,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppPalette.greyClr,
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            AppImages.loginImageAbove,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              ConstantWidgets.width20(context),
              Flexible(
                  flex: 4,
                  child: SizedBox(
                    width: screenWidth * 1,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barbername,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            emailId,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            phoneNumber,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )),
              ConstantWidgets.width20(context),
              Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == postive) {
                            onPostive();
                          } else if (value == negative) {
                            onNegative();
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: postive,
                            child: Text(postive),
                          ),
                          PopupMenuItem(
                            value: negative,
                            child: Text(negative),
                          ),
                        ],
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            CupertinoIcons.ellipsis_vertical,
                            color: AppPalette.greyClr,
                          ),
                        ),
                      ),
                      if (time != null)
                        Text(
                          time!,
                          style: TextStyle(color: AppPalette.hintClr),
                        )
                      else if (isBlock != null)
                        isBlock!
                            ? Text("Blocked",
                                style: TextStyle(
                                  color: AppPalette.redClr,
                                ))
                            : Text(
                                'Active',
                                style: TextStyle(color: AppPalette.greenClr),
                              )
                    ],
                  ))
            ],
          ),
        ));
  }
}
