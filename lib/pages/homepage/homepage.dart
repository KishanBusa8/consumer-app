// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/listprovider/loadnlist_provider.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/hash_convenyancing_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:hashching/pages/brokers/brokerschat.dart';
import 'package:hashching/pages/brokers/nobrokers.dart';
import 'package:hashching/pages/completetask/complete_task.dart';
import 'package:hashching/pages/homepage/myloanshome.dart';
import 'package:hashching/pages/myaccount/mydocumentvault/documentvault.dart';
import 'package:hashching/pages/myaccount/myproperty/myproperty.dart';
import 'package:hashching/pages/myaccount/myrewards/myrewards.dart';
import 'package:hashching/pages/mydeals/hash_convenyancing.dart';
import 'package:hashching/pages/mydeals/my_deals.dart';
import 'package:hashching/pages/myloans/no_loans.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key? key,
      required this.floatingPanelWidget,
      required this.isFloatingIconActive})
      : super(key: key);
  Widget floatingPanelWidget;
  bool isFloatingIconActive;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRewards = true;
  bool isProperty = false;
  bool isVault = false;
  bool setintthe = true;
  bool isCompleteTask = false;
  Future<ConsumerAccountModel>? fetchConsumerData;

  @override
  void initState() {
    print("===> Start");
    Future.delayed(const Duration(seconds: 0)).then((_) {
      ConsumerDashboardModel _dummy =
          Provider.of<ConsumerDashboardModel>(context, listen: false);
      Provider.of<LoanListProvider>(context, listen: false)
          .changewholelist(_dummy.allLoans);
      isCompleteTask = _dummy.completeTask;
      setintthe = false;
      setState(() {});
      print("===> End");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConsumerDashboardModel consumerDashboardModel =
        Provider.of<ConsumerDashboardModel>(context, listen: false);
    ConsumerAccountModel consumerAccountModel =
        Provider.of<ConsumerAccountModel>(context, listen: false);
// if(consumerDashboardModel == InitialData.consumerDashboardInitialData ||consumerAccountModel== InitialData.consumerAccountDataInitialData ){
//   return Center(
//                     child: CircularProgressIndicator(
//                       valueColor: new AlwaysStoppedAnimation<Color>(
//                           MasterStyle.thedaryColor),
//                     ),
//                   );
// }
    return SafeArea(
        child: setintthe
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Consumer<LoanListProvider>(builder:
                          (BuildContext context, LoanListProvider bloc,
                              Widget? child) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 20),
                              child: NewColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello,",
                                    style: MasterStyle.dashbordHeader,
                                  ),
                                  Text(
                                    "${consumerAccountModel.consumer.firstName} ${consumerAccountModel.consumer.lastName} 👋",
                                    style: MasterStyle.dashbordHeader,
                                  ),
                                  if (bloc.list.length != 0 &&
                                      consumerDashboardModel.completeTask)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        height: 30.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => CompleteTask(
                                                        statusName:
                                                            consumerDashboardModel
                                                                .allLoans[0]
                                                                .statusname,
                                                        encryptId:
                                                            consumerDashboardModel
                                                                .allLoans[0]
                                                                .encryptkey)));
                                          },
                                          child: Text('Complete task',
                                              style: MasterStyle
                                                  .whiteStyleRegularNormal
                                                  .merge(TextStyle(
                                                      fontSize: 14.sp))),
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.only(
                                                  left: 13.w,
                                                  right: 21.w,
                                                  top: 4.h,
                                                  bottom: 5.h),
                                              primary:
                                                  MasterStyle.quaternaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0.r)))),
                                        ),
                                      ),
                                    )
                                  else
                                    SizedBox(),
                                  bloc.list.length == 0
                                      ? NoLoans()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              top: 20, bottom: 26.5),
                                          decoration: BoxDecoration(
                                              color: HexColor('#EFF6FF'),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: NewColumn(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16,
                                                    top: 13,
                                                    bottom: 8),
                                                child: Text(
                                                  'My Loans',
                                                  style: MasterStyle
                                                      .blackWithSemiBoldStyle,
                                                ),
                                              ),
                                              Container(
                                                height: 159.h,
                                                child: ListView.separated(
                                                  // physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: bloc.list.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return HomeMyLoansPanel(
                                                      loanTypeDisplay: bloc
                                                                  .list[index]
                                                                  .loanType ==
                                                              ""
                                                          ? bloc.list[index]
                                                              .loantypeshow
                                                          : bloc.list[index]
                                                              .loanType,
                                                      encryptkey: bloc
                                                          .list[index]
                                                          .encryptkey,
                                                      loanType: bloc.list[index]
                                                          .loantypeshow,
                                                      status: bloc.list[index]
                                                          .statusname,
                                                      loanAmount: SimplifiedWidgets
                                                          .getloanAmountWithComma(
                                                              bloc.list[index]
                                                                  .loanAmount
                                                                  .toString()),
                                                      createDate: bloc
                                                          .list[index]
                                                          .createdate,
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      height: 2,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            HexColor('#CED4DB'),
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
                              height: 23.5.h,
                            ),
                            buildTitleText("My Brokers"),
                            consumerDashboardModel.allConsumerBrokers.length !=
                                    0
                                ? Container(
                                    height: 100.h,
                                    padding: EdgeInsets.only(
                                        left: 33.w, top: 16.h, bottom: 0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: consumerDashboardModel
                                          .allConsumerBrokers.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return buildBrokersList(
                                            consumerBrokersInformations:
                                                consumerDashboardModel
                                                    .allConsumerBrokers[index],
                                            index: index,
                                            name: consumerDashboardModel
                                                .allConsumerBrokers[index]
                                                .firstName
                                            //     +
                                            // ' ' +
                                            // consumerDashboardModel
                                            //     .allConsumerBrokers[index].lastName,
                                            ,
                                            profilePicture:
                                                consumerDashboardModel
                                                    .allConsumerBrokers[index]
                                                    .profilePic,
                                            onlineStatus: consumerDashboardModel
                                                .allConsumerBrokers[index]
                                                .onlineStatus,
                                            unreadMessage:
                                                consumerDashboardModel
                                                    .allConsumerBrokers[index]
                                                    .unreadCount);
                                      },
                                    ),
                                  )
                                : NoBrokers(),
                            SizedBox(
                              height: 26.5,
                            ),
                            mediumDivider(),
                            SizedBox(
                              height: 26.5,
                            ),
                            buildTitleText("My Account"),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        child: buildSubtitleOfAccount(
                                            "My Vault", isVault),
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
                                  buildMyAccounts(
                                      context, consumerDashboardModel),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MyDeals(
                                                        hashConveyacingRawList:
                                                            HashConveyacingRawList(
                                                                hashconveyacingList: []),
                                                        consumerAccountModel:
                                                            consumerAccountModel)));
                                          },
                                          child: buildMyDeals(
                                              'assets/icons/feedback.svg',
                                              "Earn 20 Points",
                                              "Tell us about your experience"))),
                                  SizedBox(
                                    width: 48,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HashConvenyancing(
                                                    hashConveyacingRawList:
                                                        HashConveyacingRawList(
                                                            hashconveyacingList: []),
                                                    consumerAccountModel:
                                                        consumerAccountModel)));
                                      },
                                      child: buildMyDeals(
                                          'assets/icons/paper_work.svg',
                                          "Conveyancing under \$700",
                                          "Fast and simple"),
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
                        );
                      }),
                    ),
                  ),
                  widget.floatingPanelWidget
                ],
              ));
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
                    height: 4,
                  ),
                  Text(
                    subtitle,
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

  buildMyAccounts(BuildContext context, consumerDashboardModel) {
    // ConsumerDetailsModel consumerDetailsProvider =
    //     Provider.of<ConsumerDetailsModel>(context);
    RewardsModel consumerRewardsInfo = Provider.of<RewardsModel>(context);
    ConsumerDocumentListModel consumerDocumentListProvider =
        Provider.of<ConsumerDocumentListModel>(context);
    // ConsumerBrokersListModel consumerBrokersListProvider =
    //     Provider.of<ConsumerBrokersListModel>(context);
    ConsumerDetailsModel consumerDetailsModel =
        Provider.of<ConsumerDetailsModel>(context);
    if (isRewards) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyRewards(
                      rewardsModelInformation: consumerRewardsInfo,
                      consumerInformation: consumerDetailsModel)));
        },
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 0),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: defaultDecoration(),
            child: Row(
              children: [
                Text(consumerDashboardModel.rewardPoints.toString(),
                    style:
                        MasterStyle.secondarySemiBoldTextStyle.merge(TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.normal,
                    ))),
                SizedBox(
                  width: 10.w,
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
            padding: EdgeInsets.only(
                left: 16.w, right: 15.86.w, top: 0, bottom: 12.h),
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
                              style: MasterStyle.blackTextStyleNormalSize,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                /* Row(
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
                ),*/

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Flexible(
                //       child: RichText(
                //         text: TextSpan(children: [
                //           TextSpan(
                //             text: 'Download your report now ',
                //             style: MasterStyle.secondarySemiBoldTextStyle,
                //           ),
                //           WidgetSpan(
                //               child: Icon(Icons.arrow_forward,
                //                   color: MasterStyle.appSecondaryColor,
                //                   size: 12.sp)),
                //         ]),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            )),
      );
    } else if (isVault) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DocumentVault(
                        consumerDocumentListModel: consumerDocumentListProvider,
                        consumerDashboardModel: consumerDashboardModel,
                      ))).then((value) {
            setState(() {});
          });
        },
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
                              consumerDashboardModel.consumerDocumentCount
                                          .toString() ==
                                      "1"
                                  ? 'You have ${consumerDashboardModel.consumerDocumentCount.toString()} document.'
                                  : consumerDashboardModel.consumerDocumentCount
                                              .toString() ==
                                          "0"
                                      ? "You have no document."
                                      : 'You have ${consumerDashboardModel.consumerDocumentCount.toString()} documents.',
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
        style: selected
            ? MasterStyle.secondaryNormalTextStyle
            : MasterStyle.whiteStyleWithRegular,
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
      required AllConsumerBrokers consumerBrokersInformations,
      bool? onlineStatus,
      int? unreadMessage}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BrokersChat(
                      consumerBrokers: consumerBrokersInformations,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(right: 20.w),
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
                      maxRadius: 22.r,
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
                                fontSize: 5.sp,
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
              padding: EdgeInsets.only(top: 10.h),
              child: Text(name, style: MasterStyle.whiteStyleRegularNormal),
            ),
          ],
        ),
      ),
    );
  }
}
