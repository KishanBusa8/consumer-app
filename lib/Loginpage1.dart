// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/pages/myaccount/myproperty/myproperty.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class HomePageWeb extends StatefulWidget {
  HomePageWeb(
      {Key? key,
      required this.floatingPanelWidget,
      required this.isFloatingIconActive})
      : super(key: key);
  Widget floatingPanelWidget;
  bool isFloatingIconActive;
  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  bool isRewards = true;
  bool isProperty = false;
  bool isVault = false;
  Future<ConsumerAccountModel>? fetchConsumerData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: NewColumnMin(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: MasterStyle.dashbordHeader,
                        ),
                        Text(
                          "{consumerAccountModel.consumer.firstName} {consumerAccountModel.consumer.lastName} 👋",
                          style: MasterStyle.dashbordHeader,
                        ),
                        // consumerDashboardModel.allLoans.length != 0
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(top: 20),
                        //         child: ElevatedButton(
                        //           onPressed: () {},
                        //           child: Padding(
                        //               padding:
                        //                   EdgeInsets.symmetric(horizontal: 16),
                        //               child: Text('Complete task',
                        //                   style: MasterStyle
                        //                       .whiteStyleRegularNormal
                        //                       .merge(TextStyle(fontSize: 14)))),
                        //           style: ElevatedButton.styleFrom(
                        //               primary: MasterStyle.quaternaryColor,
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.all(
                        //                       Radius.circular(15.0)))),
                        //         ),
                        //       )
                        //     : SizedBox(),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 26.5),
                          decoration: BoxDecoration(
                              color: HexColor('#EFF6FF'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: NewColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 13, bottom: 8),
                                child: Text(
                                  'My Loans',
                                  style: MasterStyle.blackWithSemiBoldStyle,
                                ),
                              ),
                              Container(
                                height: 159,
                                child: ListView.separated(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  //.allLoans.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text("dai");
                                    // HomeMyLoansPanel(
                                    //   encryptkey:" consumerDashboardModel.allLoans[index].encryptkey",
                                    //   loanType: "consumerDashboardModel.allLoans[index].loantypeshow" ,
                                    //   status: "consumerDashboardModel.allLoans[index].statusname",
                                    //   loanAmount: "8698689",
                                    //   createDate: "99070",
                                    // );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      height: 2,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: HexColor('#CED4DB'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  mediumDivider(),
                  SizedBox(
                    height: 23.5,
                  ),
                  buildTitleText("My Brokers"),
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 33, top: 16, bottom: 0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      //consumerDashboardModel.allConsumerBrokers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildBrokersList(
                          index: index,
                          name: "name"
                          //     +
                          // ' ' +
                          // consumerDashboardModel
                          //     .allConsumerBrokers[index].lastName,
                          ,
                          profilePicture: LocalConstants.networkImageList[1],
                          onlineStatus: false,
                          unreadMessage: 2,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 26.5,
                  ),
                  mediumDivider(),
                  SizedBox(
                    height: 26.5,
                  ),
                  buildTitleText("My Account"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isVault = false;
                                  isProperty = false;
                                  isRewards = true;
                                });
                              },
                              child: buildSubtitleOfAccount(
                                  "My Rewards", isRewards),
                            ),
                            InkWell(
                              child: buildSubtitleOfAccount(
                                  "My Property", isProperty),
                              onTap: () {
                                setState(() {
                                  isVault = false;
                                  isProperty = true;
                                  isRewards = false;
                                });
                              },
                            ),
                            InkWell(
                              child:
                                  buildSubtitleOfAccount("My Vault", isVault),
                              onTap: () {
                                setState(() {
                                  isVault = true;
                                  isProperty = false;
                                  isRewards = false;
                                });
                              },
                            )
                          ],
                        ),
                        buildMyAccounts(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.5,
                  ),
                  mediumDivider(),
                  SizedBox(
                    height: 24.5,
                  ),
                  buildTitleText("My Deals"),
                  Container(
                    margin: EdgeInsets.only(left: 55.w, right: 55.w),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: () {},
                                child: buildMyDeals(
                                    'assets/icons/feedback.svg',
                                    "Earn 20 points",
                                    "Tell us about your experience"))),
                        SizedBox(
                          width: 48.w,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: buildMyDeals('assets/icons/paper_work.svg',
                                "Conveyancing under \$700", "Fast and simple"),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // Expanded(
                        //   child: buildMyDeals(
                        //       'assets/icons/group.svg',
                        //       "Earn upto \$150",
                        //       "Refer a friend"),
                        // )
                      ],
                    ),
                  ),
                  !widget.isFloatingIconActive
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox(
                          height: 120,
                        )
                ],
              ),
            ),
          ),
          widget.floatingPanelWidget
        ],
      )),
    );
  }

  buildMyDeals(imgUrl, title, subtitle) {
    return Stack(
      // fit:StackFit.scale,
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            // height: 180,
            color: Colors.transparent,
            child: Container(
              height: 129.h,
              // width: 103.w,
              // width: MediaQuery.of(context).size.width / 3.4,
              margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 20.h),
              decoration: defaultDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Center(
                      child: Container(
                          height: 30.92.h,
                          width: 30.92.w,
                          child: SvgPicture.asset(imgUrl))),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    title,
                    style: MasterStyle.blackWithSemiBoldStyle.merge(
                      TextStyle(fontSize: 14.sp),
                    ),
                 
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    subtitle,
                    // maxLines: 2,
                    style: MasterStyle.commonTextStyle.merge(TextStyle(
                        color: Colors.black.withOpacity(0.67),
                        fontSize: 11.sp)),
                  ),
                ],
              ),
            )),
        Positioned(
          bottom: 26,
          child: Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: const Offset(
                      2.0,
                      2.0,
                    ),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ), //
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.orangeAccent,
              size: 18,
            ),
          ),
        )
      ],
    );
  }

  buildMyAccounts(
    BuildContext context,
  ) {
    if (isRewards) {
      return InkWell(
        onTap: () {},
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 0),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: defaultDecoration(),
            child: Row(
              children: [
                Text("20",
                    style:
                        MasterStyle.secondarySemiBoldTextStyle.merge(TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.normal,
                    ))),
                SizedBox(
                  width: 10,
                ),
                Text('Points earned',
                    style: MasterStyle.blackTextStyleNormalSize)
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 0),
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   decoration: defaultDecoration(),
          //   child: NewColumn(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Refer a friend to hashching!',
          //         style: MasterStyle.commonTextStyle.merge(TextStyle(
          //           color: Colors.black.withOpacity(0.63),
          //           fontSize: 12,
          //         )),
          //       ),
          //       Container(
          //         padding: EdgeInsets.symmetric(vertical: 4),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text('Earn up to',
          //                 style: MasterStyle.blackTextStyleNormalSize),
          //             SizedBox(
          //               height: 6,
          //             ),
          //             Text('1500 Points',
          //                 style:
          //                     TextStyle(color: Colors.redAccent, fontSize: 18))
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ]),
      );
    } else if (isProperty) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyProperty()));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 0),
            padding:
                EdgeInsets.only(left: 16, right: 15.86, top: 19, bottom: 16),
            decoration: defaultDecoration(),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 30, right: 10),
                        child: SvgPicture.asset(
                            "assets/icons/my_property_icon.svg")),
                    Expanded(
                      child: NewColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get a free property report',
                            style: MasterStyle.blackTextStyleNormalSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '3 / 3 reports remaining this month',
                              // overflow:TextOverflow.ellipsis,
                              // softWrap:false,
                              style: MasterStyle.blackTextStyleNormalSize,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Download your report now ',
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                          WidgetSpan(
                              child: Icon(Icons.arrow_forward,
                                  color: MasterStyle.appSecondaryColor,
                                  size: 12.sp)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    } else if (isVault) {
      return InkWell(
        onTap: () {},
        child: Container(
            margin: EdgeInsets.only(bottom: 6),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: defaultDecoration(),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 30, right: 10),
                        child:
                            SvgPicture.asset("assets/icons/my_vault_icon.svg")),
                    Expanded(
                      child: NewColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Securely store and access your loan documents.',
                              style: MasterStyle.blackTextStyleNormalSize),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'You have no documents',
                              style: MasterStyle.blackTextStyleNormalSize,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 6, right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View',
                        style: MasterStyle.secondarySmallMediumTextStyle,
                      ),
                    ],
                  ),
                )
              ],
            )),
      );
    } else {
      return SizedBox();
    }
  }

  Decoration defaultDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }

  Widget buildTitleText(String text) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          text,
          style: MasterStyle.whiteStyleWithBold,
        ));
  }

  Widget buildSubtitleOfAccount(String text, bool selected) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 7, left: 8, right: 8),
      child: Text(
        text,
        textScaleFactor: 1.0,
        style: selected
            ? MasterStyle.secondaryNormalTextStyle
                .merge(TextStyle(fontSize: 15.sp))
            : MasterStyle.whiteStyleWithRegular
                .merge(TextStyle(fontSize: 15.sp)),
      ),
    );
  }

  Widget mediumDivider() {
    return Container(
      color: HexColor('#3D4D6B'),
      height: 6,
    );
  }

  Widget buildBrokersList(
      {int? index,
      required String name,
      required String profilePicture,
      bool? onlineStatus,
      int? unreadMessage}) {
    return InkWell(
      onTap: () {
        //  Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => BrokerProfile(
        //                               consumerBrokers: consumerBrokersInformations,
        //                             )));
      },
      child: Container(
        padding: EdgeInsets.only(right: 20),
        // height: 100,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: onlineStatus == true ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profilePicture),
                      maxRadius: 22,
                    ),
                  ),
                ),
                unreadMessage != 0
                    ? Positioned(
                        right: 10,
                        child: new Container(
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                              color: MasterStyle.quaternaryLigthColor,
                              shape: BoxShape.circle),
                          constraints: BoxConstraints(
                            minWidth: 11,
                            minHeight: 11,
                          ),
                          child: Center(
                            child: new Text(
                              unreadMessage.toString(),
                              style: MasterStyle.whiteTextStyleNormal
                                  .merge(TextStyle(
                                fontSize: 5,
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(name, style: MasterStyle.whiteStyleRegularNormal),
            ),
          ],
        ),
      ),
    );
  }
}
