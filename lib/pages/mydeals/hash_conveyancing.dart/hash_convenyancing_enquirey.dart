// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/validator.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/pages/mydeals/hash_conveyancing.dart/address_info_form.dart';
import 'package:hashching/pages/mydeals/hash_conveyancing.dart/enquirey_details_form.dart';
import 'package:hashching/pages/mydeals/hash_conveyancing.dart/hash_convenyancing_additinal_information.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:provider/provider.dart';

class HashConvenyancingEnquirey extends StatefulWidget {
  HashConvenyancingEnquirey({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;
  @override
  _HashConvenyancingEnquireyState createState() =>
      _HashConvenyancingEnquireyState();
}

class _HashConvenyancingEnquireyState extends State<HashConvenyancingEnquirey> {
  bool isSubmitting = false;

  bool isCheckBox = false;
  final _currentPageNotifier = ValueNotifier<int>(0);
  final pageController = PageController();

  final hashConvenyancingDetailsFormKey = GlobalKey<FormState>();
  final additionalDetailsFormKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController postcodeController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController moveInDateController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController streetTypeController = TextEditingController();
bool isSendCode = false;
  List verifiedConsumer = [];
 
  late String consumerMobileNumber;
  bool isVerifyOtp = false;
  bool isValidOtp = false;
  bool isResend = false;
  final _otpFormKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController(text: '');
  otpResend() {
    FocusScope.of(context).unfocus();
    setState(() {
      isResend = true;
    });

    snackBar('A one time passcode has been resend!');
    setState(() {
      isResend = false;
      otpController.text = '';
    });
  }

  initData() {
    firstNameController.text = widget.consumerAccountModel.consumer.firstName;
    lastNameController.text =
        widget.consumerAccountModel.consumer.lastName;
    emailController.text = widget.consumerAccountModel.consumer.email;
    phoneController.text = widget.consumerAccountModel.consumer.mobile;
    consumerMobileNumber = widget.consumerAccountModel.consumer.mobile;
    verifiedConsumer.add(widget.consumerAccountModel.consumer.mobile);
  }

  Future _otpInputDialog(BuildContext context) async {
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
                  'Enter the OTP sent to +61${phoneController.text}',
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
                onTap: () => otpResend(),
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
                    onPressed: () {
                      if (_otpFormKey.currentState!.validate()) {
                        otpController.clear();
                        setState(() {
                          isSendCode = true;
                        });
                        verifiedConsumer.add(phoneController.text);
                        Navigator.pop(context);
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
        keyboardType: TextInputType.phone,
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
        decoration: InputDecoration(
          errorMaxLines: 3,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintText: 'Phone no:',
          hintStyle: MasterStyle.whiteHintStyle,
          enabledBorder: SimplifiedWidgets.outlineInputBorder,
          border: SimplifiedWidgets.outlineInputBorder,
          focusedBorder: SimplifiedWidgets.outlineInputBorder,
        ),
      ),
    );
  }

  Widget sendCodeButton() {
    return !verifiedConsumer.contains(phoneController.text)
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
                  onPresed: () {
                    if (hashConvenyancingDetailsFormKey.currentState!.validate()) {
                      _otpInputDialog(context);
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
}
  bottomNavigationBar() {
    return Consumer(builder: (BuildContext context, value, Widget? child) {
      return isSubmitting
          ? Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
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
                        onPressed: () async {
                          if (_currentPageNotifier.value == 0) {
                            Navigator.pop(context);
                          } else {
                            print('back');
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
                                style: MasterStyle.secondarySemiBoldTextStyle)
                          ]),
                        )),
                    TextButton(
                        onPressed: () {
                          if (_currentPageNotifier.value == 0) {
                            if (hashConvenyancingDetailsFormKey.currentState!
                                .validate()) {
                                  if (consumerMobileNumber !=
                                        phoneController.text) {
                                      print(isSendCode);
                                      if (isSendCode) {
                                         pageController.animateToPage(
                                            pageController.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeIn);
                                      } else {
                                        snackBar(
                                            "Please verify your phone number");
                                      }
                                    } else {
                                       pageController.animateToPage(
                                          pageController.page!.toInt() + 1,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    
                                  }
                        
                            } else {}
                          } else if (_currentPageNotifier.value == 1) {
                            if (additionalDetailsFormKey.currentState!
                                .validate()) {
                              pageController.animateToPage(
                                  pageController.page!.toInt() + 1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                            } else {}
                          } else if (_currentPageNotifier.value == 2) {
                            if (addressFormKey.currentState!.validate()) {
                              if (isCheckBox) {
                                setState(() {
                                  isSubmitting = true;
                                });
                                submitaddnewHashConvenyancing();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        MasterStyle.appSecondaryColor,
                                    content:
                                        Text('Please select privacy policy'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              print("isSubmitting :last index");
                            } else {}
                          }
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: _currentPageNotifier.value == 2
                                    ? 'submit'.toUpperCase()
                                    : 'Next'.toUpperCase(),
                                style: MasterStyle.secondarySemiBoldTextStyle),
                            WidgetSpan(
                                child: Icon(Icons.arrow_forward_ios,
                                    color: MasterStyle.appSecondaryColor,
                                    size: 18)),
                          ]),
                        )),
                  ]),
            );
    });
  }

  List listOfPages() {
    return [
      Form(
          key: hashConvenyancingDetailsFormKey,
          child: HashConvenyancingEnquireyDetails(
            phoneController: phoneController,
            emailController: emailController,
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            postcodeController: postcodeController,
            checkbox: _checkBox(),
                  sendCodeButton: sendCodeButton(),
            phoneNumberInputField: phoneNumberInputField(),
          )),
      Form(
          key: additionalDetailsFormKey,
          child: HashConvenyancingAdditionalInformation(
              dateOfBirthController: dateOfBirthController,
              postCodeController: postcodeController)),
      Form(
          key: addressFormKey,
          child: HashConvenyancingAddressForm(
              moveInDateController: moveInDateController,
              streetNumberController: streetNumberController,
              streetNameController: streetNameController,
              streetTypeController: streetTypeController,
              checkbox: _checkBox())),
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

  submitaddnewHashConvenyancing() async {
    var addHashconveyDetails = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile":phoneController.text,
      "postcode_s": postcodeController.text.toString(),
      "postcode_id": 39082,
      "title": "Mr",
      "date_of_birth": dateOfBirthController.text.toString(),
      "move_indate": moveInDateController.text.toString(),
      "street_number": streetNumberController.text.toString(),
      "street_name": streetNameController.text.toString(),
      "street_type": streetTypeController.text.toString(),
      "terms_and_conditions": isCheckBox,
    };
    var addNewHashConveny =
        await ApiServices.addNewHashConveny(addHashconveyDetails);
    print('addHashconveyDetails : $addNewHashConveny');
    if (addNewHashConveny) {
      setState(() {
        isSubmitting = false;
      });
       snackBar('successfully submitted');
      Navigator.pop(context);
    } else {
      SimplifiedWidgets.snackBar("something's gone wrong", context);
      setState(() {
        isSubmitting = false;
      });
    }
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
            "New HashConnect Enquiry",
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
            child: Container(
                child: NewColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLinearProgressIndicator(),
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
        ))));
  }
}
