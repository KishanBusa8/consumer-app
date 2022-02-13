// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/myloans/businessloan/business_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_components.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_contact_form.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';

class HashConvenyancingAddressForm extends StatefulWidget {
  HashConvenyancingAddressForm({
    Key? key,
    required this.moveInDateController,
    required this.streetNumberController,
    required this.streetNameController,
    required this.streetTypeController,
    required this.checkbox,
  }) : super(key: key);
  TextEditingController moveInDateController;
  TextEditingController streetNumberController;
  TextEditingController streetNameController;
  TextEditingController streetTypeController;
  Checkbox checkbox;

  @override
  State<HashConvenyancingAddressForm> createState() =>
      _HashConvenyancingAddressFormState();
}

class _HashConvenyancingAddressFormState
    extends State<HashConvenyancingAddressForm> {
  DateTime _selectedDate = DateTime.now();

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
              labelWithStyle('Move in date :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please select valid date';
                    }
                    return null;
                  },
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: widget.moveInDateController,
                  onTap: () {
                    _selectDate(context);
                  },
                  style: MasterStyle.whiteTextInputStyle,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'select',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('Street number :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid street number';
                    }
                    return null;
                  },
                  controller: this.widget.streetNumberController,
                  keyboardType: TextInputType.text,
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
              labelWithStyle('Street name :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid street name';
                    }
                    return null;
                  },
                  controller: this.widget.streetNameController,
                  keyboardType: TextInputType.name,
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
              labelWithStyle('Select street :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please select the valid input';
                    }
                    return null;
                  },
                  controller: this.widget.streetTypeController,
                  keyboardType: TextInputType.text,
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
                        PrivacyPolicy(
                            text: 'privacy policy ', context: context),
                        textSpanNormal(text: 'and '),
                        TermsAndConditions(
                            text: 'terms of use.', context: context)
                      ])),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (BuildContext? context, Widget? child) {
          return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: MasterStyle.appSecondaryColor,
                  onPrimary: Colors.white,
                  surface: MasterStyle.appSecondaryColor,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: MasterStyle.backgroundColor,
              ),
              child: child!);
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;

      widget.moveInDateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: widget.moveInDateController.text.length,
            affinity: TextAffinity.upstream));
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
}
