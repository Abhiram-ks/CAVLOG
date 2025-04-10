import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/common/textfield_helper.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/validation/input_validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/utils/constant/constant.dart';
import '../../../../data/models/barberservice_model.dart';
import '../../../provider/bloc/fetch_barber_service_bloc/fetch_barber_service_bloc.dart';

class ServiceManageScreen extends StatefulWidget {
  const ServiceManageScreen({super.key});

  @override
  State<ServiceManageScreen> createState() => _ServiceManageScreenState();
}

class _ServiceManageScreenState extends State<ServiceManageScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<FetchBarberServiceBloc>()
        .add(FetchBarberServiceRequestEvent());
  }

  final TextEditingController serviceRateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;
      return ColoredBox(
        color: AppPalette.whiteClr,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
                child: Scaffold(
              appBar: CustomAppBar(),
              body:
                  BlocBuilder<FetchBarberServiceBloc, FetchBarberServiceState>(
                builder: (context, state) {
                  if (state is FetchBarberServiceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FetchBarberServiceSuccess) {
                    final basicHaircut = state.services.firstWhere(
                      (service) => service.serviceName == 'Basic Haircut',
                      orElse: () => BarberServiceModel(
                          barberId: '',
                          serviceName: 'Basic Haircut',
                          amount: 0),
                    );

                    serviceRateController.text = basicHaircut.amount.toString();

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service Management',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            ConstantWidgets.hight10(context),
                            const Text(
                                'Craft your perfect service lineup — add, update, or fine-tune offerings to match your brand’s style.'),
                            ConstantWidgets.hight30(context),
                            serviceManageDetails(
                              context: context,
                              screenWidth: screenWidth,
                              label: 'Basic Haircut',
                              serviceRateController: serviceRateController,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is FetchBarberServiceError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }

                  return const SizedBox(); // default case
                },
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
                    screenHight: screenHeight),
              ),
            ))),
      );
    });
  }

  Row serviceManageDetails({
    required BuildContext context,
    required double screenWidth,
    required String label,
    required TextEditingController serviceRateController,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            label: label,
            hintText: 'Enter your charge',
            prefixIcon: Icons.currency_rupee,
            controller: serviceRateController,
            validate: ValidatorHelper.validateAmount,
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: screenWidth * 0.12,
          width: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppPalette.buttonClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.buttonClr,
            focusColor: AppPalette.greenClr,
            onPressed: () {},
            icon: Icon(
              Icons.edit_document,
              color: AppPalette.whiteClr,
            ),
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: screenWidth * 0.12,
          width: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppPalette.redClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.redClr,
            focusColor: AppPalette.greenClr,
            onPressed: () {},
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
