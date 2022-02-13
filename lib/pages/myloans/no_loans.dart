import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class NoLoans extends StatelessWidget {
  const NoLoans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:19,bottom:19),
        child: Row(
      children: [
        Expanded(child: constrainedDottedBox(icon:'assets/myloans/credit_score.svg',borderColor: HexColor('#00D4FA'),title: 'Check your Credit Score',subtitle:'Whether you are borrowing or just checking up on your finance health,get a free copy of your credit report.Powered by Equifax'),),
        SizedBox(width: 16,),
        Expanded(child: constrainedDottedBox(icon:'assets/myloans/special_offer.svg',borderColor: HexColor('#DDFA00'),title: 'Exclusive Special Offers',subtitle: 'Take advantage of professional conveyancing from \$700+GST, provided by solicitors specialising in property law.\n')),
      ],
    ));
  }

  Container constrainedDottedBox({
    title,subtitle,icon,borderColor
  }) {
    return Container(
       height: 265,
      child: DottedBorder(
        borderType: BorderType.RRect,
        padding: EdgeInsets.all(16),
        strokeCap :StrokeCap.square,
        color:borderColor ,
         radius: Radius.circular(7.0),
         dashPattern: [6,6],
        child: ClipRRect(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12,bottom:14),
                child: Container(
                  height: 56,
                  width:56,
                  child:SvgPicture.asset(icon)
                  
                  //  Icon(Icons.call_missed_outgoing_rounded,color: MasterStyle.appBarIconColor,)
                   
                   ),
              ),
              Text(title,style: MasterStyle.secondarySmallBoldTextStyle,  textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.only(top:8),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,style: MasterStyle.whiteStyleRegularSmall,
        
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
