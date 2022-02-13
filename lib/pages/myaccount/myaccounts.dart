// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:hashching/pages/myaccount/mydocumentvault/documentvault.dart';
import 'package:hashching/pages/myaccount/myproperty/myproperty.dart';
import 'package:hashching/pages/myaccount/myrewards/myrewards.dart';
import 'package:hashching/pages/myaccount/settings.dart';
import 'package:hashching/provider/initialdata.dart';
import 'package:hashching/provider/stateprovider.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key, this.myAccountNavigation}) : super(key: key);
  var myAccountNavigation;

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  List titleList = ["My Rewards", "My Property", "My Document Vault"];
  List subtitle = [
    "Earn reward points that can be exchanged for gift cards.",
    "Discover the value, key details, and location statistics for your current or future property.",
    "Securely store, share, and view your loan documents."
  ];
  List iconsList = [
    "assets/icons/my_rewards.svg",
    "assets/icons/my_property.svg",
    "assets/icons/my_vault.svg"
  ];

  List onPressed(
      {RewardsModel? rewardsModel,
      ConsumerDetailsModel? consumerInformation,
      ConsumerDocumentListModel? consumerDocumentListModel,
      ConsumerDashboardModel? consumerDashboardModel}) {
    return [
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyRewards(
                    rewardsModelInformation: rewardsModel,
                    consumerInformation: consumerInformation)));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyProperty()));
      },
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DocumentVault(
                    consumerDocumentListModel: consumerDocumentListModel,
                    consumerDashboardModel: consumerDashboardModel)));
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    ConsumerDashboardModel consumerDashboardModel =
        Provider.of<ConsumerDashboardModel>(context, listen: true);
    ConsumerAccountModel consumerAccountModelProvider =
        Provider.of<ConsumerAccountModel>(context);

    ConsumerDetailsModel consumerDetailsProvider =
        Provider.of<ConsumerDetailsModel>(context, listen: true);
    RewardsModel consumerRewardsInfo =
        Provider.of<RewardsModel>(context, listen: true);
    ConsumerDocumentListModel consumerDocumentListModel =
        Provider.of<ConsumerDocumentListModel>(context, listen: true);

    if (consumerDetailsProvider == InitialData.consumerDashboardInitialData ||
        consumerRewardsInfo == InitialData.rewardsModelData ||
        consumerDocumentListModel == InitialData.consumerDocumentList) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(MasterStyle.thedaryColor),
        ),
      );
    }
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "My Account",
            style: MasterStyle.primaryContentStyle,
          ),
          titleSpacing: 20,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAccountSettings(
                                consumerInformation: consumerDetailsProvider,
                                consumerAccount: consumerAccountModelProvider,
                              ))).then((value) {
                                setState(() {
                                  consumerAccountModelProvider.consumer.profilePic = value;
                                });
                  });
                },
                icon: Icon(Icons.settings, color: Colors.white)),
            SizedBox(width: 10)
          ],
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 60),
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(40.w, 52.h, 40.w, 24.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: NewColumn(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.h, bottom: 6.h),
                                  child: Text(
                                    consumerAccountModelProvider
                                            .consumer.firstName +
                                        ' ' +
                                        consumerAccountModelProvider
                                            .consumer.lastName!,
                                    style: MasterStyle.lightBlackBoldStyle,
                                  ),
                                ),
                                Text(
                                  consumerAccountModelProvider.consumer.email,
                                  style: MasterStyle.greyNormalStyle,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -60,
                            child: consumerAccountModelProvider
                                        .consumer.profilePic !=
                                    ''
                                ? Container(
                                    height: 114.h,
                                    width: 114.w,
                                    decoration: BoxDecoration(
                                        color: MasterStyle.whiteColor,
                                        shape: BoxShape.circle),
                                    padding: EdgeInsets.all(1),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                        consumerAccountModelProvider
                                            .consumer.profilePic,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 114.h,
                                    width: 114.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle),
                                    child: !InitialData.isImageSelected
                                        ? Center(
                                            child: Text(
                                              consumerAccountModelProvider
                                                  .consumer.firstName
                                                  .split("")
                                                  .first
                                                  .toString()
                                                  .toUpperCase(),
                                              style: MasterStyle.dashbordHeader
                                                  .merge(TextStyle(
                                                      color: MasterStyle
                                                          .thedaryColor,
                                                      fontSize: 60.sp)),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundImage:
                                                FileImage(InitialData.image!),
                                            maxRadius: 40.r,
                                          ),
                                  ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: onPressed(
                                rewardsModel: consumerRewardsInfo,
                                consumerInformation: consumerDetailsProvider,
                                consumerDocumentListModel:
                                    consumerDocumentListModel,
                                consumerDashboardModel:
                                    consumerDashboardModel)[index],
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.only(
                                    top: 16.h,
                                    bottom: 25.h,
                                    right: 12.w,
                                    left: 15.w),
                                decoration: cardDecoration,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 16.w),
                                      child: SvgPicture.asset(
                                        iconsList[index],
                                        height: 41.6.h,
                                        width: 37.46.w,
                                      ),
                                    ),
                                    Container(
                                      child: Expanded(
                                        child: NewColumnMain(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              titleList[index],
                                              style: MasterStyle
                                                  .secondarySemiBoldTextStyle,
                                            ),
                                            Text(subtitle[index],
                                                style: MasterStyle
                                                    .greyNormalStyle),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16),

                // decoration: cardDecoration,
                child: Row(
                  children: [
                    widget.myAccountNavigation,
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool(LocalConstants.loggedIn, false);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => StateProvider()),
                                (Route<dynamic> route) => false);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#F56735")),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.red)))),
                          child: Text("Sign out",
                              style: MasterStyle.buttonWhiteTextStyle),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }

  BoxDecoration cardDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));
}
