import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashching/models/onboard.dart';
import 'package:hashching/pages/authentication/login_page/loginscreen.dart';
import 'package:hashching/styles/styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.controller,
    required this.onBoard,
    required this.index,
    required this.pages,
  }) : super(key: key);

  final PageController controller;
  final Onboard onBoard;
  final int index;
  final List<Container> pages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: GestureDetector(
        onTap: () {
          controller.animateToPage(controller.page!.toInt() + 1,
              duration: Duration(milliseconds: 400), curve: Curves.easeIn);
          if (controller.page!.toInt() == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen(),
              ),
            );
          }
        },
        child: Container(
          // padding: EdgeInsets.only(left: 10.w,right: 10.w),
          height: 39.h,
          width: 108.w,
          decoration: BoxDecoration(
              border: Border.all(
                  // color: onBoard.iconColor[index % pages.length]
                  color: IconColors.primary),
              borderRadius: ButtonBorders.primaryButton),
          child: Center(
              child: Text(
            onBoard.buttonText[index % pages.length],
            style: //onBoard.descriptionstyle[index % pages.length]
                GoogleFonts.lato(color: Colors.white, fontSize: 14.sp),
          )),
        ),
      ),
    );
  }
}
