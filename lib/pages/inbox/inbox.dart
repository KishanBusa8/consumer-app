// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/pages/calculator/calculator.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class Inbox extends StatelessWidget {
   Inbox({ Key? key,required this.floatingPanelWidget }) : super(key: key);
Widget floatingPanelWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color(0xff1F3751),
    body: Stack(
      children: 
        [Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Container(
                height: 49.31,
                width: 75.38,
                child: SvgPicture.asset("assets/icons/message_ic.svg")),
                SizedBox(height: 16,),
                Text("No Messages",style: MasterStyle.whiteStyleRegularNormal,),
               
            ],
          ),
        ),
         floatingPanelWidget
         ],
  
    ),
    );
  }
}