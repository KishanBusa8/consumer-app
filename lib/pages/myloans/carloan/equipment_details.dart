// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/carmake_model_list.dart';
import 'package:hashching/models/carmakemodel.dart';
import 'package:hashching/services/api_services.dart';
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

class EquipmentDetails extends StatefulWidget {
  EquipmentDetails({
    Key? key,
    required this.buildYearController,
    required this.makeController,
    required this.modelController,
  }) : super(key: key);
  TextEditingController buildYearController;
  TextEditingController makeController;
  TextEditingController modelController;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
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
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter build year';
                    } else if (value.trim().length < 4) {
                      return 'Please enter valid build year';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (int.parse(value) > currentYear) {
                      setState(() {
                        this.widget.buildYearController.text =
                            currentYear.toString();
                      });
                    }
                  },
                  controller: this.widget.buildYearController,
                  keyboardType: TextInputType.number,
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
                      return 'Please enter car make';
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
                      return 'Please enter your car price';
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

class NewEquipmentDetails extends StatefulWidget {
  NewEquipmentDetails(
      {Key? key,
      required this.buildYearController,
      required this.makeController,
      required this.priceController,
      required this.carMakevalue,
      required this.carMake})
      : super(key: key);
  TextEditingController buildYearController;
  TextEditingController makeController;
  TextEditingController priceController;
  Object? carMakevalue;
  List carMake = [];

  @override
  State<NewEquipmentDetails> createState() => NewEquipmentDetailsState();
}

class NewEquipmentDetailsState extends State<NewEquipmentDetails> {
  List<String> buildYear = [];
  List carModelList = [];
  bool isLoading = false;
  bool isCarModelLoading = false;
  bool isCarMakeSelected = false;

  int maxYear = 2022;
  late int currentYear;
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

  List<String> getSuggestions() {
    currentYear = DateTime.now().year;
    List<int> matches = [];
    matches.addAll(range(currentYear, currentYear - 5));
    var matchesList = matches;
    List<String> buildYears = [
      for (int i = 0; i < matchesList.length; i++) matchesList[i].toString()
    ];
    print(matchesList);
    return buildYears;
  }

  bool isExpanded = false;
  @override
  void initState() {
    super.initState();

    buildYear = getSuggestions();
  }

