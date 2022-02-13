// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:hashching/styles/masterstyle.dart';

class PointsRedeemed extends StatelessWidget {
  PointsRedeemed({Key? key, this.rewardsModelInformation}) : super(key: key);

  RewardsModel? rewardsModelInformation;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Keep earning points to redeem your rewards for gift cards!',
      style: MasterStyle.blackWithSemiBoldTextStyle,
      textAlign: TextAlign.center,
    ));

    // FixedTimeline.tileBuilder(
    //   theme: TimelineThemeData(
    //     nodePosition: 0,
    //     color: Color(0xff989898),
    //     indicatorTheme: IndicatorThemeData(
    //       position: 0,
    //       size: 20.0,
    //     ),
    //     connectorTheme: ConnectorThemeData(
    //       thickness: 2.5,
    //     ),
    //   ),
    //   builder: TimelineTileBuilder.connected(
    //     connectionDirection: ConnectionDirection.after,
    //     itemCount:
    //         this.rewardsModelInformation!.rewards.rewardCredit.length + 1,
    //     contentsBuilder: (_, index) {
    //
    //       DateTime convertStringToDate;
    //       String formatDate = '';
    //       if (this.rewardsModelInformation!.rewards.rewardCredit.length +
    //               1 ==
    //           index + 1) return null;
    //
    //       if (this.rewardsModelInformation!.rewards.rewardCredit.length + 1 == index + 1) {
    //       } else {
    //         convertStringToDate = new DateFormat("yyyy-MM-dd").parse(this
    //             .rewardsModelInformation!
    //             .rewards
    //             .rewardCredit[index]
    //             .createdAt
    //             .toString());
    //         formatDate =
    //             new DateFormat("d MMM yyyy").format(convertStringToDate);
    //       }
    //       return Padding(
    //         padding: EdgeInsets.only(left: 8.0),
    //         child: NewColumnMin(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(
    //               formatDate.toString(),
    //               style: MasterStyle.blackTextWithOpacityStyle,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    //               child: Text(
    //                 '${this
    //             .rewardsModelInformation!
    //             .rewards
    //             .rewardCredit[index].points.toString()} Points redeemed',
    //                 style: MasterStyle.blackWithSemiBoldStyle,
    //               ),
    //             ),
    //
    //             SizedBox(
    //               height: 20,
    //             )
    //           ],
    //         ),
    //       );
    //     },
    //     indicatorBuilder: (_, index) {
    //       if (this.rewardsModelInformation!.rewards.rewardCredit.length +
    //               1 ==
    //           index + 1) {
    //         return DotIndicator(
    //           size: 7,
    //           // color: Color(0xff66c97f),
    //           child: Container(
    //             height: 7,
    //             width: 7,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: MasterStyle.indicatorColor,
    //             ),
    //           ),
    //         );
    //       } else {
    //         return DotIndicator(
    //           child: Container(
    //             height: 18.7,
    //             width: 18.7,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: Colors.white,
    //             ),
    //             child: SvgPicture.asset('assets/icons/star_icon.svg'),
    //           ),
    //         );
    //       }
    //     },
    //     connectorBuilder: (_, index, ___) => SolidLineConnector(
    //       color: MasterStyle.customGreyColor,
    //       thickness: 1,
    //     ),
    //   ));
  }
}
