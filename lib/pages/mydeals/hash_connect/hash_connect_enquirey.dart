// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/validator.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/pages/myloans/businessloan/business_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_components.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashConnectEnquirey extends StatefulWidget {
  HashConnectEnquirey({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;

  @override
  _HashConnectEnquireyState createState() => _HashConnectEnquireyState();
}

class _HashConnectEnquireyState extends State<HashConnectEnquirey> {
  final hashConnectPersonalInfoFormKey = GlobalKey<FormState>();

  bool isCheckBox = false;
  bool isSubmitting = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();

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
    lastNameController.text = widget.consumerAccountModel.consumer.lastName!;
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
      padding: EdgeInsets.only(bottom: 24),
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
                    if (hashConnectPersonalInfoFormKey.currentState!
                        .validate()) {
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

  submitaddnewHashConnect() async {
    var addHashConnectDetails = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": phoneController.text,
      "property_address": postcodeController.text.toString(),
    };
    var addNewHashConnect =
        await ApiServices.addNewHashConnect(addHashConnectDetails);
    print('addNewHashConnect : $addNewHashConnect');
    if (addNewHashConnect) {
      snackBar('successfully submitted');
      //   await  ApiServices.fetchHashConvenyancingList();
      setState(() {
        isSubmitting = false;
      });
      Navigator.pop(context);
    } else {
      SimplifiedWidgets.snackBar(
          "something's gone wrong in the server", context);
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
          "New HashConvenyancing Enquiry",
          style: MasterStyle.appBarTitleStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:
                Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor)),
      ),
      bottomNavigationBar: bottomNavigationBar(),
      body: Container(
        child: Form(
            key: hashConnectPersonalInfoFormKey, child: hashPersonalDetails()

            //  HashConnectPersonalDetailsForm(
            //   phoneController: phoneController,
            //   emailController: emailController,
            //   firstNameController: firstNameController,
            //   lastNameController: lastNameController,
            //   postcodeController: postcodeController,
            //   checkbox: _checkBox(),
            //   phoneNumberInputField: phoneNumberInputField(),
            //   sendCodeButton: sendCodeButton(),
            // )
            ),
      ),
    );
  }

  Widget hashPersonalDetails() {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Text(
            'Your personal details :',
            style: MasterStyle.whiteTextStyleNormal,
          ),
        ),
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWithStyle('First name :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  controller: firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'Lynda',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('Last name :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  controller: lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'Haynes',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('E-mail ID :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'lynda.aynes@gmail.com',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),
              labelWithStyle('Phone no :'),
              phoneNumberInputField(),
              sendCodeButton(),
              labelWithStyle('Your suburb/postcode :'),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: TypeAheadFormField(
                  minCharsForSuggestions: 3,
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
                  // keepSuggestionsOnLoading: true,
                  hideOnEmpty: true,
                  hideOnLoading: false,
                  textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (value) {
                        setState(() {});
                      },
                      controller: postcodeController,
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
                    return await ApiServices.getSuggestions(pattern);
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
                        postcodeController.text = postCodeSuggestion;
                      });
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: HexColor('#6D7B95')),
                        child: _checkBox()),
                    Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                        textSpanNormal(text: 'I understand and accept the '),
                        PrivacyPolicy(text: 'privacy policy '),
                        textSpanNormal(text: 'and '),
                        TermsAndConditions(text: 'terms of use.')
                      ])),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 100)
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

  bottomNavigationBar() {
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
                        Navigator.pop(context);
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
                        if (postcodeController.text == '') {
                          snackBar('select postcode');
                        } else {
                          if (hashConnectPersonalInfoFormKey.currentState!
                              .validate()) {
                            if (consumerMobileNumber != phoneController.text) {
                              if (isSendCode) {
                                setState(() {
                                  isSubmitting = true;
                                });
                                submitaddnewHashConnect();
                              } else {
                                snackBar("Please verify your phone number");
                              }
                            } else {
                              setState(() {
                                isSubmitting = true;
                              });
                              submitaddnewHashConnect();
                            }
                          } else {
                            setState(() {
                              isSubmitting = true;
                            });
                            submitaddnewHashConnect();
                            isSubmitting = false;
                          }
                        }
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'submit'.toUpperCase(),
                              style: MasterStyle.secondarySemiBoldTextStyle),
                          WidgetSpan(
                              child: Icon(Icons.arrow_forward_ios,
                                  color: MasterStyle.appSecondaryColor,
                                  size: 18)),
                        ]),
                      )),
                ]),
          );
  }
}
