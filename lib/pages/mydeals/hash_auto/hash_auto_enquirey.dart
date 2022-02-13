// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/validator.dart';
import 'package:hashching/models/carmake_model_list.dart';
import 'package:hashching/models/carmakemodel.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/pages/mydeals/hash_auto/auto_comments.dart';
import 'package:hashching/pages/mydeals/hash_auto/hash_auto_body_type.dart';
import 'package:hashching/pages/mydeals/hash_auto/hash_auto_enquirey_details.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:provider/provider.dart';

class HashAutoEnquirey extends StatefulWidget {
  HashAutoEnquirey({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;
  @override
  _HashAutoEnquireyState createState() => _HashAutoEnquireyState();
}

class _HashAutoEnquireyState extends State<HashAutoEnquirey> {
  bool isNewType = false;
  bool isUsedType = false;
  bool isDealerYes = false;
  bool isDealershipYes = false;
  bool isDealershipNo = true;
  bool isSubmitting = false;

  bool isCheckBox = false;
  final _currentPageNotifier = ValueNotifier<int>(0);
  final pageController = PageController();
  final equipmentDetailsKey = GlobalKey<FormState>();
  final hashAutoDetailsFormKey = GlobalKey<FormState>();
  final hashAutoSelectFormKey = GlobalKey<FormState>();
  final hashAutoBodyFormKey = GlobalKey<FormState>();
  final hashAutoCommentFormKey = GlobalKey<FormState>();
  final loanAmountFormkey = GlobalKey<FormState>();
  final selectContactFormkey = GlobalKey<FormState>();
  final industryTypeFormkey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController buildYearController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController contitionController = TextEditingController();
  TextEditingController bagdeController = TextEditingController(text: '');
  TextEditingController bodyTypeController = TextEditingController(text: '');
  TextEditingController selectYearController = TextEditingController(text: '');
  TextEditingController hashCommentsController =
      TextEditingController(text: '');
  TextEditingController kilometersController = TextEditingController(text: '');

  bool isSendCode = false;
  List verifiedConsumer = [];

  late String consumerMobileNumber;
  bool isVerifyOtp = false;
  bool isValidOtp = false;
  bool isResend = false;
  String? selectedHashMake;
  String? selectedHashMakeModel;
  String? selectedCondition;
  bool isLoading = false;
  bool isHashModelLoading = false;
  bool isHashMakeSelected = false;

  bool carMakeModelValidate = false;

  List hashMake = [];
  List carModelList = [];
  List hashConditons = ['New Car', 'Demonstrator', 'Pre-owned'];
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

  initData() async {
    firstNameController.text = widget.consumerAccountModel.consumer.firstName;
    lastNameController.text = widget.consumerAccountModel.consumer.lastName!;
    emailController.text = widget.consumerAccountModel.consumer.email;
    phoneController.text = widget.consumerAccountModel.consumer.mobile;
    consumerMobileNumber = widget.consumerAccountModel.consumer.mobile;
    verifiedConsumer.add(widget.consumerAccountModel.consumer.mobile);
    CarMakeModel carMakeResponse = await ApiServices.getCarMakeList();
    for (var i = 0; i < carMakeResponse.response.length; i++) {
      setState(() {
        hashMake.add({
          "make_id": carMakeResponse.response[i].makeId,
          "make": carMakeResponse.response[i].make,
        });
      });
    }
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
                    if (hashAutoDetailsFormKey.currentState!.validate()) {
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
                              onPressed: () async {
                                if (_currentPageNotifier.value == 0) {
                                  setState(() {
                                    isNewType = false;
                                    isUsedType = false;
                                  });
                                } else if (_currentPageNotifier.value == 4) {
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
                                } else if (_currentPageNotifier.value == 3) {
                                  print('object');
                                  pageController.animateToPage(
                                      pageController.page!.toInt() - 1,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
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
                              onPressed: () {
                                if (_currentPageNotifier.value == 0) {
                                  pageController.animateToPage(
                                      pageController.page!.toInt() + 1,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
                                } else if (_currentPageNotifier.value == 2) {
                                  if (!isHashModelLoading) {
                                    if (hashAutoSelectFormKey.currentState!
                                        .validate()) {
                                      if (isNewType) {
                                        pageController.animateToPage(
                                            pageController.page!.toInt() + 2,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                      } else {
                                        pageController.animateToPage(
                                            pageController.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeIn);
                                      }
                                    } else {}
                                  } else {
                                    snackBar(
                                        'Wait until the hash model is created for you');
                                  }
                                } else if (_currentPageNotifier.value == 0) {
                                  if (hashAutoDetailsFormKey.currentState!
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
                                } else if (_currentPageNotifier.value == 3) {
                                  if (hashAutoBodyFormKey.currentState!
                                      .validate()) {
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  } else {
                                    print("failure");
                                  }
                                } else if (_currentPageNotifier.value == 4) {
                                  print("isSubmitting :last index1");
                                  if (hashAutoCommentFormKey.currentState!
                                      .validate()) {
                                    if (isCheckBox) {
                                      setState(() {
                                        isSubmitting = true;
                                      });
                                      submitaddnewHashAuto();
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
                                  pageController.animateToPage(
                                      pageController.page!.toInt() + 1,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
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

  List listOfPages() {
    if (isUsedType) {
      return [
        EquipmentType(),
        Form(
            key: hashAutoDetailsFormKey,
            child: HashAutoEnquireyDetails(
                phoneController: phoneController,
                emailController: emailController,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                postcodeController: postcodeController,
                checkbox: _checkBox(),
                sendCodeButton: sendCodeButton(),
                phoneNumberInputField: phoneNumberInputField(),
                postCodeWidget: postCodeWidget())),
        Form(
            key: hashAutoSelectFormKey,
            child: hashEquipmentDetailsSection(
                // contitionController: contitionController,
                // makeController: makeController,
                // modelController: modelController,
                // bagdeController: bagdeController

                )),
        Form(
            key: hashAutoBodyFormKey,
            child: HashAutoBodyType(
                bodyTypeController: bodyTypeController,
                kilometersController: kilometersController,
                selectYearController: selectYearController)),
        Form(
          key: hashAutoCommentFormKey,
          child: HashAutoComments(
              hashCommentsController: hashCommentsController,
              checkbox: _checkBox()),
        )
      ];
    } else {
      return [
        EquipmentType(),
        Form(
            key: hashAutoDetailsFormKey,
            child: HashAutoEnquireyDetails(
                phoneController: phoneController,
                emailController: emailController,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                postcodeController: postcodeController,
                checkbox: _checkBox(),
                sendCodeButton: sendCodeButton(),
                phoneNumberInputField: phoneNumberInputField(),
                postCodeWidget: postCodeWidget())),
        Form(
            key: hashAutoSelectFormKey,
            child: hashEquipmentDetailsSection(
                // contitionController: contitionController,
                // makeController: makeController,
                // modelController: modelController,
                // bagdeController: bagdeController
                )),
        Container(),
        Form(
          key: hashAutoCommentFormKey,
          child: HashAutoComments(
              hashCommentsController: hashCommentsController,
              checkbox: _checkBox()),
        )
      ];
    }
  }

  Widget postCodeWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: TypeAheadFormField(
        minCharsForSuggestions: 3,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(hasScrollbar: true),
        loadingBuilder: (context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
            ),
          );
        },

        // keepSuggestionsOnLoading: true,
        hideOnEmpty: true,
        hideOnLoading: false,
        textFieldConfiguration: TextFieldConfiguration(
            onSubmitted: (value) {
              setState(() {
                // postcodeController.text = '';
              });
            },
            controller: postcodeController,
            style: MasterStyle.whiteTextInputStyle,
            cursorColor: MasterStyle.customGreyColor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Text(
            'About the vehicle',
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
              Text(
                'Is this vehicle :',
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

  hashEquipmentDetailsSection() {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Text(
            'About the vehicle',
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
              labelWithStyle('Select condition :'),
              Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: DropdownButtonFormField<String>(
                      value: selectedCondition,
                      selectedItemBuilder: (context) {
                        return hashConditons
                            .map(
                              (condition) => DropdownMenuItem(
                                child: Text(condition.toString(),
                                    style: MasterStyle.whiteTextNormal),
                                value: condition,
                              ),
                            )
                            .toList();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'select conditions';
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
                        hintText: 'Select',
                        hintStyle: MasterStyle.whiteHintStyle,
                        enabledBorder: SimplifiedWidgets.outlineInputBorder,
                        border: SimplifiedWidgets.outlineInputBorder,
                        focusedBorder: SimplifiedWidgets.outlineInputBorder,
                      ),
                      items: hashConditons
                          .map(
                            (condition) => DropdownMenuItem(
                              child: Text(condition.toString(),
                                  style: MasterStyle.blackWithSmallStyle),
                              value: condition.toString(),
                            ),
                          )
                          .toList(),
                      onChanged: (value) async {
                        setState(() {
                          selectedCondition = value;
                        });
                      })),
              labelWithStyle('Select make :'),
              Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: DropdownButtonFormField<String>(
                      value: selectedHashMake,
                      selectedItemBuilder: (context) {
                        return hashMake
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
                          return 'select make';
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
                        hintText: 'Select',
                        hintStyle: MasterStyle.whiteHintStyle,
                        enabledBorder: SimplifiedWidgets.outlineInputBorder,
                        border: SimplifiedWidgets.outlineInputBorder,
                        focusedBorder: SimplifiedWidgets.outlineInputBorder,
                      ),
                      items: hashMake
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
                          selectedHashMakeModel = null;
                          selectedHashMake = value!;
                          isHashMakeSelected = true;
                          isHashModelLoading = true;
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
                            isHashModelLoading = false;
                          });
                        }
                        print("${carModelList}");
                      })),
              isHashMakeSelected
                  ? isHashModelLoading
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
                            labelWithStyle('Select model :'),
                            Container(
                                // height: 40.h,
                                margin: EdgeInsets.only(bottom: 24),
                                child: DropdownButtonFormField<String>(
                                    value: selectedHashMakeModel,
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
                                      hintText: 'Select',
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
                                        selectedHashMakeModel = value;
                                      });
                                    })),
                          ],
                        )
                  : SizedBox(),
              labelWithStyle('Select badge :'),
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter valid badge';
                    }
                    return null;
                  },
                  controller: bagdeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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

  submitaddnewHashAuto() async {
    print("object1${postcodeController.text}");
    var addHashAutoDetails = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": phoneController.text,
      "type": "Buy",
      "postcode_s":
          "2000, Haymarket, NSW", //postcodeController.text.toString(),
      "postcode_id": 39082,
      "suburb": postcodeController.text.toString(),

      "state": "VIC",
      "offset": "-330",
      "make": selectedHashMake,
      "model": selectedHashMakeModel,
      "condition": selectedCondition,
      "badge": bagdeController.text.toString(),
      "comments": hashCommentsController.text.toString(),
      "body_type": bodyTypeController.text == ''
          ? '1'
          : bodyTypeController.text.toString(),
      "years": selectYearController.text == ''
          ? '1'
          : selectYearController.text.toString(),
      "kilometers": kilometersController.text == ''
          ? '1'
          : kilometersController.text.toString()
    };
    print('object $addHashAutoDetails');
    var addNewHashAuto = await ApiServices.addNewHashAuto(addHashAutoDetails);
    print('addNewHashAuto : $addNewHashAuto');
    if (addNewHashAuto) {
      snackBar('successfully submitted');
      setState(() {
        isSubmitting = false;
      });
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
            "New HashAuto Enquiry",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                        child: Text(
                          'About the vehicle',
                          style: MasterStyle.whiteTextStyleNormal,
                        ),
                      ),
                      SimplifiedWidgets.containerBox(
                        radius: 10,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 10),
                        color: MasterStyle.whiteColor.withOpacity(0.1),
                        child: NewColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Is this vehicle :',
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
}
