// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/validator.dart';
import 'package:hashching/listprovider/loadnlist_provider.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/new_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_amount_form.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_contact_form.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:provider/provider.dart';

class HomeLoanEnquirey extends StatefulWidget {
  HomeLoanEnquirey({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;
  @override
  _HomeLoanEnquireyState createState() => _HomeLoanEnquireyState();
}

class _HomeLoanEnquireyState extends State<HomeLoanEnquirey>
    with SingleTickerProviderStateMixin {
  bool isNewLoan = false;
  bool isRequired = false;
  bool isRefinance = false;
  bool isLiveIn = false;
  bool isInverst = false;
  bool isPurposeOfLoan = false;
  bool isSendCodeLoading = false;
  bool isSubmitting = false;
  final personalDetailsFormkey = GlobalKey<FormState>();
  final loanAmountFormkey = GlobalKey<FormState>();
  final selectContactFormkey = GlobalKey<FormState>();
  TextEditingController selectDateController = TextEditingController();
  TextEditingController selectTimeController = TextEditingController();

  late AnimationController controller;
  final pageController = PageController();
  String responseId = '';
  late Animation animation;
  double beginAnim = 0.0;
  double endAnim = 3.0;
  bool isCheckBox = false;
  final _currentPageNotifier = ValueNotifier<int>(0);

  bool isSendCode = false;
  List verifiedConsumer = [];

  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController amountController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  late String consumerMobileNumber;
  bool isVerifyOtp = false;
  bool isValidOtp = false;
  bool isResend = false;
  final _otpFormKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController(text: '');
  otpResend(request) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isResend = true;
    });
    var sendcodeResponse = await ApiServices.sendCode(request);
    if (sendcodeResponse['status'] == 101) {
      snackBar('A one time passcode has been resend!');
    } else {
      snackBar('Failed resend!');
    }

