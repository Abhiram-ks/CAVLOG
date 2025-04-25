import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/service_select_cubit/service_select_cubit.dart';
import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/common/textfield_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/validation/input_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/common/common_loading_widget.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../provider/bloc/modifications/barber_service_bloc/barber_service_bloc.dart';
import '../../../provider/bloc/fetchings/fetch_service_bloc/fetch_service_bloc.dart';
import '../../../widgets/settings_widget/settings_service_management/handle_servicestae.dart';
import '../../../widgets/settings_widget/settings_service_management/service_tags_widget.dart';

class ServiceAddScreen extends StatefulWidget {
  const ServiceAddScreen({super.key});

  @override
  State<ServiceAddScreen> createState() => _ServiceAddScreenState();
}

class _ServiceAddScreenState extends State<ServiceAddScreen> {
  final TextEditingController serviceRateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedService = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ServiceSelectCubit()),
      BlocProvider(create: (context) => BarberServiceBloc()),
    ],
      child: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        return ColoredBox(
          color: AppPalette.scafoldClr ?? AppPalette.whiteClr,
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: CustomAppBar(),
                  body: BlocBuilder<FetchServiceBloc, FetchServiceState>(
                    builder: (context, state) {
                      if (state is FetchServiceLoading ||state is FetchServiceError) {
                        return LoadingScreen( screenHeight: screenHeight,screenWidth: screenWidth);
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric( horizontal: screenWidth * 0.08),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( 'Service Deployment',
                                  style: GoogleFonts.plusJakartaSans(  fontSize: 28,fontWeight: FontWeight.bold),
                                ),ConstantWidgets.hight10(context),
                                Text(  'Set up and showcase your perfect service lineup. Craft a professional presentation and deploy it with ease.',
                                ),  ConstantWidgets.hight20(context),
                                BlocBuilder<ServiceSelectCubit,ServiceSelectState>(
                                  builder: (context, state) {
                                    selectedService = state.selectedServiceName;
                                    return TextFormFieldWidget(
                                      label: state.selectedServiceName,
                                      hintText: "Enter your charge",
                                      prefixIcon: Icons.currency_rupee,
                                      controller: serviceRateController,
                                      validate: ValidatorHelper.validateAmount,
                                      enabled: state.isEnabled,
                                    );
                                  },
                                ), ConstantWidgets.hight20(context),
                                BlocBuilder<FetchServiceBloc, FetchServiceState>(
                                  builder: (context, state) {
                                    if (state is FetchServiceLoaded) {
                                      final services = state.service;
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: List.generate(
                                            services.length,
                                            (index) {
                                              final serviceName =  services[index].name;
                                              final isSelected = context.watch<ServiceSelectCubit>().state.selectedServiceName == serviceName;
                                              return serviceTags(
                                                onTap: () {
                                                  context.read<ServiceSelectCubit>().selectService( serviceName); },
                                                text: serviceName,isSelected: isSelected,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                    return LoadingScreen(  screenHeight: screenHeight, screenWidth: screenWidth);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  floatingActionButtonLocation:   FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    width: screenWidth * .9,
                    child: BlocListener<BarberServiceBloc, BarberServiceState>(
                        listener: (context, state) {
                          handleBarberServiceState(context, state);
                        },
                        child: ActionButton(
                          screenWidth: screenWidth,
                          label: "Upload",
                          screenHight: screenHeight,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedService.isNotEmpty) {
                                String input =  serviceRateController.text.trim();
                                double value = double.tryParse(input) ?? 0.0;
                                context.read<BarberServiceBloc>().add( AddSingleBarberServiceEvent(serviceName: selectedService,amount: value));
                              }
                            } else {
                              CustomeSnackBar.show(
                                context: context,
                                title: 'Complete Required Fields!',
                                description:'Oops! You missed a required field. Please fill it out to proceed to the next step.',
                                titleClr: AppPalette.redClr,
                              );
                            }
                          },
                        ),
                      ),
                  ),
                ),
              )),
        );
      }),
    );
  }
}
