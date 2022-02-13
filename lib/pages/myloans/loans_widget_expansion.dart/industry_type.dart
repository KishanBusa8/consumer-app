// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/new_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/loan_components.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';

class IndustryType extends StatefulWidget {
  IndustryType(
      {Key? key,
      this.checBoxChange,
      required this.industryTypeController,
      required this.priceController})
      : super(key: key);
  var checBoxChange;
  TextEditingController industryTypeController;
  TextEditingController priceController;

  @override
  State<IndustryType> createState() => _IndustryTypeState();
}

class _IndustryTypeState extends State<IndustryType> {
  var _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

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
                labelWithStyle('Industry type :'),
                Container(
                  padding: EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter valid industry type';
                      }
                      return null;
                    },
                    controller: widget.industryTypeController,
                    keyboardType: TextInputType.text,
                    style: MasterStyle.whiteTextInputStyle,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      hintText: 'Ex',
                      hintStyle: MasterStyle.whiteHintStyle,
                      enabledBorder: SimplifiedWidgets.outlineInputBorder,
                      border: SimplifiedWidgets.outlineInputBorder,
                      focusedBorder: SimplifiedWidgets.outlineInputBorder,
                    ),
                  ),
                ),
                labelWithStyle('Price of equipment :'),
                Container(
                  padding: EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    onChanged: (string) {
                      string = '${_formatNumber(string.replaceAll(',', ''))}';
                      widget.priceController.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    },
                    style: MasterStyle.whiteTextInputStyle,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter valid price';
                      }
                      return null;
                    },
                    controller: widget.priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      hintText: 'Ex',
                      hintStyle: MasterStyle.whiteHintStyle,
                      enabledBorder: SimplifiedWidgets.outlineInputBorder,
                      border: SimplifiedWidgets.outlineInputBorder,
                      focusedBorder: SimplifiedWidgets.outlineInputBorder,
                    ),
                  ),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Theme(
                  data: ThemeData(unselectedWidgetColor: HexColor('#6D7B95')),
                  child: widget.checBoxChange),
              Flexible(
                child: RichText(
                    text: TextSpan(children: [
                    textSpanNormal(text: 'I understand and accept the '),
                      PrivacyPolicy(text: 'privacy policy ',context: context),
                      textSpanNormal(text: 'and '),
                      TermsAndConditions(text: 'terms of use.',context: context)
                ])),
              )
            ],
          ),
        )
      ],
    );
  }
}
