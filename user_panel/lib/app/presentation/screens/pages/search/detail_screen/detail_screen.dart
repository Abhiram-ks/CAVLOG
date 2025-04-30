import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetching_bloc/fetch_barber_bloc/fetch_barber_id_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetching_bloc/fetch_barber_details_bloc/fetch_barber_details_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetching_bloc/fetch_posts_bloc/fetch_posts_bloc.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/utils/image/app_images.dart';
import '../../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../provider/cubit/tab_cubit/tab_cubit.dart';
import '../../../../widget/search_widget/details_screen_widget/details_imagescroll_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_loading_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_post_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_services_buld_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_top_portion_widget.dart';
import '../../../../widget/search_widget/rating_review_widget/reviews_rating_widget.dart';

class DetailBarberScreen extends StatefulWidget {
  final String barberId;
  const DetailBarberScreen({
    super.key,
    required this.barberId,
  });

  @override
  State<DetailBarberScreen> createState() => _DetailBarberScreenState();
}

class _DetailBarberScreenState extends State<DetailBarberScreen> {
  late final List<String> imageList;
  @override
  void initState() {
    super.initState();
    context.read<FetchBarberIdBloc>().add(FetchBarberDetailsAction(widget.barberId));
    context.read<FetchPostsBloc>().add(FetchPostRequest(barberId: widget.barberId));
    context.read<FetchBarberDetailsBloc>().add(FetchBarberServicesRequested(widget.barberId));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return Scaffold(
            body: BlocBuilder<FetchBarberIdBloc, FetchBarberIdState>(
              builder: (context, state) {
                log('Fetch barber state is like : $state');
                if (state is FetchBarberDetailsLoading ||
                    state is FetchBarberDetailsFailure) {
                  BarberModel barber = BarberModel(
                      uid: '',
                      barberName: 'barberNamei',
                      ventureName: 'Cavlog - Executing smarter, Manaing better',
                      phoneNumber: 'phoneNumber',
                      address:'221B Baker street Santa clau 101 saint NIcholas Dive North Pole, Landon -  99705',
                      email: 'cavlogenoia@gmail.com',
                      isVerified: true,
                      isblok: false);
                  return detailshowWidgetLoading( barber, screenHeight, screenWidth, context);
                } else if (state is FetchBarberDetailsSuccess) {
                  final barber = state.barberServices;
                  return Column(
                    children: [
                      ImageScolingWidget(imageList: [ barber.image ?? AppImages.barberEmpty, barber.detailImage ?? AppImages.barberEmpty], screenHeight: screenHeight, screenWidth: screenWidth),
                      DetailTopPortionWidget(screenWidth: screenWidth, barber: barber),
                      ConstantWidgets.hight30(context),
                      BlocProvider(
                        create: (context) => TabCubit(),
                        child: Expanded(
                          child: Column(
                            children: [
                              BlocBuilder<TabCubit, int>(
                                builder: (context, selectedIndex) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(3, (index) {
                                      final tabs = [ 'Post', 'Services', 'review'];
                                      return GestureDetector(
                                        onTap: () => context.read<TabCubit>().changeTab(index),
                                        child: Column(
                                          children: [
                                            Text(
                                              tabs[index],
                                              style: TextStyle(
                                                fontWeight:selectedIndex == index ? FontWeight.w900: FontWeight.bold,
                                                color: selectedIndex == index ? Colors.black: Colors.grey,
                                              ),
                                            ), ConstantWidgets.hight20(context)
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                              Expanded(
                                child: BlocBuilder<TabCubit, int>(
                                  builder: (context, selectedIndex) {
                                    return IndexedStack(
                                      index: selectedIndex,
                                      children: [
                                        DetailPostWidget(),
                                        DetilServiceWidget( screenWidth: screenWidth),
                                        DetailsReviewWidget(
                                          barber: barber, screenHight: screenHeight,screenWidth: screenWidth,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
                return detailshowWidgetLoading(
                    BarberModel( uid: '', barberName: 'barberNamei',ventureName:'Cavlog - Executing smarter, Manaing better',phoneNumber: 'phoneNumber',address:'221B Baker street Santa clau 101 saint NIcholas Dive North Pole, Landon -  99705',email: 'cavlogenoia@gmail.com',isVerified: true, isblok: false), screenHeight,screenWidth,context);
              },
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.09),
              child: ButtonComponents.actionButton(
                screenWidth: screenWidth,
                onTap: () => Navigator.pushNamed(context, AppRoutes.booking,arguments: widget.barberId),
                label: 'Booking Now',
                screenHeight: screenHeight,
              ),
            ));
      },
    );
  }
}

