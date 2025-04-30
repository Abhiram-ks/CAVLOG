
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/textfield_helper.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../../../core/validation/input_validations.dart';
import '../../../provider/cubit/edit_mode/edit_mode_cubit.dart';

class ServiceManagementFiled extends StatefulWidget {
    ServiceManagementFiled({
      super.key,
      required this.context,
      required this.screenWidth,
      required this.label,
      required this.icon,
      required this.serviceRate,
      required this.deleteAction,
      required this.updateAction,
      this.firstIconColor,
      this.firstIconBgColor,
      this.secoundIconColor,
      this.secoundIconBgColor,
      this.updateDeletIcon,
      this.updateOntap,
      this.updateIcon});

  final BuildContext context;
  final double screenWidth;
  final String label;
  final String serviceRate;
  final VoidCallback deleteAction;
  final IconData icon;
  VoidCallback? updateOntap;
  IconData? updateIcon;
  Color? firstIconColor;
  Color? firstIconBgColor;
  Color? secoundIconColor;
  Color? secoundIconBgColor;
  IconData? updateDeletIcon;
  final void Function(double value) updateAction; 

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
                prefixIcon: widget.icon,
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
            color: widget.firstIconBgColor ?? AppPalette.greyClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.hintClr.withAlpha(128),
            focusColor: AppPalette.greenClr,
            onPressed:(){
               final value = double.tryParse(serviceRateController.text.trim());
               if(value != null){
                widget.updateAction(value);
               }
                 if (widget.updateOntap != null) {
                   widget.updateOntap!(); 
                }
            },
            icon: Icon(
              widget.updateIcon ?? CupertinoIcons.floppy_disk,
              color: widget.firstIconColor ?? AppPalette.whiteClr,
            ),
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: widget.screenWidth * 0.12,
          width: widget.screenWidth * 0.12,
          decoration: BoxDecoration(
            color:widget.secoundIconBgColor ?? AppPalette.redClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor:AppPalette.hintClr.withAlpha(128),
            focusColor: AppPalette.greenClr,
            onPressed: widget.deleteAction,
            icon: Icon(
               widget.updateDeletIcon ?? CupertinoIcons.delete_solid,
              color:widget.secoundIconColor ?? AppPalette.whiteClr,
            ),
          ),
        ),
      ],
    );
  }
}
