import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/common_widgets/common_widgets.dart';
import 'package:hashching/pages/authentication/login_page/loginscreen.dart';
import 'package:hashching/pages/authentication/signup/signup.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';

class SignupPanelScreen extends StatefulWidget {
  final TextEditingController emailController;
  const SignupPanelScreen({Key? key, required this.emailController})
      : super(key: key);
  @override
  State<SignupPanelScreen> createState() => _SignupPanelScreenState();
}

class _SignupPanelScreenState extends State<SignupPanelScreen> {
  final _formKey = GlobalKey<FormState>();
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
                      height: 27,
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
                          controller: widget.emailController,
                          style: TextFonts.quaternaryText,
                          enabled: true,
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
                                    _navigateToSignUp(
                                      email: widget.emailController,
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
                          "Already have an account? ",
                          style: TextFonts.primaryText
                              .merge(TextStyle(fontSize: 19)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text("Login",
                              style: TextFonts.primaryText.merge(TextStyle(
                                  color: HexColor('#FFBE00'), fontSize: 19))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      child:
                          Text("or signup with", style: TextFonts.primaryText),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     InkWell(
                    //       onTap: () {
                    //         SimplifiedWidgets.launchInBrowser(
                    //             LocalConstants.facebookLoginUrl, context);
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
                    //         SimplifiedWidgets.launchInBrowser(
                    //             LocalConstants.googleLoginUrl, context);
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

  _navigateToSignUp({email}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignupPage(
              emailController: email,
            )));
  }
}
