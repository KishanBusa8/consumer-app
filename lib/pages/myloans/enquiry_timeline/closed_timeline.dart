import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/enquiry_details_static_model.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:timelines/timelines.dart';

class ClosedTimeline extends StatelessWidget {
  ClosedTimeline({Key? key,required this.enquiryDetailsStaticModel}) : super(key: key);
  EnquiryDetailsStaticModel enquiryDetailsStaticModel;

  @override
  Widget build(BuildContext context) {
    List messagebody = [

      'Your enquiry has been closed.','This section will display any updates, activity, or changes made by your broker as your loan progresses.'


    ];
    List messageHeader =['Closed',''];
    List messagedate = [
      "Reason - ${this.enquiryDetailsStaticModel.loan.closingReason.toString()}", ''];

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
          itemCount: 2 + 1,
          contentsBuilder: (_, index) {

            if (2 + 1 == index + 1) return null;

            if (2 + 1 == index + 1) {
            } else {

            }
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
                      messageHeader[index],
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
            if (2 + 1 == index + 1) {
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
