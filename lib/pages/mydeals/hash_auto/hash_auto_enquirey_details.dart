// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashAutoEnquireyDetails extends StatefulWidget {
  HashAutoEnquireyDetails({
    Key? key,
    required this.lastNameController,
    required this.firstNameController,
    required this.emailController,
    required this.phoneController,
    required this.postcodeController,
    required this.checkbox,
    required this.sendCodeButton,
    required this.phoneNumberInputField,
    required this.postCodeWidget,
  }) : super(key: key);
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController postcodeController;
  Checkbox checkbox;
  Widget sendCodeButton;
  Widget phoneNumberInputField;
  Widget postCodeWidget;

  @override
  State<HashAutoEnquireyDetails> createState() =>
      _HashAutoEnquireyDetailsState();
}

class _HashAutoEnquireyDetailsState extends State<HashAutoEnquireyDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Text(
            'Your personal details :',
            style: MasterStyle.whiteTextStyleNormal,
          ),
        ),
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWithStyle('First name :'),

              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  controller: this.widget.firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'Lynda',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('Last name :'),

              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  controller: this.widget.lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'Haynes',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),

              labelWithStyle('E-mail ID :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your email address';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter your valid email address';
                    }
                    return null;
                  },
                  controller: this.widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'lynda.aynes@gmail.com',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('Phone no :'),
              widget.phoneNumberInputField,
              widget.sendCodeButton,
              labelWithStyle('Your suburb/postcode :'),
              widget.postCodeWidget
              // Container(
              //   padding: EdgeInsets.only(bottom: 24),
              //   child: TextFormField(
              //     style: MasterStyle.whiteTextInputStyle,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     validator: (value) {
              //       if (value!.trim().isEmpty) {
              //         return 'Please enter valid suburb/postcode';
              //       }
              //       return null;
              //     },
              //     controller: this.widget.postcodeController,
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //       hintText: 'E.g 2000 or Richmond',
              //       hintStyle: MasterStyle.whiteHintStyle,
              //       enabledBorder: SimplifiedWidgets.outlineInputBorder,
              //       border: SimplifiedWidgets.outlineInputBorder,
              //       focusedBorder: SimplifiedWidgets.outlineInputBorder,
              //     ),
              //   ),
              // ),

              //  Padding(

              //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Theme(
              //           data:
              //               ThemeData(unselectedWidgetColor: HexColor('#6D7B95')),
              //           child: widget.checkbox),
              //       Flexible(
              //         child: RichText(
              //             text: TextSpan(children: [
              //           textSpanNormal(text: 'I understand and accept the '),
              //           textSpaHighLigth(text: 'privacy policy '),
              //           textSpanNormal(text: 'and '),
              //           textSpaHighLigth(text: 'terms of use.')
              //         ])),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }

  labelWithStyle(label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: MasterStyle.secondarySemiBoldTextStyle,
      ),
    );
  }
}
