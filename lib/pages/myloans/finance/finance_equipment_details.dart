// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';

String label = 'label';
String hint = 'hint';

List<String> listOfLabel = [
  'Built year :',
  'Equipment make :',
  'Equipment model :'
];

List<String> listOfLabelNew = [
  'Built year :',
  'Car make :',
  'Price of the car :'
];
List<String> listOfHintText = ['Enter year', 'Ex', 'Ex'];
List<String> listOfHintTextNew = ['Select year', 'Select car', '\$30,000'];

List buildYear = List.generate(100, (index) => "${index}");

class FinanceEquipmentDetails extends StatefulWidget {
  FinanceEquipmentDetails({
    Key? key,
    required this.buildYearController,
    required this.makeController,
    required this.modelController,
    required this.buildYearWidget
  }) : super(key: key);
  TextEditingController buildYearController;
  TextEditingController makeController;
  TextEditingController modelController;
  Widget buildYearWidget;

  @override
  State<FinanceEquipmentDetails> createState() => _FinanceEquipmentDetailsState();
}

class _FinanceEquipmentDetailsState extends State<FinanceEquipmentDetails> {
  List buildYear = [];
  late int currentYear;
  int maxYear = 2022;
  range(int a, [int? stop, int? step]) {
    int start;

    if (stop == null) {
      start = 0;
      stop = a;
    } else {
      start = a;
    }

    if (step == 0) throw Exception("Step cannot be 0");

    if (step == null)
      start < stop
          ? step = 1 // walk forwards
          : step = -1; // walk backwards

    return start < stop == step > 0
        ? List<int>.generate(((start - stop) / step).abs().ceil(),
            (int i) => start + (i * step!))
        : [];
  }

  List<int> getSuggestions(String query) {
    List<int> matches = [];
    matches.addAll(range(2022, 1500));
    var matchesList = matches;
    return matchesList;
  }

  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWithStyle(listOfLabel[0]),
              widget.buildYearWidget,
              // Container(
              //   padding: EdgeInsets.only(bottom: 24),
              //   child: TextFormField(
              //     style: MasterStyle.whiteTextInputStyle,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     validator: (value) {
              //       if (value!.trim().isEmpty) {
              //         return 'Please enter build year';
              //       } else if (value.trim().length < 4) {
              //         return 'Please enter valid build year';
              //       }
              //       return null;
              //     },
              //     maxLength: 4,
              //     onChanged: (value) {
              //       if (int.parse(value) > currentYear) {
              //         setState(() {
              //           this.widget.buildYearController.text =
              //               currentYear.toString();
              //         });
              //       }
              //     },
              //     controller: this.widget.buildYearController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //        counterText: '',
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //       hintText: listOfHintText[0],
              //       hintStyle: MasterStyle.whiteHintStyle,
              //       enabledBorder: SimplifiedWidgets.outlineInputBorder,
              //       border: SimplifiedWidgets.outlineInputBorder,
              //       focusedBorder: SimplifiedWidgets.outlineInputBorder,
              //     ),
              //   ),
              // ),
             
              labelWithStyle(listOfLabel[1]),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter equipment make';
                    }
                    return null;
                  },
                  controller: this.widget.makeController,
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
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your equipment model';
                    }
                    return null;
                  },
                  controller: this.widget.modelController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: listOfHintText[2],
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
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
