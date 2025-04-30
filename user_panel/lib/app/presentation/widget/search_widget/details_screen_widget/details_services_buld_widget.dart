


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../provider/bloc/fetching_bloc/fetch_barber_details_bloc/fetch_barber_details_bloc.dart';

class DetilServiceWidget extends StatelessWidget {
  final double screenWidth;
  const DetilServiceWidget({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBarberDetailsBloc, FetchBarberDetailsState>
    (builder: (context, state) {
      if (state is FetchBarberServicesLoading || state is FetchBarberServicesFailure) {
        Center(
          child: CupertinoActivityIndicator( radius: 16.0, animating: true),
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
                      Text( service.serviceName,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                          Row(
                            children: [
                               Text( "₹ ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppPalette.greenClr)),
                               Text( "${service.amount} ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
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
              Icon(Icons.face_retouching_natural, size: 50,),
              ConstantWidgets.hight20(context),
              Text('Still waiting for that first style.'),
            ],
          ),
        );
      }
       return   Center(
         child: CupertinoActivityIndicator( radius: 16.0, animating: true ),
       );
    },);
  }
}
