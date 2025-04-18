import 'package:barber_pannel/cavlog/app/presentation/widgets/settings_widget/service_management_widget/service_editandupdate_state_handle.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/settings_widget/service_management_widget/service_management_filed_widget.dart';
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/lottie_widget.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/image/app_images.dart';
import '../../../provider/bloc/barber_service_modification_bloc/barber_service_modeification_bloc.dart';
import '../../../provider/bloc/fetch_barber_service_bloc/fetch_barber_service_bloc.dart';

BlocBuilder<FetchBarberServiceBloc, FetchBarberServiceState> barberServiceBuilder(double screenWidth, double screenHeight) {
    return BlocBuilder<FetchBarberServiceBloc, FetchBarberServiceState>(
                        builder: (context, state) {
                          if (state is FetchBarberServiceLoading || state is FetchBarberServiceError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CupertinoActivityIndicator(
                                    radius: 16.0, 
                                  ),ConstantWidgets.hight10(context),
                                  Text('Loading services...',style: TextStyle(color: AppPalette.greyClr),)
                                ],
                              ),
                            );
                          }
                           else if (state is FetchBarberServiceSuccess) {
                           
                            return BlocListener<BarberServiceModeificationBloc, BarberServiceModeificationState>(
                              listener: (context, state) {
                                handleServiceEditAndUpdaTeState( context, state);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(  horizontal: screenWidth * 0.08),
                                child: Column(
                                  children: state.services.map((service) {
                                    return ServiceManagementFiled(
                                      context: context,
                                      screenWidth: screenWidth,
                                      label: service.serviceName,
                                      serviceRate:service.amount.toStringAsFixed(0),
                                      deleteAction: () {
                                        context.read<BarberServiceModeificationBloc>() .add(FetchBarberServicDeleteRequestEvent( barberUid: service.barberId, serviceKey:service.serviceName));
                                      },
                                     updateAction: (value) {
                                         context.read<BarberServiceModeificationBloc>().add( FetchBarberServiceUpdateRequestEvent( barberUid: service.barberId,
                                         serviceKey: service.serviceName,serviceValue: value, oldServiceValue: service.amount,
                                         ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          } else if (state is FetchBarberServiceEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LottiefilesCommon( assetPath: LottieImages.emptyData, width: screenWidth * 0.5,  height: screenHeight * .3),
                                  Text('No services added yet!.')
                                ],
                              ),
                            );
                          }           return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CupertinoActivityIndicator(
                                    radius: 16.0, 
                                  ),ConstantWidgets.hight10(context),
                                  Text('Loading services...',style: TextStyle(color: AppPalette.greyClr),)
                                ],
                              ),
                            );
                        },
                      );
  }