    setState(() {
      isResend = false;
      otpController.text = '';
    });
  }

  initData() {
    firstNameController.text = widget.consumerAccountModel.consumer.firstName;
    lastNameController.text = widget.consumerAccountModel.consumer.lastName!;
    emailController.text = widget.consumerAccountModel.consumer.email;
    phoneController.text = widget.consumerAccountModel.consumer.convertMobile;
    consumerMobileNumber = widget.consumerAccountModel.consumer.convertMobile;
    print("----------------->");
    print(consumerMobileNumber);
    verifiedConsumer.add(widget.consumerAccountModel.consumer.convertMobile);
  }

  Future _otpInputDialog(BuildContext context) async {
    var request = {"mobile": phoneController.text.substring(1)};
    return showDialog(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          contentPadding: EdgeInsets.only(top: 19.0),
          backgroundColor: HexColor('#D1D5DB'),
          content: NewColumnMin(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter verification code',
                style: MasterStyle.blackWithSemiBoldStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 22, bottom: 16, top: 4),
                child: Text(
                  'Enter the OTP sent to ${phoneController.text}',
                  style: MasterStyle.blackWithSmallStyle,
                ),
              ),
              Form(
                key: _otpFormKey,
                child: Container(
                  // height: 30,
                  margin: EdgeInsets.only(left: 16, right: 17, bottom: 4),
                  padding: EdgeInsets.only(top: 0),
                  child: new TextFormField(
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the otp';
                      } else if (value.trim().length < 6) {
                        return 'Please enter the valid otp';
                      }
                      return null;
                    },
                    controller: otpController,
                    cursorColor: MasterStyle.appSecondaryColor,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        isDense: true,
                        focusedErrorBorder: InputBorder.none,
                        hoverColor: MasterStyle.whiteColor,
                        contentPadding: EdgeInsets.only(
                          top: 7,
                          left: 5,
                          bottom: 5,
                        ),
                        filled: true,
                        counterText: '',
                        fillColor: MasterStyle.whiteColor,
                        errorBorder: const OutlineInputBorder(
                          gapPadding: 50.0,
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          gapPadding: 50.0,
                        ),
                        hintText: 'Enter the OTP',
                        hintStyle: GoogleFonts.sourceSerifPro(
                            color: HexColor("#3C3C434D"), fontSize: 13)),
                    onChanged: (value) {
                      if (value.trim().isEmpty || value.trim().length < 6) {
                        setState(() {
                          isValidOtp == true;
                        });
                      }
                      setState(() {
                        isValidOtp == false;
                      });
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () => otpResend(request),
                child: Container(
                  padding: EdgeInsets.only(right: 20),
                  child: isResend
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              MasterStyle.backgroundColor),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              Text(
                                'Resend code',
                                style: MasterStyle.primaryContentStyle,
                              )
                            ]),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 4),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                    child: Text(
                      'Verify',
                      style: MasterStyle.primaryContentStyle,
                    ),
                    onPressed: () async {
                      if (_otpFormKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        var checkIfValidate = await ApiServices.verifyMobileOtp(
                            mobile: phoneController.text.substring(1),
                            sms: otpController.text,
                            uuid: responseId);
                        if (checkIfValidate['status'] != null) {
                          if (checkIfValidate['status'] == 'pass') {
                            snackBar('Phone number successfully verified!');
                            verifiedConsumer.add(phoneController.text);
                            otpController.clear();
                            Navigator.pop(context);
                          } else if (checkIfValidate['status'] == 'failed') {
                            snackBar(checkIfValidate['message']['error']);
                          }
                        } else {
                          snackBar(checkIfValidate['message'].toString());
                        }

                        setState(() {
                          isSendCode = true;
                        });
                      } else {}
                    },
                  )
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget phoneNumberInputField() {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        style: MasterStyle.whiteTextInputStyle,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => FormValidator.phoneNumberValidation(value),
        controller: phoneController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            phoneController.text == value;
          });
          print("${verifiedConsumer.toString()}");

          if (verifiedConsumer.contains(phoneController.text)) {
            setState(() {
              isSendCode = true;
            });
            print('true  $isSendCode');
          } else if (phoneController.text == consumerMobileNumber) {
            setState(() {
              isSendCode = true;
            });
            print('true ! $isSendCode');
          } else {
            print('false 1 $isSendCode');
            setState(() {
              isSendCode = false;
            });
            print('false 2 $isSendCode');
          }
        },
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          errorMaxLines: 3,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintText: listOfHintText[2],
          hintStyle: MasterStyle.whiteHintStyle,
          enabledBorder: SimplifiedWidgets.outlineInputBorder,
          border: SimplifiedWidgets.outlineInputBorder,
          focusedBorder: SimplifiedWidgets.outlineInputBorder,
        ),
      ),
    );
  }

  Widget sendCodeButton() {
    return isSendCodeLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
            ),
          )
        : !verifiedConsumer.contains(phoneController.text) &&
                phoneController.text.length == 10
            ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  height: 25.h,
                  child: SimplifiedWidgets.elevatedButton(
                      padding: EdgeInsets.only(
                          left: 25.w, right: 25.w, top: 3.h, bottom: 3.h),
                      text: 'Send code',
                      textStyle: MasterStyle.whiteStyleRegularNormal,
                      color: MasterStyle.appSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      onPresed: () async {
                        if (personalDetailsFormkey.currentState!.validate()) {
                          setState(() {
                            isSendCodeLoading = true;
                          });
                          var request = {
                            "mobile": phoneController.text.substring(1)
                          };
                          var sendCodeDetails =
                              await ApiServices.sendCode(request);
                          if (sendCodeDetails['status'] == 101) {
                            setState(() {
                              responseId = sendCodeDetails['responseId'];
                            });
                            _otpInputDialog(context);
                            setState(() {
                              isSendCodeLoading = false;
                            });
                          } else if (sendCodeDetails['status'] == 103) {
                            snackBar('Something went wrong');
                            setState(() {
                              isSendCodeLoading = false;
                            });
                          } else {
                            setState(() {
                              isSendCodeLoading = false;
                            });
                          }
                        } else {
                          snackBar('Please enter required fields');
                        }
                      }),
                )
              ])
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

  @override
  void initState() {
    super.initState();
    initData();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {
          // Change here any Animation object value.
        });
      });
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  List<Widget> listOfPages() {
    return [
      homeLoanType(),
      purposeOfLoan(),
      Form(
          key: personalDetailsFormkey,
          child: NewLoanPersonalDetails(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            emailController: emailController,
            phoneController: phoneController,
            sendCodeButton: sendCodeButton(),
            phoneNumberInputField: phoneNumberInputField(),
          )),
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

  Widget homeLoanType() {
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
                'Select loan type :',
                style: MasterStyle.secondarySemiBoldTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isNewLoan
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'New Loan',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isNewLoan) {
                          isNewLoan = !isNewLoan;
                          controller.reset();
                        } else {
                          isNewLoan = !isNewLoan;
                          isRefinance = false;
                          controller.forward();
                        }
                      });
                    },
                    textStyle: isNewLoan
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              ),
              Container(
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isRefinance
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'Refinance',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isRefinance) {
                          isRefinance = !isRefinance;
                          controller.reset();
                        } else {
                          isRefinance = !isRefinance;
                          isNewLoan = false;
                          controller.forward();
                        }
                      });
                    },
                    textStyle: isRefinance
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget purposeOfLoan() {
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
                'Purpose of loan :',
                style: MasterStyle.secondarySemiBoldTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isLiveIn
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'To live in',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isLiveIn) {
                          setState(() {
                            isRequired = true;
                          });
                        } else {
                          isRequired = false;
                        }

                        // if (!isLiveIn) {
                        isLiveIn = !isLiveIn;
                        isInverst = false;
                        print("isLive");
                        // }
                      });
                    },
                    textStyle: isLiveIn
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              ),
              Container(
                child: SimplifiedWidgets.elevatedButton(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isInverst
                        ? MasterStyle.appSecondaryColor
                        : MasterStyle.whiteColor,
                    text: 'To invest',
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPresed: () {
                      setState(() {
                        if (isInverst) {
                          setState(() {
                            isRequired = true;
                          });
                        } else {
                          isRequired = false;
                        }
                        // if (!isInverst) {
                        print('is inverst');
                        isInverst = !isInverst;
                        isLiveIn = false;
                        // }
                      });
                    },
                    textStyle: isInverst
                        ? MasterStyle.buttonWhiteTextStyle
                        : MasterStyle.blackTextStyleNormalSize),
              )
            ],
          ),
        ),
        Visibility(
            visible: isRequired,
            child: Text(
              "Please select the loan option",
              style: MasterStyle.negativeStatusStyle,
            ))
      ],
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
            "New Home Loan Enquiry",
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
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isNewLoan || isRefinance
                  ? _buildLinearProgressIndicator()
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
                    print(
                        ' _currentPageNotifier.value  :${_currentPageNotifier.value}');
                  },
                  itemBuilder: (_, index) {
                    return listOfPages()[index];
                  },
                ),
              ),
            ],
          ),
        ));
  }

  _buildLinearProgressIndicator() {
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
      "product_type": "Home Loan",
      "loan_type": isNewLoan ? "New Loan" : "Refinance",
      "owner_or_investment_property":
          isLiveIn ? "Owner Occupied" : "Investment Occupied",
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": phoneController.text,
      "estimated_property_value": "400324",
      "loan_amount": amountController.text.toString().replaceAll(',', ''),
      "postcode_s": postcodeController.text.toString(),
      "postcode_id": "42253",
      "suburb": postcodeController.text.toString(),
      "state": "QLD",
      "employment_status": "Casual",
      "contact_time": selectTimeController.text.toString(),
      "contact_day": selectDateController.text.toString(),
      "terms_and_conditions": isCheckBox ? "1" : "0",
      "postcode": postcodeController.text.toString(),
      "timezoneoffset": "-330",
      "current_lender": "buyer"
    };
    var addNewLoan = await ApiServices.addNewLoan(addNewLoanDetails);
    Random _rend = Random();
    Provider.of<LoanListProvider>(context, listen: false).addsinglelist(
        AllLoans(
            id: _rend.nextInt(1000),
            leadType: isNewLoan ? "New Loan" : "Refinance",
            productType: "Home Loan",
            loanAmount: amountController.text.toString().replaceAll(',', ''),
            status: isNewLoan ? 1 : 0,
            brokerLeadID: 2,
            createdAt: DateFormat("yyyyMMdd").format(DateTime.now()),
            uniqueId: "42253",
            encryptkey: "qwertyuiop",
            loantypeshow: "Home Loan",
            createdate: DateFormat("yyyyMMdd").format(DateTime.now()),
            statusname: "New"));
    print('addNewLoan : $addNewLoan');
    if (addNewLoan) {
      ApiServices.fetchConsumerLoansList();
      setState(() {
        isSubmitting = false;
      });
      snackBar("Home loan successfully created!");
      Navigator.pop(context);
    } else {
      SimplifiedWidgets.snackBar("something's gone wrong", context);
      setState(() {
        isSubmitting = false;
      });
    }
  }

  bottomNavigationBar() {
    return isNewLoan || isRefinance
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
                                if (pageController.page!.toInt() == 2) {
                                  setState(() {
                                    isPurposeOfLoan = true;
                                  });
                                }
                                if (_currentPageNotifier.value == 4) {
                                  setState(() {
                                    isSubmitting = false;
                                  });
                                }

                                if (pageController.page!.toInt() == 0) {
                                  setState(() {
                                    isNewLoan = false;
                                    isRefinance = false;
                                    isLiveIn = false;
                                    controller.reset();
                                  });
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
                                  setState(() {
                                    // isLiveIn = true;
                                    isPurposeOfLoan = true;
                                  });
                                }
                                if (pageController.page!.toInt() == 1) {
                                  setState(() {
                                    isPurposeOfLoan = false;
                                  });
                                }
                                if (_currentPageNotifier.value == 4) {
                                  print('isSubmitting');
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
                                  }
                                  return null;
                                } else if (_currentPageNotifier.value == 2) {
                                  print(
                                      'personal details invalid${_currentPageNotifier.value}');
                                  if (personalDetailsFormkey.currentState!
                                      .validate()) {
                                    if (consumerMobileNumber !=
                                        phoneController.text) {
                                      print(isSendCode);
                                      if (isSendCode) {
                                        await pageController.animateToPage(
                                            pageController.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeIn);
                                      } else {
                                        snackBar(
                                            "Please verify your phone number");
                                      }
                                    } else {
                                      await pageController.animateToPage(
                                          pageController.page!.toInt() + 1,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    }
                                  } else {
                                    print('personal details invalid');
                                  }
                                } else if (_currentPageNotifier.value == 3) {
                                  print(
                                      'personal details invalid ${_currentPageNotifier.value}');
                                  if (loanAmountFormkey.currentState!
                                      .validate()) {
                                    await pageController
                                        .animateToPage(
                                            pageController.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeIn)
                                        .then((value) => {
                                              print('after' +
                                                  pageController.page!
                                                      .toInt()
                                                      .toString())
                                            });
                                  } else {
                                    print('loan amount details invalid');
                                  }
                                } else {
                                  if (pageController.page!.toInt() == 1 &&
                                      !isLiveIn &&
                                      !isInverst) {
                                    setState(() {
                                      isRequired = true;
                                    });
                                  } else {
                                    await pageController
                                        .animateToPage(
                                            pageController.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeIn)
                                        .then((value) => {
                                              print('after' +
                                                  pageController.page!
                                                      .toInt()
                                                      .toString())
                                            });
                                    if (_currentPageNotifier.value == 4) {
                                      setState(() {
                                        isSubmitting = true;
                                      });
                                    }
                                  }
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
}
