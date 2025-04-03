import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import '../../../../../../core/common/action_button.dart';
import '../../../../../../core/common/textfield_helper.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../../../core/validation/input_validations.dart';

class TabbarAddPost extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final ScrollController scrollController;
   const TabbarAddPost({
    required this.scrollController,
    required this.screenWidth,
    required this.screenHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding:  EdgeInsets.symmetric(horizontal:screenWidth*.05),
        child: SingleChildScrollView(
          child: Column(
              children: [
                ConstantWidgets.hight30(context),
                InkWell(
                  onTap: (){},
                  child: DottedBorder(
                    color: AppPalette.greyClr,
                    strokeWidth: 1,
                    dashPattern: [4,4],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    child: SizedBox(
                     width: screenWidth * 0.9,
                    height: screenHeight * 0.23,
                    child:SizedBox(
                      width: screenWidth * 0.89,
                      height: screenHeight * 0.22,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.cloud_upload,
                            size: 35,
                            color: AppPalette.buttonClr,
                          ),
                          Text('Upload an Image')
                        ],
                      ))
                    ),
                    ),
                ),
               ConstantWidgets.hight20(context),
                Focus(
                  onFocusChange: (hasFocus) {
                    scrollController.animateTo(
                      screenHeight * 0.3,
                      duration:  const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                  child: TextFormFieldWidget(label: 'Description', hintText: 'Description for your post', prefixIcon: Icons.photo_size_select_large_sharp, controller: TextEditingController(), validate: ValidatorHelper.validateText)),
                ConstantWidgets.hight10(context),
                ActionButton(screenWidth: screenWidth, onTap: (){}, label: 'Upload', screenHight: screenHeight)
              ],
          ),
        ),
      );
  }
}


