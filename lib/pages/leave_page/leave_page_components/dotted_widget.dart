import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';

class DottedWidget extends StatelessWidget {
  const DottedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      constraints: BoxConstraints(maxHeight: 60.h),
      child: DottedBorder(
        padding: EdgeInsets.all(0.5),
        strokeWidth: 1,
        dashPattern: [6, 4],
        color: MasterStyle.greyCustomizedColor,
        radius: Radius.circular(5),
        child: Container(
          //  margin:EdgeInsets.all(0.5),
            decoration: BoxDecoration(
                color: MasterStyle.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(0))),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 16.56.w),
                    child: SvgPicture.asset(
                      "assets/icons/attachement.svg",
                      color: MasterStyle.greyCustomizedColor,
                      fit: BoxFit.contain,
                    )),
                Text('Add upto 5 files',
                    style: MasterStyle.commonTextStyle.merge(
                        TextStyle(color: MasterStyle.greyCustomizedColor))),
              ],
            ))),
      ),
    );
  }
}
