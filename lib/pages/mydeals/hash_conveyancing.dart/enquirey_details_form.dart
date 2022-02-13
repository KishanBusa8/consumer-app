// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashConvenyancingEnquireyDetails extends StatefulWidget {
  HashConvenyancingEnquireyDetails({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.postcodeController,
    required this.checkbox,
    required this.sendCodeButton,
    required this.phoneNumberInputField,
  }) : super(key: key);
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController postcodeController;
  Checkbox checkbox;
  Widget sendCodeButton;
  Widget phoneNumberInputField;

  @override
  State<HashConvenyancingEnquireyDetails> createState() =>
      _HashConvenyancingEnquireyDetailsState();
}

class _HashConvenyancingEnquireyDetailsState
    extends State<HashConvenyancingEnquireyDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
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
              widget.sendCodeButton
              //    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              // SimplifiedWidgets.elevatedButton(
              //   padding: EdgeInsets.only(left:24,right: 24,top: 3,bottom: 8),

              //     text: 'Send code',
              //     textStyle: MasterStyle.whiteStyleRegularNormal,
              //     color: MasterStyle.appSecondaryColor,
              //     borderRadius: BorderRadius.all(Radius.circular(5)),
              //     onPresed: () {})
              //    ]),
            ],
          ),
        ),
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
