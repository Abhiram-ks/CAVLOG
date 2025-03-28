import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/presentation/provider/bloc/barber_status/barberstatus_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetchbarbers/fetch_barbers_bloc.dart';
import 'package:admin/presentation/widget/manage_barbers_widget/barbers_status/handle_status_response_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/common/detailed_common_card.dart';
import '../../../../core/common/lottie_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/images/app_images.dart';

class BarbersStatusBuilder extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const BarbersStatusBuilder(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarberstatusBloc, BarberstatusState>(
      listener: (context, state) {
        handStatusResponseState(context, state);
      },
      child: BlocBuilder<FetchBarbersBloc, FetchBarbersState>(
        builder: (context, state) {
          if (state is FetchBarbersInitial) {
            return Center(
                child: SpinKitFadingFour(
              color: AppPalette.greyClr,
              size: 23.0,
            ));
          } else if (state is BarberNoNetworkState) {
            return Center(
              child: LottiefilesCommon(
                  assetPath: AppLottieImages.networkError,
                  width: screenWidth * .5,
                  height: screenHeight * .5),
            );
          } else if (state is BarberEmptyState) {
            return Center(
              child: LottiefilesCommon(
                  assetPath: AppLottieImages.emptyData,
                  width: screenWidth * .5,
                  height: screenHeight * .5),
            );
          } else if (state is BarberLoadedState) {
            final registedBarbers = state.barbers
                .where((barber) => barber.isVerified == true)
                .toList();

            if (registedBarbers.isEmpty) {
              return LottiefilesCommon(
                  assetPath: AppLottieImages.emptyData,
                  width: screenWidth * .5,
                  height: screenHeight * .5);
            }
            return ListView.separated(
              itemCount: registedBarbers.length,
              itemBuilder: (context, index) {
                final barber = registedBarbers[index];
                return RequestCardWidget(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  barbername: barber.barberName,
                  emailId: barber.email,
                  phoneNumber: barber.phoneNumber,
                  address: barber.address,
                  postive: 'UnBlock',
                  onPostive: () {
                    if (barber.isBlocked) {
                      context
                          .read<BarberstatusBloc>()
                          .add(ShowUnblockAlert(uid: barber.uid));
                    } else {
                      CustomeSnackBar.show(
                        context: context,
                        title: 'Barber Already Active',
                        description:
                            'The barber ${barber.barberName} is already active. Unblock is not required.',
                        iconColor: AppPalette.greenClr,
                        icon: CupertinoIcons.check_mark_circled,
                      );
                    }
                  },
                  negative: 'Block',
                  onNegative: () {
                    if (barber.isBlocked) {
                      CustomeSnackBar.show(
                        context: context,
                        title: 'Barber Already Blocked',
                        description: 'The barber ${barber.barberName} is already blocked. No further action is required as blocking has already been performed.',
                          iconColor: AppPalette.redClr,
                       icon: CupertinoIcons.hand_raised_fill,
                      );
                    } else {
                       context
                          .read<BarberstatusBloc>()
                          .add(ShowBlockAlert(uid: barber.uid));
                    }
                  },
                  imagePath:barber.image ?? '',
                  isBlock: barber.isBlocked,
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 6,
              ),
            );
          } else if (state is BarberErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Unknown State'));
        },
      ),
    );
  }
}
