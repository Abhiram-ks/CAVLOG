import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator, CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/common_action_button.dart';
import '../../../../../../core/common/textfield_helper.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../../../core/validation/input_validations.dart';
import '../../../provider/bloc/image_picker/image_picker_bloc.dart';

class TabbarAddPost extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final String barberId;
  final ScrollController scrollController;
  const TabbarAddPost({
    required this.barberId,
    required this.scrollController,
    required this.screenWidth,
    required this.screenHeight,
    super.key,
  });

  @override
  State<TabbarAddPost> createState() => _TabbarAddPostState();
}

class _TabbarAddPostState extends State<TabbarAddPost> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * .05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ConstantWidgets.hight30(context),
            InkWell(
              onTap: () {
                context.read<ImagePickerBloc>().add(PickImageAction());
              },
              child: DottedBorder(
                color: AppPalette.greyClr,
                strokeWidth: 1,
                dashPattern: [4, 4],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: SizedBox(
                    width: widget.screenWidth * 0.9,
                    height: widget.screenHeight * 0.23,
                    child: SizedBox(
                        width: widget.screenWidth * 0.89,
                        height: widget.screenHeight * 0.22,
                        child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                          builder: (context, state) {
                            if (state is ImagePickerLoading){
                              return const CupertinoActivityIndicator(radius: 16.0,  );
                            } else if (state is ImagePickerSuccess) {
                               return ClipRRect(
                               borderRadius: BorderRadius.circular(12),
                               child: Image.file(
                               File(state.imagePath),
                               width: widget.screenWidth * 0.89,
                               height: widget.screenHeight * 0.22,
                               fit: BoxFit.cover,
                               ));
                            }else if (state is ImagePickerError) {
                               return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Icon(  CupertinoIcons.photo,size: 35, color:AppPalette.redClr,
                                ), Text(state.errorMessage)
                               ]);
                            }
                            return Column(
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
                            );
                          },
                        ))),
              ),
            ), ConstantWidgets.hight20(context),
            Focus(
                onFocusChange: (hasFocus) {
                  widget.scrollController.animateTo(widget.screenHeight * 0.3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: TextFormFieldWidget(
                    label: 'Description',
                    hintText: 'Description for your post',
                    prefixIcon: Icons.photo_size_select_large_sharp,
                    controller: _descriptionController,
                    validate: ValidatorHelper.validateText)),
            ConstantWidgets.hight10(context),
            ActionButton(
                screenWidth: widget.screenWidth,
                onTap: () {},
                label: 'Upload',
                screenHight: widget.screenHeight)
          ],
        ),
      ),
    );
  }
}
