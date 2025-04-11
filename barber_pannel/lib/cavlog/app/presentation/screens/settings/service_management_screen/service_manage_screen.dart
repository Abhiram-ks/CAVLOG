import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/common/lottie_widget.dart';
import 'package:barber_pannel/core/common/textfield_helper.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:barber_pannel/core/validation/input_validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../data/repositories/fetch_barber_service_repo.dart';
import '../../../provider/bloc/fetch_barber_service_bloc/fetch_barber_service_bloc.dart';
import '../../../provider/cubit/edit_mode/edit_mode_cubit.dart';

class ServiceManageScreen extends StatelessWidget {
  const ServiceManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(  create: (context) => FetchBarberServiceBloc( repository: FetchBarberServiceRepositoryImpl())..add(FetchBarberServiceRequestEvent())),
        BlocProvider(create: (context) => EditModeCubit()),
      ],
 
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return ColoredBox(
            color: AppPalette.whiteClr,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Scaffold(
                  appBar: CustomAppBar(text: 'Edit', iconColor: AppPalette.blackClr,onPressed: () => context.read<EditModeCubit>().toggleEditMode(),),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( 'Service Management',
                              style: GoogleFonts.plusJakartaSans(
                              fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              ConstantWidgets.hight10(context),
                              const Text(
                              'Craft your perfect service lineup — add, update, or fine-tune offerings to match your brand’s style.'),
                              ConstantWidgets.hight30(context),             
                            ],
                          ),
                        ),
                        BlocBuilder<FetchBarberServiceBloc,
                            FetchBarberServiceState>(
                          builder: (context, state) {
                            if (state is FetchBarberServiceLoading ||
                                state is FetchBarberServiceError) {
                              return Center(
                                child:SpinKitFadingFour(
                             color: AppPalette.orengeClr,
                             size: 23.0,
                              ),
                              );
                            } else if (state is FetchBarberServiceSuccess) {
                              return Padding(
                                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                                child: Column(
                                  children: state.services.map((service) {
                                    return ServiceManagementFiled(
                                        context: context,
                                        screenWidth: screenWidth,
                                        label: service.serviceName,
                                        serviceRate: service.amount.toStringAsFixed(0),
                                        deleteAction: (){},
                                        updateAction: (){},
                                      );
                                  }).toList(),
                                ),
                              );
                            } else if (state is FetchBarberServiceEmpty) {
                              return  Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    LottiefilesCommon(assetPath: LottieImages.emptyData, width: screenWidth * 0.5, height: screenHeight * .3),
                                    Text( 'No services added yet!.')
                                  ],
                                ),
                              );
                            }
                                    
                            return Center(
                               child:SpinKitFadingFour(
                             color: AppPalette.orengeClr,
                             size: 23.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    width: screenWidth * .9,
                    child: ActionButton(
                      screenWidth: screenWidth,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.serviceAddscreen),
                      label: 'Add service',
                      screenHight: screenHeight,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServiceManagementFiled extends StatefulWidget {
  const ServiceManagementFiled({
    super.key,
    required this.context,
    required this.screenWidth,
    required this.label,
    required this.serviceRate,
    required this.deleteAction, 
    required this.updateAction});
  

  final BuildContext context;
  final double screenWidth;
  final String label;
  final String serviceRate;
  final VoidCallback deleteAction;
  final VoidCallback updateAction;

  @override
  State<ServiceManagementFiled> createState() => _ServiceManagementFiledState();
}

class _ServiceManagementFiledState extends State<ServiceManagementFiled> {
  late final TextEditingController serviceRateController;

    @override
  void initState() {
    super.initState();
    serviceRateController = TextEditingController(text: widget.serviceRate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<EditModeCubit, bool>(
            builder: (context, isEditable) {
              return TextFormFieldWidget(
                      enabled: isEditable,
                      label: widget.label,
                      hintText: 'Enter your charge',
                      prefixIcon: Icons.currency_rupee,
                      controller: serviceRateController,
                      validate: ValidatorHelper.validateAmount,
                    );
            },
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: widget.screenWidth * 0.12,
          width: widget.screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppPalette.greyClr ,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.orengeClr,
            focusColor: AppPalette.greenClr,
            onPressed: widget.updateAction ,
            icon: Icon(
             CupertinoIcons.floppy_disk,
              color: AppPalette.whiteClr,
            ),
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: widget.screenWidth * 0.12,
          width: widget.screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppPalette.redClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.redClr,
            focusColor: AppPalette.greenClr,
            onPressed: widget.deleteAction,
            icon: Icon(
              CupertinoIcons.delete_solid,
              color: AppPalette.whiteClr,
            ),
          ),
        ),
      ],
    );
  }
}
