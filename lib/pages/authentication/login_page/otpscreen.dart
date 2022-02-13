// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/provider/state_management.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? email;
  final String? responseId;

  OtpScreen(this.phoneNumber, this.email, this.responseId);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  bool isResend = false;
  bool issubmit = false;
  String currentText = "";
  bool isValid = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  submitOtp({email, mobile, sms, responseId}) async {
    setState(() {
      issubmit = true;
    });
    print("email::: $email");
    var jsonData = jsonEncode(<String, String>{
      "responseId": responseId,
      "smscode": sms,
      "mobile": mobile,
      "email": email
    });
    print("button clicked");

    var jsonResponse = null;
    var url = Uri.parse(LocalConstants.loginOtpUrl);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (jsonResponse != null) {
        if(jsonResponse['error'] =="something went wrong"){
          snackBar("something went wrong");
        }
        setState(() {
          issubmit = false;
        });
        // print('*********** status :  ${jsonResponse["success"]['status']}');
        if (jsonResponse["success"] != null && jsonResponse["success"]['status'] == 101) {
          var token = jsonResponse["success"]["token"];
          print("token $token");
          print('Success');
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setBool(LocalConstants.loggedIn, true);
          await pref.setString(LocalConstants.userToken, token);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => StateManagementProvider()),
              (Route<dynamic> route) => false);
        } else {
          print('failure');
          snackBar("Please enter the valid otp");
        }
      }
    } else {
      print('"**************** body: ${response.body}');
    }
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MasterStyle.themeColor,
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  BoxDecoration inputDecoration = BoxDecoration(
      color: HexColor("#ECECEC"),
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
            color: HexColor("#00000029"), offset: Offset(0, 3), blurRadius: 6),
        BoxShadow(
            color: HexColor("#00000029"), offset: Offset(0, 3), blurRadius: 6)
      ]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(254, 140, 0, 1),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromRGBO(254, 140, 0, 1),
                Color.fromRGBO(248, 54, 0, 1),
              ],
            ),
          ),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 0,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          Icon(Icons.arrow_back_ios_new, color: Colors.white))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 52.w),
                child: Text(
                  'Verification Code',
                  style: MasterStyle.whiteStyleRegularWithSize,
                  maxLines: 1,
                  // minFontSize: 25.sp,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 52,
                  left: 40,
                  right: 40,
                ),
                child: Text(
                    "Enter the code sent to ${widget.phoneNumber}",
                      //  minFontSize: 12,
                       maxLines: 2,
                  textAlign: TextAlign.center,
                  
                    style: MasterStyle.whitelightWithRegular),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: PinPut(
                    enabled: !issubmit,
                    autofocus: true,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 6) {
                        return 'Please enter the valid otp';
                      }
                      return null;
                    },
                    controller: textEditingController,
                    // useNativeKeyboard: false,
                    autovalidateMode: AutovalidateMode.always,
                    withCursor: true,
                    fieldsCount: 6,
                    fieldsAlignment: MainAxisAlignment.spaceAround,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.black),
                    eachFieldMargin: EdgeInsets.all(0),
                    eachFieldWidth: 30.0,
                    eachFieldHeight: 31.0,
                    followingFieldDecoration: inputDecoration,
                    selectedFieldDecoration: inputDecoration,
                    submittedFieldDecoration: inputDecoration,
                    disabledDecoration: inputDecoration,
                    pinAnimationType: PinAnimationType.scale,
                  ),
                ),
              ),
              Visibility(
                visible: hasError,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Enter the valid otp",
                      style: MasterStyle.errorText),
                ),
              ),
              Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn’t receive your code?",
                      style: MasterStyle.whitelightWithRegular,
                    ),
                    isResend
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MasterStyle.backgroundColor),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                             if(!issubmit){
                              resendOtp(widget.email!);
                             }
                            },
                            child: Text(
                              " Resend",
                              style: MasterStyle.whiteStyleOpacityWithRegular
                                  .merge(TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ))
                  ],
                ),
              ),
              issubmit
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          MasterStyle.backgroundColor),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextButton(
                        onPressed: () {
                          if(!isResend){
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              hasError = false;
                            });
                            submitOtp(
                                email: widget.email,
                                mobile: widget.phoneNumber,
                                responseId: widget.responseId,
                                sms: textEditingController.text.toString());
                            print("OTP");
                          } else {
                            setState(() {
                              hasError = true;
                            });
                          }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          child: Text(
                            "Verify and Proceed",
                            style: GoogleFonts.lato(
                              color: MasterStyle.appIconColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: MasterStyle.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("#00000033"),
                                offset: Offset(-3, 3),
                                blurRadius: 6),
                            BoxShadow(
                                color: HexColor("#00000033"),
                                offset: Offset(-3, 3),
                                blurRadius: 9)
                          ]),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  resendOtp(String email) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isResend = true;
    });
    print("email::: $email");
    var jsonData = jsonEncode(<String, String>{
      'email': email,
    });

    print("button clicked");

    var jsonResponse = null;
    var url = Uri.parse(LocalConstants.loginPostUrl);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (jsonResponse != null) {
        print('*********** status :  ${jsonResponse['status']}');
        if (jsonResponse['status'] == 101) {
          var mobile = jsonResponse['mobile'];
          var responseId = jsonResponse['responseId'];
          responseId == null ? responseId = "" : responseId = responseId;
          email == null ? email = "" : email = email;
          print('Success');
          setState(() {
            textEditingController.clear();
            isResend = false;
          });
          snackBar("OTP resend!");
        } else if (jsonResponse['status'] == 103) {
          snackBar('${jsonResponse['message']}');

          setState(() {
            isResend = false;
          });
        } else {
          setState(() {
            isResend = false;
          });
          print('failure');
          snackBar("Unable to proceed with mobile verification.");
        }
      }
    } else {
      setState(() {
        isResend = false;
      });

      print('"**************** body: ${response.body}');
    }
  }
}
