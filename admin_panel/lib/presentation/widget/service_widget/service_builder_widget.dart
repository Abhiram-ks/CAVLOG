import 'package:admin/presentation/widget/service_widget/handle_service_state.dart';
import 'package:admin/presentation/widget/service_widget/service_tags_widget.dart';
import 'package:admin/presentation/widget/service_widget/upload_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/common/lottie_widget.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/images/app_images.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../provider/bloc/fetching_service/fetching_service_bloc.dart';
import '../../provider/bloc/service_management/service_mangement_bloc.dart';

class ServiceBuilderWidget extends StatelessWidget {
  const ServiceBuilderWidget({
    super.key,
    required this.widget,
  });

  final UploadServicesWidget widget;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceMangementBloc, ServiceMangementState>(
        listener: (context, state) {
      handSeviceState(context, state);
    }, child: BlocBuilder<FetchingServiceBloc, FetchingServiceState>(
      builder: (context, state) {
        if (state is FetchingServiceInitial) {
          return Center(
              child: SpinKitFadingFour(
            color: AppPalette.greyClr,
            size: 23.0,
          ));
        } else if (state is ServiceEmptyState) {
          return Center(
            child: LottiefilesCommon(
                assetPath: AppLottieImages.emptyData,
                width: widget.screenWidth * .5,
                height: widget.screenHight * .5),
          );
        } else if (state is ServiceLoadedState) {
          return Wrap(
              spacing: 4,
              runSpacing: 5,
              children: state.services.map((service) {
                return ServiceTagsWidget(
                    text: service.serviceName,
                    edit: () {
                      context.read<ServiceMangementBloc>().add(EditServiceEvent(serviceId: service.serviceId, serviceName: service.serviceName));
                    },
                    delete: () {
                      context.read<ServiceMangementBloc>().add(DeleteServiceEvent(service.serviceId));
                    });
              }).toList());
        } else if (state is ServiceFechingErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottiefilesCommon(
                  assetPath: AppLottieImages.emptyData,
                  width: widget.screenWidth * .5,
                  height: widget.screenHight * .5),
              ConstantWidgets.hight10(context),
              Text(state.error)
            ],
          );
        }
        return Center(child: Text('data'));
      },
    ));
  }
}
