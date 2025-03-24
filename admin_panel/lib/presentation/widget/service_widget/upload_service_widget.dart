import 'package:admin/presentation/provider/bloc/service_management/service_mangement_bloc.dart';
import 'package:admin/presentation/widget/service_widget/service_builder_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/action_button.dart';
import '../../../core/common/snackbar_helper.dart';
import '../../../core/common/textfield_helper.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../../core/validation/input_validations.dart';
import '../../provider/cubit/buttonProgress/button_progress_cubit.dart';

class UploadServicesWidget extends StatefulWidget {
  final double screenHight;
  final double screenWidth;
  const UploadServicesWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
  });

  @override
  State<UploadServicesWidget> createState() => _UploadServicesWidgetState();
}

class _UploadServicesWidgetState extends State<UploadServicesWidget> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstantWidgets.hight20(context),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                  label: 'Upload new service',
                  hintText: 'Enter new service data',
                  prefixIcon: CupertinoIcons.cloud_upload,
                  controller: _textController,
                  validate: ValidatorHelper.validateText),
              ActionButton(
                  screenWidth: widget.screenWidth,
                  onTap: () async {
                    final buttonCubit = context.read<ButtonProgressCubit>();
                    if (_formKey.currentState!.validate()) {
                      buttonCubit.startLoading();
                      context.read<ServiceMangementBloc>().add(
                          UploadNewServiceEvent(
                              serviceName: _textController.text.trim()));
                      await Future.delayed(const Duration(milliseconds: 1800));
                      buttonCubit.stopLoading();
                      _textController.clear();
                    } else {
                      CustomeSnackBar.show(
                          context: context,
                          title: 'Service data not found',
                          description:
                              'Oops! Please enter the required service details.',
                          iconColor: AppPalette.redClr,
                          icon: CupertinoIcons.cloud_upload);
                    }
                  },
                  label: 'Upload',
                  screenHight: widget.screenHight),
              ConstantWidgets.hight30(context),
              ServiceBuilderWidget(widget: widget)
            ],
          ),
        )
      ],
    );
  }
}
