
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/hash_convenyancing_model.dart';
import 'package:hashching/pages/mydeals/hash_auto.dart';
import 'package:hashching/pages/mydeals/hash_connect.dart';
import 'package:hashching/pages/mydeals/hash_convenyancing.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class MyDeals extends StatefulWidget {
 MyDeals({Key? key, required this.consumerAccountModel,required this.hashConveyacingRawList})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;
  HashConveyacingRawList hashConveyacingRawList;
  @override
  
  _MyDealsState createState() => _MyDealsState();
}

class _MyDealsState extends State<MyDeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("My Deals",
            textAlign: TextAlign.left, style: MasterStyle.appBarTitleStyle),
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:  Icon(Icons.arrow_back_ios, color: MasterStyle.appIconColor),)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            child: NewColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Services',
                  style: MasterStyle.whiteTextStyleMedium,
                ),
                InkWell(
                    onTap: () {
                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HashAuto(consumerAccountModel: widget.consumerAccountModel,)));
                    },
                    child: myCard(
                        assets: 'assets/images/hash_auto.svg',
                        header: 'HashAuto',
                        content: 'Buying and selling cars made easy.')),
                InkWell(
                    onTap: () {
                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HashConvenyancing(consumerAccountModel: widget.consumerAccountModel,hashConveyacingRawList:widget.hashConveyacingRawList)));
                    },
                  child: myCard(
                      assets: 'assets/images/hash_conveyancing.svg',
                      header: 'HashConveyancing',
                      content:
                          'Convenient, trustworthy, and affordable conveyancing services.'),
                ),
                InkWell(
                    onTap: () {
                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HashConnect(consumerAccountModel: widget.consumerAccountModel,)));
                    },
                  child: myCard(
                      assets: 'assets/images/hash_connect.svg',
                      header: 'HashConnect',
                      content:
                          'Moving made easy with free utility connection on the day you move in, in just one call.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card myCard(
      {required String assets,
      required String header,
      required String content}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: MasterStyle.secondaryThemeColor,
      elevation: 3.0,
      shadowColor: Color(0xFF00000029),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: HexColor('#F56736'), width: 1),
          borderRadius: BorderRadius.circular(10.0)),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: NewColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(top: 16.35.h, bottom: 16.11.h),
              child: new SvgPicture.asset(
                assets,
                width: 95.55.w,
                height: 73.53.h,
              ),
            ),
            Text(
              header,
              style: MasterStyle.whiteTextStyleMedium,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0.w, top: 8.0.h, bottom: 16.0.h, right: 25.0.w),
              child: Text(content,
                  style: MasterStyle.whiteStyleWithOpacity,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      )),
    );
  }
}
