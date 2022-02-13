import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/common_widgets/common_widgets.dart';
import 'package:hashching/pages/authentication/login_page/otpscreen.dart';
import 'package:hashching/pages/authentication/signup/otp_for_signup.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  final TextEditingController emailController;
  const SignupPage({Key? key, required this.emailController}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  submitSignIn({email, phone}) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
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
       
          print('Success');
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => OtpScreen(
                  _mobileNumberController.text, email, responseId)));
        } else if (jsonResponse['status'] == 103) {
       snackBar('${jsonResponse['message']}');
          setState(() {
            isLoading = false;
          });
          
        } else {
          setState(() {
            isLoading = false;
          });
          print('failure');
          snackBar("Unable to proceed with mobile verification.");
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('"**************** body: ${response.body}');
    }
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MasterStyle.themeColor,
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BoxBorders.primaryButton,  
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      backgroundColor: Color.fromRGBO(254, 140, 0, 1),
      resizeToAvoidBottomInset: false,
      body:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromRGBO(254, 140, 0, 1),
                Color.fromRGBO(248, 54, 0, 1)
              ],
            ),
          ),
          child: Stack(
            children: [Form(
                  key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, bottom: 41),
                        constraints: BoxConstraints(
                          maxWidth: 160,
                        ),
                        child: Image.asset(
                          'assets/securelogin1.png',
                        ),
                      ),
                      Image.asset(
                        'assets/noun_profile_665436.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 47, bottom: 16),
                        child: Text(
                          "Enter your phone number",
                          style: SmallHeader.primaryText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32),
                        child: TextFormField(
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email address';
                            } else if (!EmailValidator.validate(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          controller: widget.emailController,
                          style: TextFonts.quaternaryText,
                          enabled: !isLoading,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(
                                  left: 16.w, top: 13.h, bottom: 12.h),
                            errorStyle:MasterStyle.errorText,
                             errorMaxLines: 2,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "example@email.com",
                            hintStyle: loginHint.primaryText,
                            focusedBorder: _outlineInputBorder,
                            focusedErrorBorder: _outlineInputBorder,
                            disabledBorder: _outlineInputBorder,
                            enabledBorder: _outlineInputBorder,
                            border: _outlineInputBorder
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 32),
                        padding: const EdgeInsets.only(left: 32.0, right: 32),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.trim().length > 10 ||
                                value.trim().length < 9) {
                              return "Please enter a valid phone number";
                            }
                            return null;
                          },
                          enabled: !isLoading,
                          controller: _mobileNumberController,
                          style: TextFonts.quaternaryText,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintStyle: loginHint.primaryText,
                            errorStyle: MasterStyle.errorText,
                            errorMaxLines: 2,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '0412345678',
                              contentPadding: EdgeInsets.only(
                                  left: 16.w, top: 13.h, bottom: 12.h),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BoxBorders.primaryButton,
                              gapPadding: 50.0,
                            ),
                            disabledBorder: _outlineInputBorder,
                            enabledBorder: _outlineInputBorder,
                            focusedErrorBorder: _outlineInputBorder,
                            border: _outlineInputBorder
                          ),
                        ),
                      ),
                      !isLoading
                          ? RoutingWidget(
                              onTap: () => {
                                    if (_formKey.currentState!.validate())
                                      {
                                        submitSignIn(
                                            email: widget.emailController.text,
                                            phone: _mobileNumberController.text)
                                      }
                                    else
                                      {}
                                  })
                          : CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MasterStyle.backgroundColor),
                            )
                    ],
                  ),
                ),
            ),
              // Container(child: BottomWidget())
            ],
          ),
        ),
      ),
    );
  }
}
