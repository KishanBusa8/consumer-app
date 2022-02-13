// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/listprovider/loadnlist_provider.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/pages/myloans/carloan/equipment_details.dart';
import 'package:hashching/pages/myloans/finance/finance_equipment_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/industry_type.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/loan_amount_form.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:provider/provider.dart';

class FinanceEnquirey extends StatefulWidget {
  FinanceEnquirey({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;
  @override
  _FinanceEnquireyState createState() => _FinanceEnquireyState();
}

class _FinanceEnquireyState extends State<FinanceEnquirey> {
  bool isNewType = false;
  bool isUsedType = false;
  bool isDealerYes = false;
  bool isDealershipYes = false;
  bool isDealershipNo = true;
  bool isSubmitting = false;
  String? selectedBuildYear;

  bool isCheckBox = false;
  final _currentPageNotifier = ValueNotifier<int>(0);
  final pageController = PageController();
  final equipmentDetailsKey = GlobalKey<FormState>();
  final loanAmountFormkey = GlobalKey<FormState>();
  final selectContactFormkey = GlobalKey<FormState>();
  final industryTypeFormkey = GlobalKey<FormState>();

  TextEditingController buildYearController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController selectDateController = TextEditingController();
  TextEditingController selectTimeController = TextEditingController();
  TextEditingController industryTypeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List listOfPages() {
    if (isUsedType) {
      return [
        EquipmentType(),
        DealershipType(),
        Form(
            key: equipmentDetailsKey,
            child: FinanceEquipmentDetails(
                buildYearWidget: buildYearWidget(),
                buildYearController: buildYearController,
                makeController: makeController,
                modelController: modelController)),
        Form(
            key: loanAmountFormkey,
            child: LoanAmountForm(
              amountController: amountController,
              postcodeController: postcodeController,
            )),
        Form(
          key: industryTypeFormkey,
          child: IndustryType(
              checBoxChange: _checkBox(),
              industryTypeController: industryTypeController,
              priceController: priceController),
        )
      ];
    } else {
      return [
        EquipmentType(),
        Container(),
        Form(
            key: equipmentDetailsKey,
            child: FinanceEquipmentDetails(
                buildYearWidget: buildYearWidget(),
                buildYearController: buildYearController,
                makeController: makeController,
                modelController: modelController)),
        Form(
            key: loanAmountFormkey,
            child: LoanAmountForm(
              amountController: amountController,
              postcodeController: postcodeController,
            )),
        Form(
          key: industryTypeFormkey,
          child: IndustryType(
              checBoxChange: _checkBox(),
              industryTypeController: industryTypeController,
              priceController: priceController),
        )
      ];
    }
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

  late int currentYear;
  List<String> buildYear = [];
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

  @override
  void initState() {
    buildYear = getSuggestions();
    super.initState();
  }

  Widget buildYearWidget() {
    return Container(
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
              hintText: 'Select year',
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
              });
            }));
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
                'Equipment type :',
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

  submitaddnewloan() async {
    var addNewLoanDetails = {
      "product_type": "Equipment Finance",
      "first_name": widget.consumerAccountModel.consumer.firstName,
      "last_name": widget.consumerAccountModel.consumer.lastName,
      "email": widget.consumerAccountModel.consumer.email,
      "mobile": widget.consumerAccountModel.consumer.mobile,
      "loan_amount": amountController.text.toString(),
      "postcode_s": postcodeController.text.toString(),
      "postcode_id": 42253,
      "suburb": postcodeController.text.toString(),
      "state": "QLD",
      "equipment_type": isNewType ? "New Equipment" : "Old Equipment",
      "equipment_dealership": isDealershipYes ? "Yes" : "No",
      "equipment_built_year": selectedBuildYear,
      "equipment_make": makeController.text.toString(),
      "equipment_model": modelController.text.toString(),
      "industry_type": industryTypeController.text.toString(),
      "equipment_price_amount": priceController.text.toString(),
      "employment_status": "Casual",
      "contact_time": "11:00 AM",
      "contact_day": "10  Dec, 2021",
      // "contact_time": selectTimeController.text.toString(),
      // "contact_day": selectDateController.text.toString(),
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
            productType: "Equipment Finance",
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
      snackBar("Assest & Equipement Finance successfully created!");
      Navigator.pop(context);
    } else {
      SimplifiedWidgets.snackBar("something's gone wrong", context);
      setState(() {
        isSubmitting = false;
      });
    }
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
                        } else {
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
                        } else {
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
            "New Asset Finance Equiry",
            style: MasterStyle.appBarTitleStyle,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: MasterStyle.appBarIconColor)),
        ),
        bottomNavigationBar: bottomNavigationBar(),
        body: Container(
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
                              'Equipment type :',
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
                                  padding: EdgeInsets.symmetric(vertical: 12),
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
                                      : MasterStyle.blackTextStyleNormalSize),
                            ),
                            Container(
                              child: SimplifiedWidgets.elevatedButton(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                  if (equipmentDetailsKey.currentState!
                                      .validate()) {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  } else {}
                                } else if (_currentPageNotifier.value == 3) {
                                  if (loanAmountFormkey.currentState!
                                      .validate()) {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  } else {}
                                } else if (_currentPageNotifier.value == 4) {
                                  print("isSubmitting :last index");
                                  if (industryTypeFormkey.currentState!
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
