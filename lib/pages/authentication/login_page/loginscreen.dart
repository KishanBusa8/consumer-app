import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/common_widgets/common_widgets.dart';
import 'package:hashching/pages/authentication/login_page/otpscreen.dart';
import 'package:hashching/pages/authentication/signup/signuppanel.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BoxBorders.primaryButton,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(254, 140, 0, 1),
        //backgroundColor:Color.fromRGBO(248, 54, 0, 1),
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 27.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 29.7),
                      constraints: BoxConstraints(
                        maxWidth: 160,
                      ),
                      child: Image.asset(
                        'assets/securelogin1.png',
                      ),
                    ),
                    Image.asset(
                      'assets/noun_profile_665436.png',
                      height: 106,
                      width: 106,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 47.98, bottom: 16),
                      child: Text(
                        "Enter your email",
                        style: SmallHeader.primaryText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: Form(
                        key: _formKey,
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
                          controller: _controller,
                          style: TextFonts.quaternaryText,
                          enabled: !isLoading,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 16.w, top: 13.h, bottom: 12.h),
                              // errorBorder: InputBorder.none,
                              errorStyle: MasterStyle.errorText,
                              errorMaxLines: 2,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "example@email.com",
                              hintStyle: loginHint.primaryText,
                              focusedErrorBorder: _outlineInputBorder,
                              focusedBorder: _outlineInputBorder,
                              disabledBorder: _outlineInputBorder,
                              enabledBorder: _outlineInputBorder,
                              border: _outlineInputBorder),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 17),
                        child: !isLoading
                            ? RoutingWidget(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _submitLogIn(
                                      email: _controller.text,
                                    );
                                  } else {}
                                },
                              )
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MasterStyle.backgroundColor),
                              )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextFonts.primaryText
                              .merge(TextStyle(fontSize: 19)),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(!isLoading){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupPanelScreen(
                                      emailController: _controller)),
                            );
                            }
                          },
                          child: Text("Signup",
                              style: TextFonts.primaryText.merge(TextStyle(
                                  color: HexColor('#FFBE00'), fontSize: 19))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      child:
                          Text("or log in with", style: TextFonts.primaryText),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     InkWell(
                    //       onTap: () {
                    //         if(!isLoading){
                    //         SimplifiedWidgets.launchInBrowser(
                    //             LocalConstants.facebookLoginUrl, context);
                    //         }
                    //       },
                    //       child: Container(
                    //           constraints:
                    //               BoxConstraints(maxHeight: 50, maxWidth: 50),
                    //           child: Image.asset(
                    //             'assets/fblogo.png',
                    //           )),
                    //     ),
                    //     SizedBox(
                    //       width: 16,
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         if(!isLoading){
                    //         SimplifiedWidgets.launchInBrowser(
                    //             LocalConstants.googleLoginUrl, context);
                    //         }
                    //       },
                    //       child: Container(
                    //         constraints:
                    //             BoxConstraints(maxHeight: 50, maxWidth: 50),
                    //         child: Image.asset(
                    //           'assets/Gmaillogo.png',
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              // Container(child: BottomWidget())
            ],
          ),
        ),
      ),
    );
  }

  _submitLogIn({email}) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
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
          // responseId == null ? responseId = "" : responseId = responseId;
          // email == null ? email = "" : email = email;
          print('Success $email');
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  OtpScreen(mobile, email, responseId)));
        } else {
          setState(() {
            isLoading = false;
          });
          print('failure');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: MasterStyle.themeColor,
                content: Text(
                  'This email does not exists. Please enter a different email address or register yourself and explore. ☺',
                  style: MasterStyle.whiteStyleRegularSmall,
                )),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           SignupPage(emailController: _controller)),
          // );
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('"**************** body: ${response.body}');
    }
  }
}
