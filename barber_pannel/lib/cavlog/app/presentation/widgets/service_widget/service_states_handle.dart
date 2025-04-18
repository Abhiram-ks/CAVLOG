import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/upload_service_data_bloc/upload_service_data_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';

void handleServiceWidgetState(BuildContext context, UploadServiceDataState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is UploadServiceDialogBox) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation Alert!',
        description:
           'Are you sure you want to upload this session? This will overwrite any previously saved session.',
        firstButtonText: 'Allow',
        firstButtonAction: () {
         // context  .read<BarberServiceBloc>().add(ConfirmationBarberServiceEvent());
         // Navigator.pop(context);
        },
        firstButtonColor: AppPalette.blueClr,
        secondButtonText: "Maybe Later",
        secondButtonAction: () {
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blueClr);
  }
}
