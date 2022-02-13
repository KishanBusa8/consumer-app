import 'dart:convert';
import 'dart:io';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/consumer_setting_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/imagecroppicker.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/updated_profile_model.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hashching/provider/initialdata.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/consumer_account_model.dart';

class MyAccountSettings extends StatefulWidget {
  const MyAccountSettings(
      {Key? key,
      required this.consumerInformation,
      required this.consumerAccount})
      : super(key: key);
  final ConsumerDetailsModel consumerInformation;
  final ConsumerAccountModel consumerAccount;

  @override
  _MyAccountSettingsState createState() => _MyAccountSettingsState();
}

enum FieldState {
  firstName,
  lastName,
  phone,
  email,
  profile,
}

class _MyAccountSettingsState extends State<MyAccountSettings> {
  bool isSwitchTheme = false;
  bool isSwitchGuideAndTips = false;
  bool isSwitchEmailMarket = false;
  bool isSwitchSmsMarket = false;
  bool isSwitchNecessaryMessage = false;
  bool isEmailInputField = false;
  bool isFirstNameInputField = false;
  bool isLastNameInputField = false;
  bool isPhoneInputField = false;
  bool isVerifyOtp = false;
  bool isValidOtp = false;
  bool isResend = false;
  bool isImageChanged = false;
  bool isSendCode = false;
  bool isSettingsChanged = false;

  final _otpFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController otpController = TextEditingController(text: '');
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  final ImagePicker _picker = ImagePicker();

  String imageName = '';
  String imagePath = '';
  bool imageSelection = false;
  late ConsumerSettingModel consumerSettingModel;

