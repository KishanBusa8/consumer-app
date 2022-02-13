// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/new_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_components.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';

class LoanContactForm extends StatefulWidget {
  LoanContactForm({Key? key, this.checBoxChange, required this.selectDateController,
   required this.selectTimeController}) : super(key: key);
  var checBoxChange;
  TextEditingController selectDateController;
  TextEditingController selectTimeController;

  @override
  State<LoanContactForm> createState() => _LoanContactFormState();
}

class _LoanContactFormState extends State<LoanContactForm> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


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
          child:
              NewColumn(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please select valid date';
                    }
                    return null;
                  },
                focusNode: AlwaysDisabledFocusNode(),
                controller: widget.selectDateController,
                onTap: () {
                  _selectDate(context);
                },
                style: MasterStyle.whiteTextInputStyle,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.date_range_outlined,
                      color: MasterStyle.appIconColor),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintText: 'Select',
                  hintStyle: MasterStyle.whiteHintStyle,
                  enabledBorder: SimplifiedWidgets.outlineInputBorder,
                  border: SimplifiedWidgets.outlineInputBorder,
                  focusedBorder: SimplifiedWidgets.outlineInputBorder,
                ),
              ),
            ),
                Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Best time to contact',
                style: MasterStyle.secondarySemiBoldTextStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField( validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please select valid time';
                    }
                    return null;
                  },
                focusNode: AlwaysDisabledFocusNode(),
                controller: widget.selectTimeController,
                onTap: () {
                  _selectTime(context);
                },
                style: MasterStyle.whiteTextInputStyle,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.timer,
                      color: MasterStyle.appIconColor),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintText: 'Select',
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
                      data:
                          ThemeData(unselectedWidgetColor: HexColor('#6D7B95')),
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

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 14)),
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
      widget.selectDateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: widget.selectDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }



_selectTime(BuildContext context) async {          
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
            builder: (BuildContext? context, Widget? child) {
          return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: MasterStyle.appSecondaryColor,
                  onPrimary: Colors.white,
                  surface: MasterStyle.backgroundColor,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: MasterStyle.backgroundColor,
              ),
              child: child!);
        }
      );
      if(timeOfDay != null && timeOfDay != selectedTime)
        {
          setState(() {
            selectedTime = timeOfDay; 
              final dateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, timeOfDay.hour, timeOfDay.minute);
    final formatTime = DateFormat.jm(); 
            widget.selectTimeController..text =  formatTime.format(dateTime);
          });
        }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
