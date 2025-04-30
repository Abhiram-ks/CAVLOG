import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/presentation/screens/pages/search/detail_screen/detail_screen.dart';
import 'package:user_panel/app/presentation/widget/search_widget/search_screen_widget/custom_cards_barberlist.dart';
import '../../../../../core/common/custom_loadingscreen_widget.dart';
import '../../../../../core/common/custom_lottie_widget.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../../data/models/barber_model.dart';
import '../../../provider/bloc/fetching_bloc/fetch_allbarber_bloc/fetch_allbarber_bloc.dart';

class BarberListBuilder extends StatelessWidget {
  const BarberListBuilder({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllbarberBloc, FetchAllbarberState>(
      builder: (context, state) {
        if (state is FetchAllbarberLoading || state is FetchAllbarberFailure) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * .7,
              child: LoadingScreen(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
          );
        } else if (state is FetchAllbarberEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: LottieFilesCommon.load(
                        assetPath: LottieImages.emptyData,
                        width: screenWidth * .5,
                        height: screenWidth * .5)),
                  Text('No matching shops found.')
              ],
            ),
          );
        } else if (state is FetchAllbarberSuccess) {
          final List<BarberModel> barbers = state.barbers;
    
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final barber = barbers[index];
                return Column(
                  children: [
                       ListForBarbers(
                        ontap: () {
                          FocusScope.of(context).unfocus();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBarberScreen(barberId: barber.uid,)));
                        },
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        imageURl: barber.image ?? AppImages.barberEmpty,
                        rating: barber.rating ?? 0.0,
                        shopName: barber.ventureName,
                        shopAddress: barber.address,
                        isBlocked: barber.isblok,
                      ),
                    if (index < barbers.length - 1)
                      ConstantWidgets.hight10(context),
                  ],
                );
              },
              childCount: barbers.length,
            ),
          );
        }
        return SliverToBoxAdapter(
          child: SizedBox(
            height: screenHeight * 0.7,
            child: LoadingScreen(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          ),
        );
      },
    );
  }
}
