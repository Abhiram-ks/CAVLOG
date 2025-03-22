import 'package:admin/core/common/lottie_widget.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/images/app_images.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/toggleview/toggleview_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/manage_barbers_widget/requst_bloc_builder.dart';

class ManageBarberScreen extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ManageBarberScreen({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstantWidgets.hight10(context),
            SearchAndFilter(),
            ConstantWidgets.hight10(context),
               BlocBuilder<ToggleviewBloc, ToggleviewState>(
                builder: (context, state) {
                  return Align(
                   alignment: Alignment.centerLeft,
                    child: Text(
                      state is ToggleviewStatus ? 'Barbers Status' : 'Requests',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  );
                },
              ),
            Expanded(
              child: BlocBuilder<ToggleviewBloc, ToggleviewState>(
                builder: (context, state) {
                  return state is ToggleviewStatus
                      ? Center(
                          child: LottiefilesCommon(assetPath: AppLottieImages.networkError, width:screenWidth*.5  , height: screenHeight *.5),
                        )
                      : RequstBlocBuilder(screenHeight: screenHeight, screenWidth: screenWidth);
                },
              ),
            )
          ],
        ),
      );
    });
  }
}



class RequestCardWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String barbername;
  final String emailId;
  final String phoneNumber;
  final String address;
  final String postive;
  final String imagePath;
  final String time;
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
    required this.time,
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
                    child: Image.asset(
                      imagePath,
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
                      Text(time, style: TextStyle(color: AppPalette.hintClr))
                    ],
                  ))
            ],
          ),
        ));
  }
}

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 16),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                hintText: 'Search..',
                hintStyle: TextStyle(color: AppPalette.hintClr),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: const Color.fromARGB(255, 52, 52, 52),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppPalette.hintClr, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: AppPalette.hintClr, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppPalette.redClr,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppPalette.redClr,
                    width: 1,
                  ),
                )),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: AppPalette.mainClr,
              borderRadius: BorderRadius.circular(14)),
          child: IconButton(
              splashColor: Colors.white,
              highlightColor: AppPalette.buttonClr,
              focusColor: AppPalette.greenClr,
              onPressed: () {
                context.read<ToggleviewBloc>().add(ToggleviewAction());
              },
              icon: Icon(
                CupertinoIcons.arrow_2_circlepath,
                color: AppPalette.whiteClr,
              )),
        )
      ],
    );
  }
}
