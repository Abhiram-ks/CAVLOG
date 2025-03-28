import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/fetchbannerbarber/fetch_banner_barber_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetchuserbanner/fetch_user_banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widget/banner_widget/image_uploading_widget.dart';
class BannerManagement extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const BannerManagement(
      {super.key, required this.screenHeight, required this.screenWidth});

  Future<void> _refreshContent(BuildContext context) async {
    context.read<FetchUserBannerBloc>().add(FetchUserBannerAction());
    context.read<FetchBannerBarberBloc>().add(FetchBarberBannerAction());
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        child: RefreshIndicator(
          onRefresh:()=>_refreshContent(context),
          displacement: 50.0,
          backgroundColor: AppPalette.buttonClr,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: AppPalette.whiteClr,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ImagePickAndUploadWidget(screenWidth: screenWidth, screenHeight: screenHeight),
          ),
        ),
      );
    });
  }
}

