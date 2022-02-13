// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/listprovider/loadnlist_provider.dart';
import 'package:hashching/models/carmake_model_list.dart';
import 'package:hashching/models/carmakemodel.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/pages/myloans/carloan/equipment_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/carloan_amount_form.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/loan_amount_form.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/loan_contact_form.dart';
import 'package:hashching/provider/initialdata.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:provider/provider.dart';

class CarLoanEnquireyRoot extends StatefulWidget {
  CarLoanEnquireyRoot({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;

  @override
  _CarLoanEnquireyRootState createState() => _CarLoanEnquireyRootState();
}

class _CarLoanEnquireyRootState extends State<CarLoanEnquireyRoot> {
  bool isNewType = false;
  bool isUsedType = false;
  bool isDealerYes = false;
  bool isDealershipYes = false;
  bool isDealershipNo = false;
  bool isDealershipRequire = false;
  bool isSubmitting = false;
  bool isCheckBox = false;
  bool isCarMakeLoader = false;
  final _currentPageNotifier = ValueNotifier<int>(0);
  final pageController = PageController();
  final equipmentDetailsKey = GlobalKey<FormState>();
  final loanAmountFormkey = GlobalKey<FormState>();
  final selectContactFormkey = GlobalKey<FormState>();

  TextEditingController buildYearController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController carPriceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController selectDateController = TextEditingController();
  TextEditingController selectTimeController = TextEditingController();
  String? selectedCar;
  String? selectedCarModel;
  String? selectedBuildYear;
  List<String> buildYear = [];
  List carModelList = [];
  bool isLoading = false;
  bool isCarModelLoading = false;
  bool isCarMakeSelected = false;
  bool carMakeValidate = false;
  bool carMakeModelValidate = false;
  bool carEquipmentSubmit = false;

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
    matches.addAll(range(currentYear, currentYear - 20));
    var matchesList = matches;
    List<String> buildYears = [
      for (int i = 0; i < matchesList.length; i++) matchesList[i].toString()
    ];
    print(matchesList);
    return buildYears;
  }

  bool isExpanded = false;
  initialData() async {
    if (InitialData.carMakeList.length == 0) {
      setState(() {
        isCarMakeLoader = true;
      });
      CarMakeModel carMakeResponse = await ApiServices.getCarMakeList();
      for (var i = 0; i < carMakeResponse.response.length; i++) {
        setState(() {
          InitialData.carMakeList.add({
            "make_id": carMakeResponse.response[i].makeId.toString(),
            "make": carMakeResponse.response[i].make.toString(),
          });
        });
      }
      setState(() {
        isCarMakeLoader = false;
      });
    } else {}
  }

  @override
  void initState() {
    initialData();
    buildYear = getSuggestions();
    super.initState();
  }

  List listOfPages() {
    if (isUsedType) {
      return [
        EquipmentType(),
        DealershipType(),
        Form(key: equipmentDetailsKey, child: carEquipmentDetailsSection()
            //  NewEquipmentDetails(
            //   carMakevalue: carMakevalue,
            //   buildYearController: buildYearController,
            //   makeController: makeController,
            //   priceController: carPriceController,
            //   carMake: carMake,
            // )

            ),
        Form(
            key: loanAmountFormkey,
            child: LoanAmountForm(
              amountController: amountController,
              postcodeController: postcodeController,
            )),
        Form(
            key: selectContactFormkey,
            child: LoanContactForm(
              checBoxChange: _checkBox(),
              selectDateController: selectDateController,
              selectTimeController: selectTimeController,
            ))
      ];
    } else {
      return [
        EquipmentType(),
        Container(),
        Form(key: equipmentDetailsKey, child: carEquipmentDetailsSection()
            //  NewEquipmentDetails(
            //   carMakevalue: carMakevalue,
            //   buildYearController: buildYearController,
            //   makeController: makeController,
            //   priceController: carPriceController,
            //   carMake: carMake,
            // )
            ),
        Form(
            key: loanAmountFormkey,
            child: CarLoanAmountForm(
                amountController: amountController,
                postcodeController: postcodeController,
                carPriceController: carPriceController)),
        Form(
            key: selectContactFormkey,
            child: LoanContactForm(
              checBoxChange: _checkBox(),
              selectDateController: selectDateController,
              selectTimeController: selectTimeController,
            ))
      ];
    }
  }

  carEquipmentDetailsSection() {
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
              labelWithStyle(listOfLabelNew[0]),
              Container(
                  // height: 40.h,
                  margin: EdgeInsets.only(bottom: 24),
                  child: DropdownButtonFormField<String>(
                      onTap: () {},
                      value: selectedBuildYear,
                      validator: (value) {
                        if (value == null) {
                          return 'select build year';
                        }
                        return null;
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
                      style: MasterStyle.whiteTextInputStyle,
                      iconSize: 31,
                      icon: Container(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: MasterStyle.appSecondaryColor,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(
                          left: 16.w,
                          right: 15.w,
                          bottom: 8.h,
                        ),
                        hintText: listOfHintTextNew[0],
                        hintStyle: MasterStyle.whiteHintStyle,
                        enabledBorder: SimplifiedWidgets.outlineInputBorder,
                        border: SimplifiedWidgets.outlineInputBorder,
                        focusedBorder: SimplifiedWidgets.outlineInputBorder,
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
                      onChanged: (value) {
                        setState(() {
                          selectedBuildYear = value!;
                          carMakeValidate = true;
                        });
                      })),
              labelWithStyle(listOfLabelNew[1]),
              Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: DropdownButtonFormField<String>(
                      value: selectedCar,
                      selectedItemBuilder: (context) {
                        return InitialData.carMakeList
                            .map(
                              (carModel) => DropdownMenuItem(
                                child: Text(carModel['make'].toString(),
                                    style: MasterStyle.whiteTextNormal),
                                value: carModel['make'],
                              ),
                            )
                            .toList();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'select car make';
                        }
                        return null;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(
                          left: 16.w,
                          right: 15.w,
                          bottom: 8.h,
                        ),
                        hintText: listOfHintTextNew[1],
                        hintStyle: MasterStyle.whiteHintStyle,
                        enabledBorder: SimplifiedWidgets.outlineInputBorder,
                        border: SimplifiedWidgets.outlineInputBorder,
                        focusedBorder: SimplifiedWidgets.outlineInputBorder,
                      ),
                      items: InitialData.carMakeList
                          .map(
                            (makeModel) => DropdownMenuItem(
                              child: Text(makeModel['make'].toString(),
                                  style: MasterStyle.blackWithSmallStyle),
                              value: makeModel['make'].toString(),
                            ),
                          )
                          .toList(),
                      onChanged: (value) async {
                        setState(() {
                          selectedCarModel = null;
                          selectedCar = value!;
                          isCarMakeSelected = true;
                          isCarModelLoading = true;
                          carModelList.clear();
                          print("******************empty ${carModelList}");
                        });
                        CarMakeModelList getCarmakeModel =
                            await ApiServices.getCarMakeModelList(value);
                        for (var i = 0;
                            i < getCarmakeModel.response.length;
                            i++) {
                          setState(() {
                            carModelList.add({
                              "make_id": getCarmakeModel.response[i].makeId,
                              "model": getCarmakeModel.response[i].model,
                            });
                          });
                          setState(() {
                            isCarModelLoading = false;
                          });
                        }
                        print("${carModelList}");
                      })),
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
                                // height: 40.h,
                                margin: EdgeInsets.only(bottom: 24),
                                child: DropdownButtonFormField<String>(
                                    value: selectedCarModel,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'select car model ';
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    selectedItemBuilder: (context) {
                                      return carModelList
                                          .map(
                                            (carModel) => DropdownMenuItem(
                                              child: Text(
                                                  carModel['model'].toString(),
                                                  style: MasterStyle
                                                      .whiteTextNormal),
                                              value: carModel['model'],
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
                                      border:
                                          SimplifiedWidgets.outlineInputBorder,
                                      focusedBorder:
                                          SimplifiedWidgets.outlineInputBorder,
                                    ),
                                    items: carModelList
                                        .map(
                                          (makeModel) => DropdownMenuItem(
                                            child: Text(
                                                makeModel['model'].toString(),
                                                style: MasterStyle
                                                    .blackWithSmallStyle),
                                            value:
                                                makeModel['model'].toString(),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        carMakeModelValidate = true;
                                        selectedCarModel = value;
                                      });
                                    })),
                          ],
                        )
                  : SizedBox(),
              labelWithStyle(listOfLabelNew[2]),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (string) {
                    if (string.trim().toString().isNotEmpty) {
                      string = '${_formatNumber(string.replaceAll(',', ''))}';
                      carPriceController.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    }
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Enter price';
                    } else if (value.trim().toString()[0] == '0') {
                      return 'Enter minimum \$1';
                    }
                    return null;
                  },
                  controller: carPriceController,
                  keyboardType: TextInputType.number,
                  maxLength: 15,
                  decoration: InputDecoration(
                    counterText: "",
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

  Checkbox _checkBox() {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      checkColor: MasterStyle.whiteColor,
      activeColor: MasterStyle.appSecondaryColor,
      tristate: false,
      value: isCheckBox,
      onChanged: (value) {
        setState(() {
          isCheckBox = value!;
        });
      },
    );
  }

  Widget EquipmentType() {
    return Column(
      children: [
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car type :',
                style: MasterStyle.secondarySemiBoldTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isNewType
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'New',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isNewType) {
                          isNewType = !isNewType;
                        } else {
                          isUsedType = false;
                          isNewType = false;

                          isNewType = !isNewType;
                        }
                      });
                    },
                    textStyle: isNewType
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              ),
              Container(
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isUsedType
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'Used',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isUsedType) {
                          isUsedType = !isUsedType;
                        } else {
                          isUsedType = !isUsedType;
                          isNewType = false;
                        }
                      });
                    },
                    textStyle: isUsedType
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget DealershipType() {
    return Column(
      children: [
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you buying from a dealership ?',
                style: MasterStyle.secondarySemiBoldTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isDealershipYes
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'Yes',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isDealershipYes) {
                          isDealershipRequire = true;
                          isDealershipYes = !isDealershipYes;
                        } else {
                          isDealershipRequire = false;
                          isDealershipYes = !isDealershipYes;
                          isDealershipNo = false;
                        }
                      });
                    },
                    textStyle: isDealershipYes
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              ),
              Container(
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isDealershipNo
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'No',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isDealershipNo) {
                          isDealershipRequire = true;
                          isDealershipNo = !isDealershipNo;
                        } else {
                          isDealershipRequire = false;
                          isDealershipNo = !isDealershipNo;
                          isDealershipYes = false;
                        }
                      });
                    },
                    textStyle: isDealershipNo
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              )
            ],
          ),
        ),
        Visibility(
            visible: isDealershipRequire,
            child: Text(
              "Please select the dealership option",
              style: MasterStyle.negativeStatusStyle,
            ))
      ],
    );
  }

  buildLinearProgressIndicator() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          LinearProgressPageIndicator(
        itemCount: listOfPages().length,
        currentPageNotifier: _currentPageNotifier,
        progressColor: MasterStyle.appBarIconColor,
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 1,
      ),
    );
  }

  submitaddnewloan() async {
    var addNewLoanDetails = {
      "product_type": "Car Finance",
      "first_name": widget.consumerAccountModel.consumer.firstName,
      "last_name": widget.consumerAccountModel.consumer.lastName,
      "email": widget.consumerAccountModel.consumer.email,
      "mobile": widget.consumerAccountModel.consumer.mobile,
      "loan_amount": amountController.text.toString(),
      "postcode_s": postcodeController.text.toString(),
      "postcode_id": 42253,
      "suburb": postcodeController.text.toString(),
      "state": "QLD",
      "employment_status": "Casual",
      "car_type": isNewType ? "New Car" : "Old Car",
      "car_dealership": isDealershipYes ? "Yes" : "No",
      "built_year": selectedBuildYear,
      "car_make": selectedCar,
      "car_model": selectedCarModel,
      "car_price_amount": carPriceController.text.toString(),
      "contact_time": selectTimeController.text.toString(),
      "contact_day": selectDateController.text.toString(),
      "terms_and_conditions": isCheckBox ? "1" : "0",
      "postcode": postcodeController.text.toString(),
      "timezoneoffset": -330
    };
    var addNewLoan = await ApiServices.addNewLoan(addNewLoanDetails);
    Random _rend = Random();
    Provider.of<LoanListProvider>(context, listen: false).addsinglelist(
        AllLoans(
            id: _rend.nextInt(1000),
            leadType: "New Loan",
            productType: "Car Finance",
            loanAmount: amountController.text.toString(),
            status: 1,
            brokerLeadID: 2,
            createdAt: DateFormat("yyyyMMdd").format(DateTime.now()),
            uniqueId: "42253",
            encryptkey: "qwertyuiop",
            loantypeshow: "Business Loan",
            createdate: DateFormat("yyyyMMdd").format(DateTime.now()),
            statusname: "New"));
    print('addNewLoan : $addNewLoan');
    if (addNewLoan) {
      ApiServices.fetchConsumerLoansList();
      setState(() {
        isSubmitting = false;
      });
      snackBar("Car loan successfully created!");
      Navigator.pop(context);
    } else {
      SimplifiedWidgets.snackBar("something's gone wrong", context);
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: MasterStyle.backgroundColor,
          title: Text(
            "New Car Loan Enquiry",
            style: MasterStyle.appBarTitleStyle,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: MasterStyle.appBarIconColor)),
        ),
        bottomNavigationBar: Visibility(
          child: bottomNavigationBar(),
          visible: !isCarMakeLoader,
        ),
        body: isCarMakeLoader
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
                ),
              )
            : Container(
                child: isNewType || isUsedType
                    ? Container(
                        child: NewColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isNewType || isUsedType
                              ? buildLinearProgressIndicator()
                              : SizedBox(),
                          Expanded(
                            child: PageView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              itemCount: listOfPages().length,
                              onPageChanged: (int index) {
                                setState(() {
                                  _currentPageNotifier.value = index;
                                });

                                print('index :$index');
                                print(
                                    ' _currentPageNotifier.value  :${_currentPageNotifier.value}');
                              },
                              itemBuilder: (_, index) {
                                return listOfPages()[index];
                              },
                            ),
                          ),
                        ],
                      ))

                    // ? CarLoanEnquirey(
                    //     isNewType: isNewType,
                    //     isUsedType: isUsedType,
                    //     listOfPages: listOfPages(),
                    //     currentPageNotifier: _currentPageNotifier,
                    //     isDealershipNo: isDealershipNo,
                    //     isDealershipYes: isDealershipYes,
                    //     pageController: pageController,
                    //     buildLinearProgressIndicator: buildLinearProgressIndicator,
                    //   )
                    : Column(
                        children: [
                          SimplifiedWidgets.containerBox(
                            radius: 10,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(
                                top: 40, left: 16, right: 16, bottom: 10),
                            color: MasterStyle.whiteColor.withOpacity(0.1),
                            child: NewColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Car type :',
                                  style: MasterStyle.secondarySemiBoldTextStyle,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16, bottom: 8),
                                  child: SimplifiedWidgets.elevatedButton(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: isNewType
                                          ? MasterStyle.appSecondaryColor
                                          : MasterStyle.whiteColor,
                                      text: 'New',
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      onPresed: () {
                                        setState(() {
                                          if (isNewType) {
                                            isNewType = !isNewType;
                                          } else {
                                            isNewType = !isNewType;
                                            isUsedType = false;
                                          }
                                        });
                                      },
                                      textStyle: isNewType
                                          ? MasterStyle.buttonWhiteTextStyle
                                          : MasterStyle
                                              .blackTextStyleNormalSize),
                                ),
                                Container(
                                  child: SimplifiedWidgets.elevatedButton(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: isUsedType
                                          ? MasterStyle.appSecondaryColor
                                          : MasterStyle.whiteColor,
                                      text: 'Used',
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      onPresed: () {
                                        setState(() {
                                          if (isUsedType) {
                                            isUsedType = !isUsedType;
                                          } else {
                                            isUsedType = !isUsedType;
                                            isNewType = false;
                                            // listOfPages = [
                                            //   EquipmentType(),
                                            //   DealershipType(),
                                            //   financeEnquireyDetails(),
                                            //   financeLoanAdditionalDetails(),
                                            // ];
                                          }
                                        });
                                      },
                                      textStyle: isUsedType
                                          ? MasterStyle.buttonWhiteTextStyle
                                          : MasterStyle
                                              .blackTextStyleNormalSize),
                                )
                              ],
                            ),
                          ),
                        ],
                      )));
  }

  bottomNavigationBar() {
    return isNewType || isUsedType
        ? Consumer(builder: (BuildContext context, value, Widget? child) {
            return isSubmitting
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              MasterStyle.appSecondaryColor),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 20),
                    color: MasterStyle.whiteColor.withOpacity(.1),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                if (_currentPageNotifier.value == 0) {
                                  setState(() {
                                    isNewType = false;
                                    isUsedType = false;
                                  });
                                } else if (_currentPageNotifier.value == 2) {
                                  print('data');
                                  if (isNewType) {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() - 2,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  } else {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() - 1,
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  }
                                } else {
                                  pageController.animateToPage(
                                      pageController.page!.toInt() - 1,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
                                }
                              },
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.arrow_back_ios,
                                    color: MasterStyle.appSecondaryColor,
                                    size: 18,
                                  )),
                                  TextSpan(
                                      text: 'Prev'.toUpperCase(),
                                      style: MasterStyle
                                          .secondarySemiBoldTextStyle)
                                ]),
                              )),
                          TextButton(
                              onPressed: () async {
                                if (_currentPageNotifier.value == 0) {
                                  if (isNewType) {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 2,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  } else {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  }
                                } else if (_currentPageNotifier.value == 2) {
                                  if (!isCarModelLoading) {
                                    if (equipmentDetailsKey.currentState!
                                        .validate()) {
                                      pageController.animateToPage(
                                          pageController.page!.toInt() + 1,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    } else {}
                                  } else {
                                    snackBar(
                                        'Wait until the car model is created for you');
                                  }
                                } else if (_currentPageNotifier.value == 1 &&
                                    isUsedType) {
                                  if (isDealershipYes || isDealershipNo) {
                                    setState(() {
                                      isDealershipRequire = false;
                                    });
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  } else {
                                    setState(() {
                                      isDealershipRequire = true;
                                    });
                                  }
                                } else if (_currentPageNotifier.value == 3) {
                                  if (loanAmountFormkey.currentState!
                                      .validate()) {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  } else {}
                                } else if (_currentPageNotifier.value == 4) {
                                  if (selectContactFormkey.currentState!
                                      .validate()) {
                                    if (isCheckBox) {
                                      setState(() {
                                        isSubmitting = true;
                                      });
                                      submitaddnewloan();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              MasterStyle.appSecondaryColor,
                                          content: Text(
                                              'Please select privacy policy'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  } else {}
                                } else {
                                  await pageController
                                      .animateToPage(
                                          pageController.page!.toInt() + 1,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeIn)
                                      .then((value) => {
                                            print('after' +
                                                pageController.page!
                                                    .toInt()
                                                    .toString())
                                          });
                                }
                              },
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: _currentPageNotifier.value == 4
                                          ? 'submit'.toUpperCase()
                                          : 'Next'.toUpperCase(),
                                      style: MasterStyle
                                          .secondarySemiBoldTextStyle),
                                  WidgetSpan(
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: MasterStyle.appSecondaryColor,
                                          size: 18)),
                                ]),
                              )),
                        ]),
                  );
          })
        : SizedBox();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MasterStyle.appSecondaryColor,
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

var _locale = 'en';
String _formatNumber(String s) =>
    NumberFormat.decimalPattern(_locale).format(int.parse(s));

labelWithStyle(label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      label,
      style: MasterStyle.secondarySemiBoldTextStyle,
    ),
  );
}
