 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_panel/app/presentation/widget/search_widget/search_screen_widget/service_tags_widget.dart';
import '../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../core/common/custom_bottomsheet_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../provider/bloc/fetching_bloc/fetch_admin_service_bloc/adimin_service_bloc.dart';
import '../../../provider/bloc/fetching_bloc/fetch_allbarber_bloc/fetch_allbarber_bloc.dart';
import '../../../provider/cubit/filter_rating_cubit/filter_rating_cubit.dart';
import '../../../provider/cubit/gender_cubit/gender_option_cubit.dart';
import '../../../provider/cubit/select_service_cubit/select_service_cubit.dart';

Expanded serchFilterActionItems(double screenWidth, BuildContext context, double screenHeight) {
    return Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .03),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          BottomSheetHelper().showBottomSheet(
                            context: context,
                            title: 'Session Exception Warning!',
                            description:'Are you sure you want to clear the following filters? Tap "Allow" to continue.',
                            firstButtonText: 'Allow',
                            firstButtonAction: () {
                              context.read<SelectServiceCubit>().clearAll();
                              context .read<GenderOptionCubit>().selectGenderOption(null);
                              context.read<RatingCubit>().clearRating();
                              Navigator.pop(context);
                            },
                            firstButtonColor: AppPalette.blackClr,
                            secondButtonText: "Don't Allow",
                            secondButtonAction: () {
                              Navigator.of(context).pop();
                            },
                            secondButtonColor: AppPalette.blackClr,
                          );
                        },
                        child: Text('Clear Filters',style: TextStyle(fontWeight: FontWeight.bold))),
                  ), ConstantWidgets.hight20(context),
                  BlocBuilder<AdiminServiceBloc, AdiminServiceState>(
                    builder: (context, state) {
                      if (state is FetchServiceLoaded) {
                        final services = state.service;
                        return BlocBuilder<SelectServiceCubit, Set<String>>(
                          builder: (context, selectedServices) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Wrap(
                                spacing: 6,  runSpacing: 6,
                                children: List.generate(
                                  services.length,
                                  (index) {
                                    final serviceName = services[index].name;
                                    final isSelected = selectedServices.contains(serviceName);

                                    return serviceTags(
                                      onTap: () {
                                        context.read<SelectServiceCubit>().toggleService(serviceName);
                                      },
                                      text: serviceName,isSelected: isSelected,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                        highlightColor: AppPalette.whiteClr,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: List.generate(
                              10,
                              (index) {
                                final serviceName = 'Loading..';
                                final isSelected = false;

                                return serviceTags(
                                  onTap: () {},
                                  text: serviceName,
                                  isSelected: isSelected,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: BlocBuilder<RatingCubit, double>(
                      builder: (context, rating) {
                        return Center(
                          child: RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            glow: true,
                            unratedColor: AppPalette.hintClr,
                            glowColor: AppPalette.greyClr,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding:
                            EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(Icons.star, color: AppPalette.buttonClr),
                            onRatingUpdate: (value) {context.read<RatingCubit>().setRating(value);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  ConstantWidgets.hight20(context),
                  BlocBuilder<GenderOptionCubit, GenderOption?>(
                    builder: (context, selectedGender) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 2,
                        children: GenderOption.values.map((gender) {
                          Color activeColor;
                          String label;

                          switch (gender) {
                            case GenderOption.male:
                              activeColor = AppPalette.blueClr;
                              label = "Male";
                              break;
                            case GenderOption.female:
                              activeColor = Colors.pink;
                              label = "Female";
                              break;
                            case GenderOption.unisex:
                              activeColor = AppPalette.orengeClr;
                              label = "Unisex";
                              break;
                          }

                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<GenderOption>(
                                value: gender,
                                groupValue: selectedGender,
                                activeColor: activeColor,
                                onChanged: (value) {
                                  if (value != null) {
                                    context.read<GenderOptionCubit>().selectGenderOption(value);
                                  }
                                },
                              ),  Text(label),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                  ConstantWidgets.hight30(context),
                  ButtonComponents.actionButton(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      label: 'Apply',
                      onTap: () {
                        final selectedServices =context.read<SelectServiceCubit>().state;
                        final rating = context.read<RatingCubit>().state;
                        final gender =context.read<GenderOptionCubit>().state;

                        if (selectedServices.isEmpty && rating == 0.0 &&  gender == null) {
                          context.read<FetchAllbarberBloc>().add(FetchAllBarbersRequested());
                        } else {
                          context.read<FetchAllbarberBloc>().add(FilterBarbersRequested( 
                            selectServices: selectedServices,rating: rating, gender: gender?.name == 'unisex' ? null: gender?.name));
                        }
                      })
                ],
              ),
            ),
          ),
        );
  }