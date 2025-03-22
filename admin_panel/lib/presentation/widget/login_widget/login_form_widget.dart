import 'package:admin/core/common/action_button.dart';
import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/presentation/provider/bloc/loging/login_bloc.dart';
import 'package:admin/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:admin/presentation/widget/login_widget/handle_login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/textfield_helper.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../../core/validation/input_validations.dart';

class LoginForm extends StatefulWidget {
  final double screenHight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const LoginForm(
      {super.key,
      required this.screenHight,
      required this.screenWidth,
      required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: 'Email',
            hintText: 'Enter emial id',
            prefixIcon: CupertinoIcons.mail_solid,
            controller: emailController,
            validate: ValidatorHelper.validateEmailId,
          ),
          TextFormFieldWidget(
            label: 'Password',
            hintText: 'Enter Password',
            prefixIcon: CupertinoIcons.padlock_solid,
            isPasswordField: true,
            controller: passwordController,
            validate: ValidatorHelper.validatePassword,
          ),
          ConstantWidgets.hight30(context),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              handleLoginState(context, state); 
            },
            child: ActionButton(
                screenWidth: widget.screenWidth,
                onTap: () async{
                  final loginBloc = context.read<LoginBloc>();
                  final buttonCubit = context.read<ButtonProgressCubit>();
                
                 if (widget.formKey.currentState!.validate()) {
                   buttonCubit.startLoading();
                   loginBloc.add(LoginActionEvent(email: emailController.text.trim(), password: passwordController.text.trim()));
                   await Future.delayed(const Duration(seconds: 2));
                   buttonCubit.stopLoading();
                 }else {
                  CustomeSnackBar.show(context: context, title: 'Submission Faild !', description:'Please fill in all the required fields before proceeding..',
                 iconColor: AppPalette.redClr,
                icon: CupertinoIcons.clear_circled);
                 }
                },
                label: 'Sign In',
                screenHight: widget.screenHight),
          ),
          ConstantWidgets.hight10(context),
        ],
      ),
    );
  }
}
