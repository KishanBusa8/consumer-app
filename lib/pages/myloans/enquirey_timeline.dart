import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:timelines/timelines.dart';

class EnquireyTimeline extends StatelessWidget {
  EnquireyTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List messagebody = [
      'Message Body',
      'Sample content for Message Body',
      'Sample content for Message Body with more content to have the visualisation for two lines content'
    ];
    List messagedate = ['02:30 PM, 22/09/2021', '02:30 PM, 22/09/2021', ''];

    return FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: Color(0xff989898),
          indicatorTheme: IndicatorThemeData(
            position: 0,
            size: 20.0,
          ),
          connectorTheme: ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.after,
          itemCount: 3 + 1,
          contentsBuilder: (_, index) {
           
            if (3 + 1 == index + 1) return null;

            if (3 + 1 == index + 1) {
            } else {}
            return Card(
              margin: EdgeInsets.only(left: 8.0, bottom:index==2? 0: 24),
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 14, right: 4, top: 7, bottom:index==2? 0: 13),
                child: NewColumnMin(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Message Header',
                      style: MasterStyle.blackBoldStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        messagebody[index],
                        style: MasterStyle.commonTextStyle.merge(TextStyle(
                          fontSize: 14,
                        )),
                      ),
                    ),
                    Text(
                      messagedate[index],
                      style: MasterStyle.blackTextWithOpacityStyle.merge(
                          TextStyle(color: HexColor('#8D8D8D'), fontSize: 14)),
                    ),
                  ],
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            if (3 + 1 == index + 1) {
              return DotIndicator(
                size: 0,
                child: Container(),
              );
            } else {
              return DotIndicator(
                size: 12,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor('#F56735'),
                  ),
                ),
              );
            }
          },
          connectorBuilder: (_, index, ___) => SolidLineConnector(
            color: MasterStyle.customGreyColor,
            thickness: 1,
          ),
        ));
  }
}
