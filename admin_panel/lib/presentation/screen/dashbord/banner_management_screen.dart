import 'dart:io';

import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/pick_image/pick_image_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BannerManagement extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const BannerManagement(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(child: BlocBuilder<PickImageBloc, PickImageState>(
                builder: (context, state) {
                  if (state is PickImageInitial) {
                    return InkWell(
                    onTap: () {
                     context.read<PickImageBloc>().add(ImagePickerEvent());
                    },
                    child: Icon(
                      CupertinoIcons.cloud_upload,
                      color: AppPalette.buttonClr,
                      size: 30,
                    ),
                  );
                  }else if(state is ImagePickerLoading){
                     return SpinKitFadingFour(
                    color: AppPalette.whiteClr,
                    size: 23.0,
                   ); 
                  }else if(state is ImagePickerSuccess){
                    return Image.file(
                       File(state.imagePath),
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.4,
                          fit: BoxFit.cover,
                    );
                  }else {
                    return const SizedBox.shrink();
                  }
                  
                },
              )),
            ],
          ),
        ),
      );
    });
  }
}
