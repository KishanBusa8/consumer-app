// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/validator.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

String label = 'label';
String hint = 'hint';

List<String> listOfLabel = ['Full name :', 'E-mail ID :', 'Phone no :'];
List<String> listOfHintText = ['John Doe', 'example@email.com', '04XXXXXXXX'];
List listOfAdditionalDetails = [
  {label: 'Your loan amount :', hint: '\$50,000'},
  {label: 'Your suburb/postcode :', hint: 'E.g 2000 or Richmond'}
];
List icons = [Icons.date_range_outlined, Icons.timer];

class NewLoanPersonalDetails extends StatefulWidget {
  NewLoanPersonalDetails(
      {Key? key,
      required this.lastNameController,
        required this.firstNameController,
      required this.emailController,
      required this.phoneController,
      required this.sendCodeButton,
      required this.phoneNumberInputField,
    })
      : super(key: key);
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  Widget sendCodeButton;
  Widget phoneNumberInputField;

  @override
  State<NewLoanPersonalDetails> createState() =>
      _NewLoanPersonalDetailsState();
}

class _NewLoanPersonalDetailsState extends State<NewLoanPersonalDetails> {
 
  TextEditingController otpController = TextEditingController(text: '');
 

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MasterStyle.appSecondaryColor,
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  bool? isButtonDisable;
  @override
  void initState() {
    super.initState();
  }

  
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
              labelWithStyle("First name :"),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  controller: this.widget.firstNameController,
                  keyboardType: TextInputType.name,
                  style: MasterStyle.whiteTextInputStyle,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: listOfHintText[0],
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle("Last name :"),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  controller: this.widget.lastNameController,
                  keyboardType: TextInputType.name,
                  style: MasterStyle.whiteTextInputStyle,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: listOfHintText[0],
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),

              labelWithStyle(listOfLabel[1]),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  controller: this.widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: listOfHintText[1],
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle(listOfLabel[2]),
            widget.phoneNumberInputField,
              /// send code
              widget.sendCodeButton
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

labelWithStyle(label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      label,
      style: MasterStyle.secondarySemiBoldTextStyle,
    ),
  );
}

TextSpan textSpanNormal({required String text}) {
  return TextSpan(text: text, style: MasterStyle.whiteTextNormal);
}

TextSpan textSpaHighLigth({required String text}) {
  return TextSpan(text: text, style: MasterStyle.primaryContent);
}
