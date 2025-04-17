import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetch_barber_details_bloc/fetch_barber_details_bloc.dart';
import 'package:user_panel/core/utils/image/app_images.dart';
import '../../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../../core/common/custom_lottie_widget.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../provider/cubit/tab_cubit/tab_cubit.dart';
import '../../../../widget/search_widget/details_scree_widget/details_imagescroll_widget.dart';
import '../../../../widget/search_widget/details_scree_widget/details_top_portion_widget.dart';

class DetailBarberScreen extends StatefulWidget {
  final BarberModel barber;
  final List<String>? imageList;
  const DetailBarberScreen({super.key, required this.barber, this.imageList});

  @override
  State<DetailBarberScreen> createState() => _DetailBarberScreenState();
}

class _DetailBarberScreenState extends State<DetailBarberScreen> {
  late final List<String> imageList;
  @override
  void initState() {
    super.initState();
    imageList = widget.imageList ?? [widget.barber.image ?? AppImages.barberEmpty, AppImages.splashImage];

    context.read<FetchBarberDetailsBloc>().add(FetchBarberServicesRequested(widget.barber.uid));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return Scaffold(
            body: Column(
              children: [
                ImageScolingWidget(
                    imageList: imageList,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth),
                DetailTopPortionWidget(screenWidth: screenWidth, widget: widget),ConstantWidgets.hight30(context),
                BlocProvider(
                  create: (context) => TabCubit(),
                  child: Expanded(
                    child: Column(
                      children: [
                        BlocBuilder<TabCubit, int>(
                          builder: (context, selectedIndex) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(3, (index) {
                                final tabs = ['Post', 'Services', 'Schedule'];
                                return GestureDetector(
                                  onTap: () =>  context.read<TabCubit>().changeTab(index),
                                  child: Column(
                                    children: [
                                      Text(tabs[index],
                                        style: TextStyle(
                                          fontWeight:selectedIndex == index ? FontWeight.w900 : FontWeight.bold,
                                          color: selectedIndex == index ? Colors.black : Colors.grey,
                                        ),
                                      ),
                                      ConstantWidgets.hight20(context)
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
                                 DetailPostWidget(screenWidth: screenWidth,),
                                 DetilServiceWidget(screenWidth: screenWidth,),
                                 DetailSchedleWidet(screenWidth: screenWidth,)
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
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.09),
              child: ButtonComponents.actionButton(
                screenWidth: screenWidth,
                onTap: () {},
                label: 'Booking Now',
                screenHeight: screenHeight,
              ),
            ));
      },
    );
  }
}


class DetailSchedleWidet extends StatelessWidget {
  final double screenWidth;
  const DetailSchedleWidet({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final List<String> tags = [
      '09: 15 AM',
      '11: 20 AM',
      '12: 00 AM',
      '01: 15 PM',
      '02: 45 PM',
      '05: 30 PM',
      '07: 00 PM',
    ];

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
      child: Wrap(
        spacing: 10,
        runSpacing: 10, 
        children: tags
            .map((tag) => SheduleTagsWidget(text: tag))
            .toList(),
      ),
    );
  }
}


class SheduleTagsWidget extends StatelessWidget { 
  final String text;
  const SheduleTagsWidget({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    
        return Container(
          decoration: BoxDecoration(
            color: AppPalette.scafoldClr,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:   AppPalette.hintClr,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(text, style: TextStyle(fontSize: 18, color:  AppPalette.greyClr)),
        );
  }
}


















class DetilServiceWidget extends StatelessWidget {
  final double screenWidth;
  const DetilServiceWidget({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBarberDetailsBloc, FetchBarberDetailsState>
    (builder: (context, state) {
      if (state is FetchBarberServicesLoading || state is FetchBarberServicesFailure) {
        Center(
          child: CupertinoActivityIndicator(
            
              radius: 16.0, 
              animating: true,
            ),
        );
      } else if (state is FetchBarberServiceSuccess) {
       final services = state.barberServices;

       return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: screenWidth * .08),
          child: Column(
            children: [
              ListView.separated(
                itemCount: services.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text( service.serviceName,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                               Text( "₹ ",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppPalette.greenClr),
                          ),
                           Text( "${service.amount} ",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          )
                            ],
                          )
                          
                    ],
                  );
                }, 
                separatorBuilder: (context, index) => ConstantWidgets.hight10(context), 
                )
            ],
          ),
          ),
          
       );
      }else if (state is FetchBarberServicesEmpty) {
        return Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieFilesCommon.load(
                        assetPath: LottieImages.emptyData,
                        width: screenWidth * .25,
                        height: screenWidth * .25),
              Text('No services available'),
            ],
          ),
        );
      }
       return    Center(
         child: CupertinoActivityIndicator(
              radius: 16.0, 
              animating: true,
            ),
       );
    },);
  }
}

 

class DetailPostWidget extends StatelessWidget {
  final double screenWidth;
  const DetailPostWidget({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
      'https://tse4.mm.bing.net/th/id/OIP.Gb0Rps4_4JrfkVga1BNrLQHaE7?rs=1&pid=ImgDetMain',
    ];

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .01),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(imageList.length, (index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.network(
                    imageList[index],
                    fit: BoxFit.cover,
                  ),
                );
              }),
            ),
          ),
            ConstantWidgets.hight50(context)
        ],
      ),
    );
  }
}
