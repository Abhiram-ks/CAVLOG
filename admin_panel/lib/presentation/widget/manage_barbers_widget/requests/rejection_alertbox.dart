import 'package:admin/core/common/textfield_helper.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:admin/core/validation/input_validations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RejectionAlertbox extends StatefulWidget {
  final String title;
  final String hintText;
  final String label;
  final String firstButtonText;
  final IconData textIcon;
  final void Function(String reason) firstButtonAction;
  final Color firstButtonColor;
  final String secondButtonText;
  final VoidCallback secondButtonAction;
  final Color secondButtonColor;
  final String? initialReason;

  const RejectionAlertbox({
    super.key,
    required this.title,
    required this.firstButtonText,
    required this.firstButtonAction,
    required this.firstButtonColor,
    required this.secondButtonText,
    required this.secondButtonAction,
    required this.label,
    required this.secondButtonColor,
    this.initialReason, 
    required this.textIcon,
    required this.hintText,
  });

  @override
  State<RejectionAlertbox> createState() => _RejectionAlertboxState();
}

class _RejectionAlertboxState extends State<RejectionAlertbox> {
  late final  TextEditingController _textController;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState(){
    super.initState();
    _textController = TextEditingController(text: widget.initialReason ?? '');
  }
    @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(left: 6.0, right: 6),
        child: Text(
          widget.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 21,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstantWidgets.hight30(context),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Form(
              key: _formKey,
              child: TextFormFieldWidget(label:widget.label,hintText:widget.hintText ,prefixIcon:widget.textIcon, controller: _textController, validate: ValidatorHelper.validateText)
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
              width: double.infinity,
              child: Divider(
                  color: const Color.fromARGB(255, 220, 220, 220),
                  thickness: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             TextButton(
            onPressed: widget.secondButtonAction,
            child: Text(
              widget.secondButtonText,
              style: GoogleFonts.inter(
                  fontSize: 17,
                  color: widget.secondButtonColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          
               TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.firstButtonAction(_textController.text.trim());
              }
            },
            child: Text(
              widget.firstButtonText,
              style: GoogleFonts.inter(
                  fontSize: 17,
                  color: widget.firstButtonColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
            ],
          )
          
        ],
      ),
    );
  }
}