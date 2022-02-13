
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/pages/authentication/login_page/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SignupOtpScreen extends StatefulWidget {
  late final String? phoneNumber;
  late final String? email;
  late final String? responseId;

  SignupOtpScreen(this.phoneNumber, this.email, this.responseId);

  @override
  _SignupOtpScreenState createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreen> {
  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  bool isResend = false;
  bool isLoading = false;
  bool isLogin =false;
  String responseIdLocal = '';
  String currentText = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    responseIdLocal = widget.responseId!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  submitSignInResend({email, phone}) async {
     FocusScope.of(context).unfocus();
    setState(() {
      isResend = true;
      isLogin = false;
    });
    var jsonData =
        jsonEncode(<String, String>{'email': email, "mobile": phone});

    print("button clicked");

    var jsonResponse = null;
    var url = Uri.parse(LocalConstants.SignupEmailUrl);

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
          var responseId = jsonResponse['responseId'];
        
          setState(() {
            responseIdLocal = responseId;
          });
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
          snackBar('${jsonResponse['message']}');
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

  submitOtp({email, mobile, sms, responseId}) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
      isLogin = false;
    });
    print("email::: $email");
    var jsonData = jsonEncode(<String, String>{
      "responseId": responseId,
      "smscode": sms,
      "mobile": '61'+mobile,
      "email": email
    });
    print("button clicked");

    var jsonResponse = null;
    var url = Uri.parse(LocalConstants.SignupOtpUrl);
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
          setState(() {
            isLoading = false;
            isLogin = true;
          });
          print('Success');
            snackBar("Congratulations your account has been created!");
          // SharedPreferences pref = await SharedPreferences.getInstance();
          // await pref.setBool(LocalConstants.loggedIn, true);
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         builder: (context) => StateManagementProvider()),
          //     (Route<dynamic> route) => false);
        } else {
          setState(() {
            isLoading = false;
          });
          print('failure');
          snackBar("Please enter your valid otp");
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
    print('object');
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(254, 140, 0, 1),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                  "Verification Code",
                  maxLines: 1,
                  style: MasterStyle.whiteStyleRegularWithSize,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 52,
                  left: 56,
                  right: 56,
                ),
                child: Text("Enter the code send to ${widget.phoneNumber}",
                    textAlign: TextAlign.center,
                    style: MasterStyle.whitelightWithRegular),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: PinPut(
                    enabled :!isLoading,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty||value.trim().length < 6) {
                        return 'Please enter the valid otp';
                      }
                      return null;
                    },
                    controller: textEditingController,
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
                      "Didn’t receive your code? ",
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
                            onTap: () => !isLoading?submitSignInResend(
                                  email: widget.email,
                                  phone: widget.phoneNumber,
                                ):null,
                            child: Text(
                              "Resend",
                              style: MasterStyle.whiteStyleOpacityWithRegular
                                  .merge(TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ))
                  ],
                ),
              ),
              isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          MasterStyle.backgroundColor),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextButton(
                        onPressed: ()  {
                          if(!isResend){
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              hasError = false;
                            });
                            submitOtp(
                                email: widget.email,
                                mobile: widget.phoneNumber,
                                responseId: responseIdLocal,
                                sms: textEditingController.text);
                      
                          } else {
                            setState(() {
                              hasError = true;
                            });
                          }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 0),
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
        // SizedBox(height: 20,),
         
           Visibility(
             visible: isLogin,
             child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: TextButton(
                          onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 0),
                            child: Text(
                              "Login",
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
           ),
          
           
            ],
          ),
        ),
      ),
    );
  }
}
