
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  bool isAnimation = false;
  double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar:
          SimplifiedWidgets.MyAppbar(appBarTitle: 'Progress', context: context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: NewColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MySizedBox.height(33.4),
            GestureDetector(
              onTap: () {
                setState(() {
                  isAnimation = true;
                  percentage = 0.60;
                });
              },
              child: CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  radius: 160.0,
                  lineWidth: 5.0,
                  percent: percentage,
                  backgroundWidth: 30,
                  backgroundColor: HexColor('1E354F'),
                  center: new Text(
                    "Tap".toUpperCase(),
                    style: MasterStyle.commonTextStyle.merge(TextStyle(
                        color: HexColor('#EFF6FF').withOpacity(0.27),
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                  ),
                  progressColor: MasterStyle.appSecondaryColor),
            ),
            MySizedBox.height(17.4),
            Padding(
              padding: const EdgeInsets.only(top: 17.4, bottom: 24),
              child: Text(
                isAnimation ? '60% done' : 'Continue?',
                style: MasterStyle.commonTextStyle
                    .merge(TextStyle(color: HexColor('#EFF6FF'), fontSize: 23)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 39, 55),
              child: Text(
                'Complete your existing enquiry or start a new application',
                style: MasterStyle.commonTextStyle
                    .merge(TextStyle(color: HexColor('#EFF6FF'), fontSize: 17)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimplifiedWidgets.elevatedButton(
                      text: 'Start over',
                      textStyle: MasterStyle.commonTextStyle.merge(
                          TextStyle(color: HexColor('#EFF6FF'), fontSize: 17)),
                      color: MasterStyle.appSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      onPresed: () {},
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 22)),
                  SimplifiedWidgets.elevatedButton(
                      text: 'Finish now',
                      textStyle: MasterStyle.commonTextStyle.merge(
                          TextStyle(color: HexColor('#EFF6FF'), fontSize: 17)),
                      color: MasterStyle.appSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      onPresed: () {},
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 22))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
