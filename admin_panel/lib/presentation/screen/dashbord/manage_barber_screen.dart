
import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/presentation/provider/bloc/toggleview/toggleview_bloc.dart';
import 'package:admin/presentation/widget/manage_barbers_widget/barbers_status/barbers_status_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/manage_barbers_widget/requests/requst_bloc_builder.dart';

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
                      ? BarbersStatusBuilder(screenHeight: screenHeight, screenWidth: screenWidth)
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