  var _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    return widget.carMake.length == 0
        ? Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(MasterStyle.secondaryThemeColor)),
          )
        : ListView(
            shrinkWrap: true,
            children: [
              SimplifiedWidgets.containerBox(
                radius: 10,
                padding: EdgeInsets.all(16),
                margin:
                    EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 10),
                color: MasterStyle.whiteColor.withOpacity(0.1),
                child: NewColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelWithStyle(listOfLabelNew[0]),
                    Container(
                        height: 40.h,
                        margin: EdgeInsets.only(bottom: 24),
                        child: DropdownButtonFormField(
                            onTap: () {
                              // setState(() {
                              //   isExpanded = true;
                              // });
                            },
                            selectedItemBuilder: (context) {
                              return buildYear
                                  .map(
                                    (map) => DropdownMenuItem(
                                      child: Text(map.toString(),
                                          style: MasterStyle.whiteTextNormal),
                                      value: map,
                                    ),
                                  )
                                  .toList();
                            },
                            isExpanded: isExpanded,
                            style: MasterStyle.whiteTextInputStyle,
                            iconSize: 31,
                            icon: Container(
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: MasterStyle.appSecondaryColor,
                              ),
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                left: 16.w,
                                right: 15.w,
                                bottom: 8.h,
                              ),
                              hintText: listOfHintTextNew[0],
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                            ),
                            items: buildYear
                                .map(
                                  (map) => DropdownMenuItem(
                                    child: Text(map.toString(),
                                        style: MasterStyle.blackWithSmallStyle),
                                    value: map,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {})),
                    // Container(
                    //   padding: EdgeInsets.only(bottom: 24),
                    //   child: TextFormField(
                    //     style: MasterStyle.whiteTextInputStyle,
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     maxLength: 4,
                    //     validator: (value) {
                    //       if (value!.trim().isEmpty) {
                    //         return 'Please enter build year';
                    //       } else if (value.trim().length < 4) {
                    //         return 'Please enter valid build year';
                    //       }
                    //       return null;
                    //     },
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
                    //       counterText: '',
                    //       contentPadding:
                    //           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //       hintText: listOfHintTextNew[0],
                    //       hintStyle: MasterStyle.whiteHintStyle,
                    //       enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    //       border: SimplifiedWidgets.outlineInputBorder,
                    //       focusedBorder: SimplifiedWidgets.outlineInputBorder,
                    //     ),
                    //   ),
                    // ),

                    labelWithStyle(listOfLabelNew[1]),

                    Container(
                      height: 40.h,
                        margin: EdgeInsets.only(bottom: 24),
                        child: DropdownButtonFormField(
                          value:widget.carMake[1],
                            validator: (value) {
                              if (value == null) {
                                return 'please select the car';
                              }
                            },
                          
                            selectedItemBuilder: (context) {
                              return widget.carMake
                                  .map(
                                    (carModel) => DropdownMenuItem(
                                      child: Text(carModel['make'].toString(),
                                          style: MasterStyle.whiteTextNormal),
                                      value: carModel['make'],
                                    ),
                                  )
                                  .toList();
                            },
                            isExpanded: true,
                            style: MasterStyle.whiteTextInputStyle,
                            iconSize: 31,
                            icon: Container(
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: MasterStyle.appSecondaryColor,
                              ),
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                left: 16.w,
                                right: 15.w,
                                bottom: 8.h,
                              ),
                              hintText: listOfHintTextNew[1],
                              hintStyle: MasterStyle.whiteHintStyle,
                            
                              enabledBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder:
                                  SimplifiedWidgets.outlineInputBorder,
                            ),
                            items: widget.carMake
                                .map(
                                  (makeModel) => DropdownMenuItem(
                                    child: Text(makeModel['make'].toString(),
                                        style: MasterStyle.blackWithSmallStyle),
                                    value: makeModel,
                                  ),
                                )
                                .toList(),
                                
                            onChanged: (value) async {
                              setState(() {
                                widget.carMakevalue = value;
                                print("Widget : ${widget.carMakevalue}");
                                isCarMakeSelected = true;
                                isCarModelLoading = true;
                                carModelList.clear();
                                print(
                                    "******************empty ${carModelList}");
                              });
                              CarMakeModelList getCarmakeModel =
                                  await ApiServices.getCarMakeModelList(value);
                              for (var i = 0;
                                  i < getCarmakeModel.response.length;
                                  i++) {
                                setState(() {
                                  carModelList.add({
                                    "make_id":
                                        getCarmakeModel.response[i].makeId,
                                    "model": getCarmakeModel.response[i].model,
                                  });
                                });
                                setState(() {
                                  isCarModelLoading = false;
                                });
                              }
                              print("${carModelList}");
                            })),

                    // Container(
                    //   padding: EdgeInsets.only(bottom: 24),
                    //   child: TextFormField(
                    //     style: MasterStyle.whiteTextInputStyle,
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     validator: (value) {
                    //       if (value!.trim().isEmpty) {
                    //         return 'Please enter your car make';
                    //       }
                    //       return null;
                    //     },
                    //     controller: this.widget.makeController,
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //       contentPadding:
                    //           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //       hintText: listOfHintTextNew[1],
                    //       hintStyle: MasterStyle.whiteHintStyle,
                    //       enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    //       border: SimplifiedWidgets.outlineInputBorder,
                    //       focusedBorder: SimplifiedWidgets.outlineInputBorder,
                    //     ),
                    //   ),
                    // ),
                    isCarMakeSelected
                        ? isCarModelLoading
                            ? Container(
                                margin: EdgeInsets.only(bottom: 24),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      MasterStyle.appSecondaryColor),
                                )))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labelWithStyle("Car model :"),
                                  Container(
                                      height: 40.h,
                                      margin: EdgeInsets.only(bottom: 24),
                                      child: DropdownButtonFormField(
                                          selectedItemBuilder: (context) {
                                            return carModelList
                                                .map(
                                                  (carModel) =>
                                                      DropdownMenuItem(
                                                    child: Text(
                                                        carModel['model']
                                                            .toString(),
                                                        style: MasterStyle
                                                            .whiteTextNormal),
                                                    value: carModel['model'],
                                                  ),
                                                )
                                                .toList();
                                          },
                                          isExpanded: true,
                                          style:
                                              MasterStyle.whiteTextInputStyle,
                                          iconSize: 31,
                                          icon: Container(
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color:
                                                  MasterStyle.appSecondaryColor,
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            counterText: '',
                                            contentPadding: EdgeInsets.only(
                                              left: 16.w,
                                              right: 15.w,
                                              bottom: 8.h,
                                            ),
                                            hintText: listOfHintTextNew[1],
                                            hintStyle:
                                                MasterStyle.whiteHintStyle,
                                            enabledBorder: SimplifiedWidgets
                                                .outlineInputBorder,
                                            border: SimplifiedWidgets
                                                .outlineInputBorder,
                                            focusedBorder: SimplifiedWidgets
                                                .outlineInputBorder,
                                          ),
                                          items: carModelList
                                              .map(
                                                (makeModel) => DropdownMenuItem(
                                                  child: Text(
                                                      makeModel['model']
                                                          .toString(),
                                                      style: MasterStyle
                                                          .blackWithSmallStyle),
                                                  value: makeModel['model'],
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {}))
                                ],
                              )
                        : SizedBox(),
                    labelWithStyle(listOfLabelNew[2]),

                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        style: MasterStyle.whiteTextInputStyle,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (string) {
                          string =
                              '${_formatNumber(string.replaceAll(',', ''))}';
                          widget.priceController.value = TextEditingValue(
                            text: string,
                            selection:
                                TextSelection.collapsed(offset: string.length),
                          );
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter price';
                          }
                          return null;
                        },
                        controller: this.widget.priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          hintText: listOfHintTextNew[2],
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
