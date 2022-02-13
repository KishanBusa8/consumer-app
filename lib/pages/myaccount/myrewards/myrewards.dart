// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:hashching/pages/myaccount/myrewards/points_earned.dart';
import 'package:hashching/pages/myaccount/myrewards/points_redeemed.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';


class MyRewards extends StatefulWidget {
  MyRewards({Key? key, this.rewardsModelInformation, this.consumerInformation})
      : super(key: key);
  RewardsModel? rewardsModelInformation;
  ConsumerDetailsModel? consumerInformation;

  @override
  _MyRewardsState createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  bool isPointsEarned = false;
  bool isPointsRedeemed = false;
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  int current_step = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: MasterStyle.backgroundColor,
          title: Text(
            "Welcome, ${widget.consumerInformation!.consumerDetails.firstName}!",
            style: MasterStyle.appBarTitleWithWhiteStyle,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: MasterStyle.whiteColor)),
        ),
        body: //isPointsEarned? pointsEarnerTest():
            ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NewColumnMain(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.rewardsModelInformation!.rewards.rewardPoints
                              .toString(),
                          style: MasterStyle.whiteStyleRegularBoldWithSize,
                        ),
                        Text('Your reward points',
                            style: MasterStyle.whiteTextStyleNormal)
                      ]),
                  Container(
                      child:
                          SvgPicture.asset('assets/images/myaward_image.svg'))
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   child:
            //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //     ElevatedButton(
            //         onPressed: () {},
            //         style: ButtonStyle(
            //             backgroundColor: MaterialStateProperty.resolveWith(
            //                 (states) => MasterStyle.whiteColor),
            //             shape:
            //                 MaterialStateProperty.all<RoundedRectangleBorder>(
            //                     RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(7),
            //             ))),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 65, vertical: 7),
            //           child: Text(
            //             'Redeem',
            //             style: MasterStyle.primaryContent,
            //           ),
            //         ))
            //   ]),
            // ),
          SizedBox(height: 50,),
            Stack(
              children: [
                isPointsEarned || isPointsRedeemed
                    ?  Container(
                  //
                  // decoration: BoxDecoration(
                  //     color: MasterStyle.whiteColor.withOpacity(.20)),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                         color:   isPointsEarned
                                ? Colors.transparent
                                : MasterStyle.whiteColor.withOpacity(.20),
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (isPointsEarned) {
                                    setState(() {
                                      isPointsEarned = false;

                                    });
                                  } else {
                                    setState(() {
                                      isPointsEarned = true;
                                      isPointsRedeemed = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 97.h,
                                  padding: EdgeInsets.fromLTRB(40.w, 10.h,22.w, 22.h),
                                  child: RichText(

                                      text: TextSpan(
                                          style:
                                          MasterStyle.whiteTextStyleNormal,
                                          children: [
                                            TextSpan(text: 'Points earned'),
                                            WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(top: 10),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,size:20.sp,
                                                    color: MasterStyle.whiteColor,
                                                  ),
                                                )),
                                          ])),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                        //  color:MasterStyle.secondaryDividerColor,
                          margin: EdgeInsets.only(top:6.h,bottom: 7.h),
                        ),
                        // VerticalDivider(
                        //
                        //   thickness: 1,
                        //   indent: 6,
                        //   endIndent: 7,
                        //   color: MasterStyle.secondaryDividerColor,
                        // ),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (isPointsRedeemed) {
                                setState(() {
                                  isPointsRedeemed = false;
                                });
                              } else {
                                setState(() {
                                  isPointsEarned = false;
                                  isPointsRedeemed = true;
                                });
                              }
                            },
                            child: Container(
                              height: 97.h,
                              // padding: EdgeInsets.fromLTRB(0, 16.h, 24, 30),
                              padding: EdgeInsets.fromLTRB(22.w, 10.h, 24.w, 22.h),
                                color: isPointsRedeemed
                                    ? Colors.transparent
                                    : MasterStyle.whiteColor.withOpacity(.20),

                              child: RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      style:
                                      MasterStyle.whiteTextStyleNormal,
                                      children: [
                                        TextSpan(text: 'Points redeemed'),
                                        WidgetSpan(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(top: 10),
                                              child: Icon(

                                                Icons.arrow_forward_ios,size:20.sp,
                                                color: MasterStyle.whiteColor,
                                              ),
                                            ))
                                      ])),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    :
                Container(

                        decoration: BoxDecoration(
                            color: MasterStyle.whiteColor.withOpacity(.20)),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPointsEarned = true;
                                      });
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.fromLTRB(40, 16.h, 0, 30),
                                      padding: EdgeInsets.fromLTRB(40.w, 10.h,22.w, 22.h),
                                      child: RichText(

                                          text: TextSpan(
                                              style:
                                                  MasterStyle.whiteTextStyleNormal,
                                              children: [
                                            TextSpan(text: 'Points earned'),
                                            WidgetSpan(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10),
                                              child: Icon(
                                                Icons.arrow_forward_ios,size:20.sp,
                                                color: MasterStyle.whiteColor,
                                              ),
                                            )),
                                          ])),
                                    ),
                                  ),
                                ),
                              ),
                               Container(
                                 width: 1,
                                 color:MasterStyle.secondaryDividerColor,
                                 margin: EdgeInsets.only(top:6.h,bottom: 7.h),
                               ),
                              // VerticalDivider(
                              //
                              //   thickness: 1,
                              //   indent: 6,
                              //   endIndent: 7,
                              //   color: MasterStyle.secondaryDividerColor,
                              // ),
                              
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPointsRedeemed = true;
                                    });
                                  },
                                  child: Container(
                                    // padding: EdgeInsets.fromLTRB(0, 16.h, 24, 30),
                                    padding: EdgeInsets.fromLTRB(22.w, 10.h, 24.w, 22.h),
                                    //   color: MasterStyle.whiteColor.withOpacity(.20),

                                    child: RichText(
                                      maxLines: 1,
                                        text: TextSpan(
                                            style:
                                                MasterStyle.whiteTextStyleNormal,
                                            children: [
                                          TextSpan(text: 'Points redeemed'),
                                          WidgetSpan(
                                              child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Icon(

                                              Icons.arrow_forward_ios,size:20.sp,
                                              color: MasterStyle.whiteColor,
                                            ),
                                          ))
                                        ])),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              //  isPointsEarned || isPointsRedeemed ?
                Visibility(child: buildAwardPoints(),visible:  isPointsEarned || isPointsRedeemed,)

                ///hide old design
                //     : Container(
                //         margin: EdgeInsets.fromLTRB(16.w, 68.h, 16.w, 16.h),
                //
                //         child:  Stack(
                //     clipBehavior: Clip.none,
                //     fit: StackFit.loose,
                //     alignment: AlignmentDirectional.bottomCenter,
                //     children: [
                //       Container(
                //         decoration: BoxDecoration(
                //           color: MasterStyle.whiteColor,
                //           borderRadius: BorderRadius.all(Radius.circular(6)),
                //         ),
                //         width: MediaQuery.of(context).size.width,
                //         // margin: EdgeInsets.symmetric(horizontal: 16),
                //         child: SvgPicture.asset(
                //           'assets/images/rewards_background.svg',
                //           fit: BoxFit.contain,
                //         ),
                //       ),
                //       Positioned(
                //         bottom: 10,
                //         child: NewColumn(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Text(
                //                     'Earn up to',
                //                     style: MasterStyle.blackTextWithNormalStyle,
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                         horizontal: 8.0),
                //                     child: Text('20',
                //                         style:
                //                             MasterStyle.primaryContentWithBold),
                //                   ),
                //                   Text('Points',
                //                       style: MasterStyle.primaryContent),
                //                 ]),
                //             SizedBox(height: 4),
                //             Text(
                //               'Take 2 min survey to let us know about your \nexperience so far',
                //               style: MasterStyle.blackWithOpacityStyle,
                //               textAlign: TextAlign.center,
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   )
                //
                //         )


              ],
            ),
          ],
        ));
  }

  Container buildAwardPoints() {
    return Container(
        margin: EdgeInsets.fromLTRB(16.w, 62.h, 16.w, 16.h),
        padding: EdgeInsets.only(right: 40, left: 16, bottom: 120, top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: MasterStyle.whiteColor),
        child: isPointsEarned
            ? PonitsEarned(
                rewardsModelInformation: widget.rewardsModelInformation)
            : PointsRedeemed(
                rewardsModelInformation: widget.rewardsModelInformation));
  }

  Stack pointsRedeemed = Stack(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10, top: 0),
        width: 1,
        height: 76,
        color: HexColor('#707070'),
      ),
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset('assets/icons/star_icon.svg'),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                // padding: EdgeInsets.only(top: 50),
                child: NewColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '30 Aug 2021',
                      style: MasterStyle.blackTextWithOpacityStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        '20 Points redeemed',
                        style: MasterStyle.blackWithSemiBoldStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 6.5, top: 17),
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor('#FFC727'),
                ),
              ),
            ],
          )
        ],
      )
    ],
  );
}

// testing

const kTileHeight = 50.0;