  _handleImage(ImageSource source) async {
    setState(() {
      imageSelection = true;
    });
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      setState(() {
        InitialData.image = File(pickedFile.path);
        _cropImage(InitialData.image!.path);
      });
    }
    setState(() {
      imageSelection = false;
    });
  }
 late ConsumerDetailsModel consumerDetailsModel;
  getMarketingPreferences() async {
    // consumerDetailsModel = (await ApiServices.getConsumerSettings())!;

    isSwitchTheme = widget.consumerInformation.darkTheme!;
    isSwitchGuideAndTips = widget.consumerInformation.guidesTips!;
    isSwitchEmailMarket = widget.consumerInformation.emailMarketing!;
    isSwitchSmsMarket = widget.consumerInformation.smsMarketing!;
    isSwitchNecessaryMessage = widget.consumerInformation.necessaryMessages!;
    setState(() {

    });
  }



  updatedConsumerProfileSettings(bool isMainProfileupdated) async {
    //     File file = File(image!.path);
    // String fileName ="profile_pic";

    //      MultipartFile("file.openRead(1,"",3)", stream,44);
    print('********************GlobalData   firstName:' +
                firstNameController.text +
                ' lastName:' +
                lastNameController.text +
                "email:" +
                emailController.text.toString() +
                "  mobile:" +
                phoneController.text.toString() +
                "  profilePicLink:" +
                imageName !=
            ''
        ? imageName
        : widget.consumerInformation.consumerDetails.profilePicLink +
                    " profilePic:" +
                    imagePath !=
                ''
            ? imagePath
            : widget.consumerInformation.consumerDetails.profilePic.toString());
    UpdatedProfileModel? profileUpdated =
        await ApiServices.updatedConsumerProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text.toString(),
      mobile: phoneController.text.toString(),
      profilePicLink: imageName != ''
          ? imageName
          : widget.consumerInformation.consumerDetails.profilePicLink,
      profilePic: imagePath != ''
          ? imagePath
          : widget.consumerInformation.consumerDetails.profilePic,
    );

    if (profileUpdated!.status) {
      if (isMainProfileupdated) {
        Map data = {
          "firstName" : firstNameController.text,
          "lastName" : lastNameController.text,
          "email" : emailController.text,
          "mobile" : phoneController.text,
          "profilePicLink": imagePath != ''
              ? "https://s3-ap-southeast-2.amazonaws.com/hashching/uploads/cropper_images/${imagePath}"
              : widget.consumerInformation.consumerDetails.profilePicLink,
          'guide_and_tips' : isSwitchGuideAndTips,
          'smsMarketing' : isSwitchSmsMarket,
          'necessaryMessages' : isSwitchNecessaryMessage,
          'emailMarketing' : isSwitchEmailMarket,
        };
        // print();
        Navigator.pop(context, data);
        snackBar("You have successfully updated your profile!");
      }
      print('profile Updated Successfully');
    } else {
      print('profile Updated Failure');
    }
  }

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

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MasterStyle.appSecondaryColor,
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future _otpInputDialog(BuildContext context, isField) async {
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
                  'Enter the OTP sent to ${widget.consumerInformation.consumerDetails.mobile}',
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
                        setState(() {
                          switch (isField) {
                            case FieldState.email:
                              isEmailInputField = true;
                              break;
                            case FieldState.firstName:
                              isFirstNameInputField = true;
                              break;
                            case FieldState.lastName:
                              isLastNameInputField = true;
                              break;
                            case FieldState.phone:
                              isPhoneInputField = true;
                              break;
                            default:
                          }

                          isVerifyOtp = true;
                        });
                        Map data = {
                          "firstName" : firstNameController.text,
                          "lastName" : lastNameController.text,
                          "email" : emailController.text,
                          "mobile" : phoneController.text,
                          "profilePicLink": imagePath != ''
                              ? "https://s3-ap-southeast-2.amazonaws.com/hashching/uploads/cropper_images/${imagePath}"
                              : widget.consumerInformation.consumerDetails.profilePicLink,
                          'guide_and_tips' : isSwitchGuideAndTips,
                          'smsMarketing' : isSwitchSmsMarket,
                          'necessaryMessages' : isSwitchNecessaryMessage,
                          'emailMarketing' : isSwitchEmailMarket,
                        };
                        Navigator.pop(context,data);
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

  checkStateChanged() {
    if (isSwitchTheme == widget.consumerInformation.darkTheme &&
        isSwitchGuideAndTips == widget.consumerInformation.guidesTips &&
        isSwitchEmailMarket == widget.consumerInformation.emailMarketing &&
        isSwitchSmsMarket == widget.consumerInformation.smsMarketing &&
        isSwitchNecessaryMessage ==
            widget.consumerInformation.necessaryMessages &&
        emailController.text ==
            widget.consumerInformation.consumerDetails.email &&
        phoneController.text ==
            widget.consumerInformation.consumerDetails.mobile &&
        firstNameController.text ==
            widget.consumerInformation.consumerDetails.firstName &&
        lastNameController.text ==
            widget.consumerInformation.consumerDetails.lastName) {
      setState(() {
        isSettingsChanged = false;
      });
    } else {
      setState(() {
        isSettingsChanged = true;
      });
    }
  }

  SharedPreferences? preferences;

  @override
  void initState() {
    getPrefData();
    getMarketingPreferences();

    emailController.text = widget.consumerAccount.consumer.email;
    phoneController.text = widget.consumerAccount.consumer.mobile;
    firstNameController.text =
        widget.consumerAccount.consumer.firstName;
    lastNameController.text =
        widget.consumerAccount.consumer.lastName!;
    super.initState();
  }

  getPrefData() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          backgroundColor: MasterStyle.backgroundColor,
          title: Text(
            "Settings",
            style: MasterStyle.appBarTitleStyle,
          ),
          leading: IconButton(
              onPressed: () {
                Map data = {
                  "firstName" : firstNameController.text,
                  "lastName" : lastNameController.text,
                  "email" : emailController.text,
                  "mobile" : phoneController.text,
                  "profilePicLink": imagePath != ''
                      ? "https://s3-ap-southeast-2.amazonaws.com/hashching/uploads/cropper_images/${imagePath}"
                      : widget.consumerInformation.consumerDetails.profilePicLink,
                  'guide_and_tips' : isSwitchGuideAndTips,
                  'smsMarketing' : isSwitchSmsMarket,
                  'necessaryMessages' : isSwitchNecessaryMessage,
                  'emailMarketing' : isSwitchEmailMarket,
                };
                Navigator.pop(context,data);
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: MasterStyle.appBarIconColor)),
          actions: [
            Visibility(
              visible: isSettingsChanged,
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save Changes',
                      style: MasterStyle.appBarTitleStyle,
                    )),
              ),
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () {
            Map data = {
              "firstName" : firstNameController.text,
              "lastName" : lastNameController.text,
              "email" : emailController.text,
              "mobile" : phoneController.text,
              "profilePicLink": imagePath != ''
                  ? "https://s3-ap-southeast-2.amazonaws.com/hashching/uploads/cropper_images/${imagePath}"
                  : widget.consumerInformation.consumerDetails.profilePicLink,
              'guide_and_tips' : isSwitchGuideAndTips,
              'smsMarketing' : isSwitchSmsMarket,
              'necessaryMessages' : isSwitchNecessaryMessage,
              'emailMarketing' : isSwitchEmailMarket,
            };
            Navigator.pop(context,data);
            return Future.value(false);
          },
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              height: 130.h,
                              child: widget.consumerAccount.consumer.profilePic !=
                                      ''
                                  ? Container(
                                height: 114.h,
                                width: 114.w,
                                decoration: BoxDecoration(
                                    color: MasterStyle.whiteColor,
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(1),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      widget.consumerAccount.consumer.profilePic,
                                    ),),
                              )
                                  : !InitialData.isImageSelected
                                      ? Container(
                                          height: 114.h,
                                          width: 114.w,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle),
                                          padding: EdgeInsets.all(1),
                                          child: Center(
                                              child: Text(
                                            widget.consumerAccount
                                                .consumer.firstName
                                                .split("")
                                                .first,
                                            style: MasterStyle.dashbordHeader
                                                .merge(TextStyle(
                                                    color:
                                                        MasterStyle.thedaryColor,
                                                    fontSize: 60.sp)),
                                          )))
                                      : Container(
                                          height: 114.h,
                                          width: 114.w,
                                          decoration: BoxDecoration(
                                              color: MasterStyle.whiteColor,
                                              shape: BoxShape.circle),
                                          padding: EdgeInsets.all(1),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: FileImage(
                                                InitialData.image!,
                                              )),
                                        ),
                            ),
                            Positioned(
                              right: 16,
                              bottom: 6,
                              left: MediaQuery.of(context).orientation ==
                                      Orientation.landscape
                                  ? 95
                                  : null,
                              child: InkWell(
                                onTap: () {
                                  //   _bottomSheet(context);
                                  _handleImage(ImageSource.gallery);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.camera_alt_outlined,
                                        color: MasterStyle.appIconColor,
                                        size: 14)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 8),
                          child: Text(
                            widget.consumerAccount.consumer.uniqueId,
                            style: MasterStyle.whiteStyleOpacityWithRegular,
                          ),
                        ),
                        Text(
                          widget.consumerAccount.consumer.firstName +
                              ' ' +
                              widget.consumerAccount.consumer.lastName!,
                          style: MasterStyle.whiteTextStyleMedium,
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 32, 0, 16),
                  padding: EdgeInsets.fromLTRB(16, 13, 16, 20),
                  decoration: boxCurvedDecoration,
                  child: NewColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFormLabel('First Name'),
                      firstNameTextField(
                          firstNameController, isFirstNameInputField),
                      Divider(
                        height: 1.4,
                        thickness: 1,
                        color: MasterStyle.formBorderColor,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      textFormLabel('Last Name'),
                      lastNameTextField(lastNameController, isLastNameInputField),
                      Divider(
                        height: 1.4,
                        thickness: 1,
                        color: MasterStyle.formBorderColor,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      textFormLabel('Email'),
                      emailTextField(emailController, isEmailInputField),
                      Divider(
                        height: 1.4,
                        thickness: 1,
                        color: MasterStyle.formBorderColor,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      textFormLabel('Phone'),
                      phoneTextField(
                        phoneController,
                        isPhoneInputField,
                      ),
                      Divider(
                        height: 1.4,
                        thickness: 1,
                        color: MasterStyle.formBorderColor,
                      ),
                    ],
                  ),
                ),
                // Container(
                //   decoration: boxCurvedDecoration,
                //   padding: EdgeInsets.fromLTRB(16, 13, 16, 20),
                //   child: NewColumn(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Switch Theme'),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Expanded(
                //               child: Text('Switch your dashboard to light mode')),
                //           SizedBox(
                //             width: 16,
                //           ),
                //           Transform.scale(
                //             transformHitTests: false,
                //             scale: .54,
                //             child: CupertinoSwitch(
                //               value: isSwitchTheme,
                //               onChanged: (isChange) {
                //                 setState(() {
                //                   isSwitchTheme = !isSwitchTheme;
                //                 });
                //               },
                //               activeColor: Colors.green,
                //               trackColor: MasterStyle.switchTileTrackColor,
                //             ),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: toggleSwitchColumn(),
                )
              ],
            ),
          ),
        ));
  }

  Divider dash() {
    return Divider(color: HexColor("#3D4D6B"), thickness: 2);
  }

  Column toggleSwitchColumn() {
    return NewColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchBoardTitle('Loan related guides and tips'),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      "I want to receive loan-related guides and tips via e-mail",
                      style: MasterStyle.whiteStyleWithRegular)),
              Container(
                  margin: EdgeInsets.only(left: 30, top: 0),
                  padding: EdgeInsets.all(0),
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .54,
                    child: CupertinoSwitch(
                      value: isSwitchGuideAndTips,
                      onChanged: (isChangeValue) async  {
                        setState(() {
                          isSwitchGuideAndTips = !isSwitchGuideAndTips;
                          if (isSwitchGuideAndTips) {
                            isSwitchNecessaryMessage = false;
                          }
                        });
                       await ApiServices.setGuideTips(isSwitchGuideAndTips);

                      },
                      activeColor: Colors.green,
                      trackColor: MasterStyle.switchTileTrackColor,
                    ),
                  ))
            ],
          ),
        ),
        dash(),
        SwitchBoardTitle('E-mail marketing'),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      "I want to receive surveys and special offers via e-mail",
                      style: MasterStyle.whiteStyleWithRegular)),
              Container(
                  margin: EdgeInsets.only(left: 30, top: 0),
                  padding: EdgeInsets.all(0),
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .54,
                    child: CupertinoSwitch(
                      value: isSwitchEmailMarket,
                      onChanged: (isChangeValue) async  {
                        print('isSwitchChange  $isSwitchEmailMarket');
                        setState(() {

                          isSwitchEmailMarket = !isSwitchEmailMarket;
                          if (isSwitchEmailMarket) {
                            isSwitchNecessaryMessage = false;
                          }
                        });

                        await ApiServices.setEmailMarketing(isSwitchEmailMarket);

                        print('isSwitch  $isSwitchEmailMarket');
                      },
                      activeColor: Colors.green,
                      trackColor: MasterStyle.switchTileTrackColor,
                    ),
                  ))
            ],
          ),
        ),
        dash(),
        SwitchBoardTitle('SMS marketing'),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      "I want to receive special offers, surveys and guides via SMS",
                      style: MasterStyle.whiteStyleWithRegular)),
              Container(
                  margin: EdgeInsets.only(left: 30, top: 0),
                  padding: EdgeInsets.all(0),
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .54,
                    child: CupertinoSwitch(
                      value: isSwitchSmsMarket,
                      onChanged: (isChangeValue) async {
                        print('isSwitchSmsMarket  $isSwitchSmsMarket');
                        setState(() {

                          isSwitchSmsMarket = !isSwitchSmsMarket;
                          if (isSwitchSmsMarket) {
                            isSwitchNecessaryMessage = false;

                          }
                        });
                     await ApiServices.setSmsMarketing(isSwitchSmsMarket);

                        print('isSwitchSmsMarketElse  $isSwitchSmsMarket');
                      },
                      activeColor: Colors.green,
                      trackColor: MasterStyle.switchTileTrackColor,
                    ),
                  ))
            ],
          ),
        ),
        dash(),
        SwitchBoardTitle('Necessary message'),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      "I only want to receive necessary communication from hashching and my broker",
                      style: MasterStyle.whiteStyleWithRegular)),
              Container(
                  margin: EdgeInsets.only(left: 30, top: 0),
                  padding: EdgeInsets.all(0),
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .54,
                    child: CupertinoSwitch(
                      value: isSwitchNecessaryMessage,
                      onChanged: (isChangeValue) async {
                        setState(() {
                          isSwitchNecessaryMessage = !isSwitchNecessaryMessage;
                          if (isSwitchNecessaryMessage) {
                            isSwitchGuideAndTips = false;
                            isSwitchEmailMarket = false;
                            isSwitchSmsMarket = false;
                          }
                        });

                        await ApiServices.setNecessaryMessages(isSwitchNecessaryMessage);


                        print('isSwitch  $isSwitchNecessaryMessage');
                      },
                      activeColor: Colors.green,
                      trackColor: MasterStyle.switchTileTrackColor,
                    ),
                  ))
            ],
          ),
        ),
        dash(),
        SizedBox(
          height: 32,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'App version: 2.1.3 \n',
              style: MasterStyle.whiteStyleRegularSmall),
          TextSpan(
              text: 'All Rights Reserved.',
              style: MasterStyle.whiteStyleRegularSmall),
          termsOfUse(),
          TextSpan(text: '|', style: MasterStyle.whiteStyleRegularSmall),
          privacyPolicy()
        ])),
      ],
    );
  }

  WidgetSpan termsOfUse() {
    return WidgetSpan(
        child: InkWell(
            onTap: () {
              SimplifiedWidgets.launchInBrowser(
                  'https://www.hashching.co.uk/terms-conditions', context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text('Terms of Use',
                  style: MasterStyle.whiteStyleRegularbold),
            )));
  }

  WidgetSpan privacyPolicy() {
    return WidgetSpan(
        child: InkWell(
            onTap: () {
              SimplifiedWidgets.launchInBrowser(
                  'https://www.hashching.co.uk/privacy', context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text('Privacy policy',
                  style: MasterStyle.whiteStyleRegularbold),
            )));
  }

  Container SwitchBoardTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: MasterStyle.whiteStyleRegularSmallLigth,
      ),
    );
  }

  Text textFormLabel(String label) {
    return Text(
      label,
      style: MasterStyle.labelStyle,
    );
  }

  Decoration boxCurvedDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: MasterStyle.appearenceCardColor);

  Widget emailTextField(TextEditingController controller, bool isEnabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
            controller: controller,
            enabled: isEnabled,
            cursorColor: MasterStyle.themeColor,
            keyboardType: TextInputType.emailAddress,
            style: MasterStyle.formTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            alignment: Alignment.bottomRight,
          ),
          onPressed: () {
            setState(() {
              isEmailInputField = !isEmailInputField;
            });
            if (!isEmailInputField) {
              updatedConsumerProfileSettings(true);
            }
          },
          child: isEmailInputField
              ? Text(
                  'save',
                  style: MasterStyle.primaryContent,
                )
              : SvgPicture.asset('assets/icons/edit_icon.svg',
                  fit: BoxFit.scaleDown),
        )
      ],
    );
  }

  Widget lastNameTextField(TextEditingController controller, bool isEnabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
            controller: controller,
            enabled: isEnabled,
            cursorColor: MasterStyle.themeColor,
            keyboardType: TextInputType.text,
            style: MasterStyle.formTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            alignment: Alignment.bottomRight,
          ),
          onPressed: () {
            setState(() {
              isLastNameInputField = !isLastNameInputField;
            });
            if (!isLastNameInputField) {
              updatedConsumerProfileSettings(true);
            }
          },
          child: isLastNameInputField
              ? Text(
                  'save',
                  style: MasterStyle.primaryContent,
                )
              : SvgPicture.asset('assets/icons/edit_icon.svg',
                  fit: BoxFit.scaleDown),
        )
      ],
    );
  }

  Widget firstNameTextField(TextEditingController controller, bool isEnabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            controller: controller,
            enabled: isEnabled,
            cursorColor: MasterStyle.themeColor,
            keyboardType: TextInputType.text,
            style: MasterStyle.formTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            alignment: Alignment.bottomRight,
          ),
          onPressed: () {
            setState(() {
              isFirstNameInputField = !isFirstNameInputField;
            });
            if (!isFirstNameInputField) {
              updatedConsumerProfileSettings(true);
            }
          },
          child: isFirstNameInputField
              ? Text(
                  'save',
                  style: MasterStyle.primaryContent,
                )
              : SvgPicture.asset('assets/icons/edit_icon.svg',
                  fit: BoxFit.scaleDown),
        )
      ],
    );
  }

  Future<Null> _cropImage(imageFile) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "",
            toolbarColor: MasterStyle.appSecondaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: '',
        ));
    if (croppedFile != null) {
      setState(() {
        InitialData.image = croppedFile;
        InitialData.isImageSelected = true;
        // state = AppState.cropped;
      });
      uploadProfilePic(croppedFile);
    }
  }

  Future uploadProfilePic(File croppedFile) async {
    var uri = Uri.parse(LocalConstants.UrlUploadProfilePic);

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', uri);
    print(croppedFile.path);
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('file', croppedFile.path);
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      var data = json.decode(response.body);

      if (response.body != null) {
        setState(() {
          imageName = data['result'];
          imagePath = data['result_original'];
        });
        updatedConsumerProfileSettings(true);
      }

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getCroppedImage(BuildContext context, getImage) async {
    // File result = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ImageCropPicker(
    //               title: "getImage",
    //             )));

    // if (result != null) {
    //   setState(() {
    //     isImageChanged = true;
    //   });
    // } else {
    //   isImageChanged = false;
    // }
    // setState(() {
    //   // _imageChange = 'changed';
    //   image = result;
    // });
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return new Container(
          margin: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 5.0,
            bottom: 5.0,
          ),
          padding: EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 5.0,
            bottom: 5.0,
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: new Wrap(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _handleImage(ImageSource.gallery);
                  Map data = {
                    "firstName" : firstNameController.text,
                    "lastName" : lastNameController.text,
                    "email" : emailController.text,
                    "mobile" : phoneController.text,
                    "profilePicLink": imagePath != ''
                        ? "https://s3-ap-southeast-2.amazonaws.com/hashching/uploads/cropper_images/${imagePath}"
                        : widget.consumerInformation.consumerDetails.profilePicLink,
                    'guide_and_tips' : isSwitchGuideAndTips,
                    'smsMarketing' : isSwitchSmsMarket,
                    'necessaryMessages' : isSwitchNecessaryMessage,
                    'emailMarketing' : isSwitchEmailMarket,
                  };
                  Navigator.pop(context,data);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Profile Picture',
                        style: MasterStyle.commonTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              new Divider(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    InitialData.image = null;
                    isImageChanged = true;
                  });
                  Map data = {
                    "firstName" : firstNameController.text,
                    "lastName" : lastNameController.text,
                    "email" : emailController.text,
                    "mobile" : phoneController.text,
                    "profilePicLink": imagePath != ''
                        ? "https://s3-ap-southeast-2.amazonaws.com/hashching/uploads/cropper_images/${imagePath}"
                        : widget.consumerInformation.consumerDetails.profilePicLink,
                    'guide_and_tips' : isSwitchGuideAndTips,
                    'smsMarketing' : isSwitchSmsMarket,
                    'necessaryMessages' : isSwitchNecessaryMessage,
                    'emailMarketing' : isSwitchEmailMarket,
                  };
                  Navigator.pop(context,data);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remove Photo',
                        style: MasterStyle.commonTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget phoneTextField(TextEditingController controller, bool isEnabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phoner number';
              }
              return null;
            },
            onChanged: (value) {
              if (controller.text !=
                  widget.consumerInformation.consumerDetails.mobile) {
                setState(() {
                  isSendCode = true;
                });
              } else {
                setState(() {
                  isSendCode = false;
                });
              }
            },
            controller: controller,
            enabled: isEnabled,
            cursorColor: MasterStyle.themeColor,
            keyboardType: TextInputType.emailAddress,
            style: MasterStyle.formTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIconConstraints: BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            alignment: Alignment.bottomRight,
          ),
          onPressed: () {
            if (isSendCode) {
              _otpInputDialog(context, FieldState.phone);
            } else {
              setState(() {
                isPhoneInputField = !isPhoneInputField;
              });
              if (!isPhoneInputField) {
                updatedConsumerProfileSettings(true);
              }
            }
          },
          child: isPhoneInputField
              ? Text(
                  isSendCode ? "Send code" : 'save',
                  style: MasterStyle.primaryContent,
                )
              : SvgPicture.asset('assets/icons/edit_icon.svg',
                  fit: BoxFit.scaleDown),
        )
      ],
    );
  }
}
