// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_contact_form.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';

class HashConvenyancingAdditionalInformation extends StatefulWidget {
  HashConvenyancingAdditionalInformation({
    Key? key,
    required this.dateOfBirthController,
    required this.postCodeController,
  }) : super(key: key);
  TextEditingController dateOfBirthController;
  TextEditingController postCodeController;

  @override
  State<HashConvenyancingAdditionalInformation> createState() =>
      _HashConvenyancingAdditionalInformationState();
}

class _HashConvenyancingAdditionalInformationState
    extends State<HashConvenyancingAdditionalInformation> {
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
              labelWithStyle('Date of birth :'),
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
                  controller: widget.dateOfBirthController,
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
              labelWithStyle('Your suburb/postcode :'),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: TypeAheadFormField(
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
                  minCharsForSuggestions: 3,
                  // keepSuggestionsOnLoading: true,
                  hideOnEmpty: true,
                  hideOnLoading: false,
                  textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (value) {
                        setState(() {
                          widget.postCodeController.text = '';
                        });
                      },
                      controller: widget.postCodeController,
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
                    return await ApiServices.getPostCodeSuggestions(pattern);
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
                        widget.postCodeController.text = postCodeSuggestion;
                      });
                    } else {}
                  },
                ),
              ),
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
        firstDate: DateTime(1940),
        lastDate: DateTime.now(),
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

      widget.dateOfBirthController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: widget.dateOfBirthController.text.length,
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
