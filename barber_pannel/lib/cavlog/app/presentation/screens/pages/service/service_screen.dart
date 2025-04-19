import 'package:barber_pannel/cavlog/app/data/repositories/image_picker_repo.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/image_picker/image_picker_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/upload_service_data_bloc/upload_service_data_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/current_service_cubit/current_service_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/service_widget/service_widget_upload_datas.dart';
import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/cloudinary/cloudinary_service.dart';
import '../../../../../../core/common/common_loading_widget.dart';
import '../../../../data/datasources/firestore_barber_service.dart';
import '../../../../domain/usecases/image_picker_usecase.dart';
import '../../../provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import '../../../provider/cubit/gender_cubit/gender_option_cubit.dart';
import '../../../widgets/service_widget/pdf_maker_widget.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ServicePageCubit()),
        BlocProvider(create: (context) => ImagePickerBloc(PickImageUseCase(ImagePickerRepositoryImpl(ImagePicker())))),
        BlocProvider(create: (context) => UploadServiceDataBloc(FirestoreBarberService(), CloudinaryService())),
        BlocProvider(create: (context) => GenderOptionCubit(initialGender: getGenderOptionFromString(null))),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;
          return ColoredBox(
            color: AppPalette.scafoldClr ?? AppPalette.whiteClr,
            child: SafeArea(
              child: Scaffold(
                  body: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                      builder: (context, state) {
                    switch (state) {
                      case CurrentServicePage.pageOne:
                        return const Center(child: Text('Page one'));

                      case CurrentServicePage.pageTwo:
                        return ViewServiceDetailsPage(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        );
                    }
                  }),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    width: screenWidth * .9,
                    child: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                      builder: (context, state) {
                        final isPageOne = state == CurrentServicePage.pageOne;
                        return ActionButton(
                            hasBorder:  true,
                            textColor: AppPalette.buttonClr,
                            borderColor: AppPalette.buttonClr,
                            color: AppPalette.trasprentClr,
                            screenWidth: screenWidth,
                            onTap: () {
                              if (isPageOne) {
                                context.read<ServicePageCubit>().goToPageTwo();
                              } else {
                                context.read<ServicePageCubit>().goToPageOne();
                              }
                            },
                            label: isPageOne
                                ? 'View Service Details'
                                : 'Back to Slots',
                            screenHight: screenHeight);
                      },
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}

class ViewServiceDetailsPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const ViewServiceDetailsPage(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchBarberBloc>().add(FetchCurrentBarber());
    });
    return BlocBuilder<FetchBarberBloc, FetchBarberState>(
      builder: (context, state) {
        if (state is FetchBarbeLoading || state is FetchBarberError) {
          return LoadingScreen(
              screenHeight: screenHeight, screenWidth: screenWidth);
        } else if (state is FetchBarberLoaded) {
          return Scaffold(
            appBar: CustomAppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Barber Details',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    ConstantWidgets.hight10(context),
                    Text(
                        "Please provide complete details of your barber shop. The generated BarberDocs will compile all submitted information, serving as an official reference for service management and business documentation."),
                    ConstantWidgets.hight20(context),
                    UploadingServiceDatas(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        barber: state.barber),
                    ConstantWidgets.hight10(context),
                    ActionButton(
                      color: AppPalette.redClr,
                      screenWidth: screenWidth,
                      screenHight: screenHeight,
                      label: 'BarberDocs',
                      onTap: () async {
                        final success = await PdfMakerWidget.generateDetails(
                            barberName: state.barber.barberName,
                            ventureName: state.barber.ventureName,
                            phoneNumber: state.barber.phoneNumber,
                            address: state.barber.address,
                            email: state.barber.email,
                            establishedYear: state.barber.age,
                            gender: state.barber.gender,
                            status: state.barber.isblok ? 'Blocked' : 'Active');
            
                        if (success == false) {
                          CustomeSnackBar.show(
                            // ignore: use_build_context_synchronously
                            context: context,
                            title: 'Unable to Open Docs',
                            description:
                                'Oops! Unable to open the Barber Data doc. Please try again later.',
                            titleClr: AppPalette.redClr,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return LoadingScreen(
            screenHeight: screenHeight, screenWidth: screenWidth);
      },
    );
  }
}
