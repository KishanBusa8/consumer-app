import 'package:flutter/material.dart';
import 'package:hashching/styles/styles.dart';

class EmailFieldWidget extends StatefulWidget {
  const EmailFieldWidget(
      {Key? key,
      required this.text,
      required this.controller,
      required this.isEnable})
      : super(key: key);
  final String text;
  final TextEditingController controller;
  final bool isEnable;

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32),
      child: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: widget.controller,
          style: TextFonts.quaternaryText,
          enabled: widget.isEnable,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.text,
            contentPadding: const EdgeInsets.all(16),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BoxBorders.primaryButton,
              gapPadding: 50.0,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BoxBorders.primaryButton,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BoxBorders.primaryButton,
            ),
          ),
        ),
      ),
    );
  }
}
