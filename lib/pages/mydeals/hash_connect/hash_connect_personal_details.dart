// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/new_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_components.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashConnectPersonalDetailsForm extends StatefulWidget {
  HashConnectPersonalDetailsForm({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.postcodeController,
    required this.checkbox,
    required this.phoneNumberInputField,
    required this.sendCodeButton,
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
  State<HashConnectPersonalDetailsForm> createState() =>
      _HashConnectPersonalDetailsFormState();
}

class _HashConnectPersonalDetailsFormState
    extends State<HashConnectPersonalDetailsForm> {
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
                      return 'Please enter valid email';
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
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: TypeAheadFormField(
                  minCharsForSuggestions: 3,
                  suggestionsBoxDecoration:
                      SuggestionsBoxDecoration(hasScrollbar: true),
                  loadingBuilder: (context) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            MasterStyle.appSecondaryColor),
                      ),
                    );
                  },
                  // keepSuggestionsOnLoading: true,
                  hideOnEmpty: true,
                  hideOnLoading: false,
                  textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (value) {
                        setState(() {});
                      },
                      controller: widget.postcodeController,
                      style: MasterStyle.whiteTextInputStyle,
                      cursorColor: MasterStyle.customGreyColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        hintText: 'E.g 2000 or Richmond',
                        hintStyle: MasterStyle.whiteHintStyle,
                        enabledBorder: SimplifiedWidgets.outlineInputBorder,
                        border: SimplifiedWidgets.outlineInputBorder,
                        focusedBorder: SimplifiedWidgets.outlineInputBorder,
                      )),
                  suggestionsCallback: (pattern) async {
                    return await ApiServices.getSuggestions(pattern);
                  },
                  itemBuilder: (context, Map<String, String> suggestion) {
                    return Column(
                      children: [
                        ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: suggestion['status'] == "true"
                                ? Text(
                                    suggestion['suggestions']!,
                                    style: MasterStyle.greyNormalStyle,
                                  )
                                : Text(
                                    suggestion['suggestions']!,
                                    style: MasterStyle.negativeStatusStyle,
                                  )),
                        suggestion['status'] == "true" ? Divider() : SizedBox()
                      ],
                    );
                  },
                  onSuggestionSelected: (Map<String, String> suggestion) {
                    if (suggestion['status'] == "true") {
                      setState(() {
                        var postCodeSuggestion = suggestion['suggestions']!;
                        widget.postcodeController.text = postCodeSuggestion;
                      });
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: HexColor('#6D7B95')),
                        child: widget.checkbox),
                    Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                        textSpanNormal(text: 'I understand and accept the '),
                        PrivacyPolicy(text: 'privacy policy '),
                        textSpanNormal(text: 'and '),
                        TermsAndConditions(text: 'terms of use.')
                      ])),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 100)
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
