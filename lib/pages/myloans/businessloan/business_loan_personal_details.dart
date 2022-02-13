// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
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

class BusinessLoanPersonalDetails extends StatelessWidget {
  BusinessLoanPersonalDetails({
    Key? key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.sendCodeButton,
    required this.phoneNumberInputField,
  }) : super(key: key);
  TextEditingController fullNameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  Widget sendCodeButton;
  Widget phoneNumberInputField;

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
              labelWithStyle(listOfLabel[0]),
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
                  controller: this.fullNameController,
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
                  controller: this.emailController,
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
              this.phoneNumberInputField,
              this.sendCodeButton
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

Widget businessLoanPersonalDetails() {
  return ListView(
    shrinkWrap: true,
    children: [
      Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
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
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            listOfLabel[index],
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              hintText: listOfHintText[index],
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                            ),
                          ),
                        ),
                      ]);
                }),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SimplifiedWidgets.elevatedButton(
                  text: 'Send code',
                  textStyle: MasterStyle.whiteStyleRegularNormal,
                  color: MasterStyle.appSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  onPresed: () {})
            ])
          ],
        ),
      ),
    ],
  );
}

Widget businessLoanAmountDetails() {
  return ListView(
    shrinkWrap: true,
    children: [
      Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
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
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            listOfAdditionalDetails[index][label],
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              hintText: listOfAdditionalDetails[index][hint],
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                            ),
                          ),
                        ),
                      ]);
                }),
            // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //   SimplifiedWidgets.elevatedButton(
            //       text: 'Send code',
            //       textStyle: MasterStyle.whiteStyleRegularNormal,
            //       color: MasterStyle.appSecondaryColor,
            //       borderRadius: BorderRadius.all(Radius.circular(5)),
            //       onPresed: () {})
            // ])
          ],
        ),
      ),
    ],
  );
}

Widget businessLoanContactDetails(Checkbox checkBox) {
  return ListView(
    shrinkWrap: true,
    children: [
      SimplifiedWidgets.containerBox(
        radius: 10,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 24),
        color: MasterStyle.whiteColor.withOpacity(0.1),
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Best day to contact',
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(icons[index],
                                  color: MasterStyle.appIconColor),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              hintText: 'select',
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                            ),
                          ),
                        ),
                      ]);
                }),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
                data: ThemeData(unselectedWidgetColor: HexColor('#6D7B95')),
                child: checkBox),
            Flexible(
              child: RichText(
                  text: TextSpan(children: [
                textSpanNormal(text: 'I understand and accept the '),
                textSpaHighLigth(text: 'privacy policy '),
                textSpanNormal(text: 'and '),
                textSpaHighLigth(text: 'terms of use.')
              ])),
            )
          ],
        ),
      )
    ],
  );
}
