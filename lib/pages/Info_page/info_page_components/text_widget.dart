

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/onboard.dart';
import 'package:hashching/styles/masterstyle.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.onBoard,
    required this.index,
    required this.pages,
  }) : super(key: key);

  final Onboard onBoard;
  final int index;
  final List<Container> pages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32,left: 16,right: 16),
      child: NewColumnMain(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            onBoard.onboardingTitles[index % pages.length],
            style: MasterStyle.splashWhiteTitleMedium,
          ),
          SizedBox(height: 16,),
          Text(
            onBoard.onboardingDetails[index % pages.length],
            style: MasterStyle.whiteStyleOpacityWithRegular.merge(TextStyle(color: Colors.white))//onBoard.descriptionstyle[index % pages.length],
          ),
        ],
      ),
    );
  }
}