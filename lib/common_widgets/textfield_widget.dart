
import 'package:flutter/material.dart';
import 'package:hashching/styles/styles.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.controller,
    required this.isEnable

  }) : super(key: key);
  final String text;
  final TextEditingController controller;
  final bool  isEnable;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:32.0,right: 32),
      child: TextField(
        
        controller: widget.controller,
        style: TextFonts.quaternaryText,
        enabled: widget.isEnable,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
           hintStyle: loginHint.primaryText,
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
    );
  }
}
