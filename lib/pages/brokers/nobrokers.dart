import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/styles/masterstyle.dart';

class NoBrokers extends StatelessWidget {
  const NoBrokers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 8, 0),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => MyDeals()));
        },
        child: ListTile(
            leading: Container(
              height: 54,
              width: 54,
              padding: EdgeInsets.fromLTRB(7, 7, 5, 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MasterStyle.whiteColor,
                border: Border.all(
                  color: MasterStyle.thedaryColor,
                ),
              ),
              child: SvgPicture.asset('assets/icons/hashching_logo.svg'),
            ),
            title: Text(
              'Talk to our hashching support team for any queries',
              style: MasterStyle.whiteStyleWithBold,
            )),
      ),
    );
  }
}
