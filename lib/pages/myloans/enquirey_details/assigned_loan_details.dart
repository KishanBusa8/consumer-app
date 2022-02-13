// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/assigned_loan_process_timeline.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/newloan_process_timeline.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/models/newloan_enquirey_model.dart';
import 'package:hashching/pages/brokers/brokerschat.dart';
import 'package:hashching/pages/myloans/enquirey_details/assigned_loan_enquirey_report.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloan_enquirey_report.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloan_enquirey_timeline.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';

class AssignedLoanEnquireyDetails extends StatefulWidget {
  AssignedLoanEnquireyDetails({Key? key, required this.encryptkey})
      : super(key: key);
  String encryptkey;

  @override
  _AssignedLoanEnquireyDetailsState createState() =>
      _AssignedLoanEnquireyDetailsState();
}

class _AssignedLoanEnquireyDetailsState
    extends State<AssignedLoanEnquireyDetails> {
  late var fetchLoanEnquireyDetails;
  bool isClickToComplete = false;
  @override
  void initState() {
    fetchLoanEnquireyDetails =
        ApiServices.fetchAssignedLoanDetails(encryptId: widget.encryptkey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: SimplifiedWidgets.appbar(
          appBarTitle: 'Enquiry Details', context: context),
      body: FutureBuilder(
          future: fetchLoanEnquireyDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic loanEnquireyModel = snapshot.data;
              print('loanEnquireyModel${loanEnquireyModel!}');

              return Container(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: AssignedLoanProcessTimelinePage()),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Broker details',
                            style: MasterStyle.whiteTextStyleNormal,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            horizontalTitleGap: 16,
                            leading: Container(
                              height: 51,
                              width: 51,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    loanEnquireyModel['broker_detail']
                                        ['profile_pic']),
                              ),
                            ),
                            title: Text(
                              loanEnquireyModel['broker_detail']['name'],
                              style: MasterStyle.whiteStyleWithRegular,
                            ),
                            subtitle: Text(
                                loanEnquireyModel['broker_detail']
                                    ['mobile'], //brokerDetail.mobile,
                                style: MasterStyle.whiteTextStyleNormal),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // InkWell(
                                //   onTap: () {
                                //        Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => BrokersChat(consumerBrokers: AllConsumerBrokers(userId:  loanEnquireyModel['broker_detail']['id'], firstName:  loanEnquireyModel['broker_detail']['name'], lastName: '', profilePic:  loanEnquireyModel['broker_detail']['profile_pic'], mobile:  loanEnquireyModel['broker_detail']['mobile'], state: 'state', brokerId: loanEnquireyModel['broker_detail']['id'], lastActivity: 'lastActivity', locality: 'locality', statecode: 'statecode', unreadCount: 0, sharedCount: 0, encodedId: 'encodedId', onlineStatus:  loanEnquireyModel['broker_detail']['online_status'], mobilenew:  loanEnquireyModel['broker_detail']['mobilenew']),)));
                                //   },
                                //   child: Container(
                                //     height: 28,
                                //     width: 28,
                                //     decoration: BoxDecoration(
                                //         color: MasterStyle.iconBackgroundColor,
                                //         shape: BoxShape.circle),
                                //     child: Icon(
                                //       Icons.sms_outlined,
                                //       color: MasterStyle.appIconColor,
                                //       size: 14,
                                //     ),
                                //   ),
                                // ),

                                SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  onTap: () {
                                    SimplifiedWidgets.triggerToCall(
                                        loanEnquireyModel['broker_detail']
                                            ['mobile']);
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        color: MasterStyle.iconBackgroundColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.phone,
                                      color: MasterStyle.appIconColor,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: MasterStyle.dashColor,
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isClickToComplete = !isClickToComplete;
                              });
                            },
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.only(top: 12, bottom: 8),
                              color: MasterStyle.appSecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 6),
                                child: Column(children: [
                                  Text(
                                    'Click to complete',
                                    style: MasterStyle.whiteTextLatoBold,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'You have outstanding tasks to complete for your home loan enquiry',
                                    textAlign: TextAlign.center,
                                    style: MasterStyle
                                        .whiteStyleRegularSmallNormal,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          isClickToComplete
                              ? completeLoanEnquireyCard()
                              : SizedBox(
                                  height: 8,
                                ),
                          Text(
                            'Loan details',
                            style: MasterStyle.whiteTextStyleMedium,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          myEnquireyCards(
                              title: 'Settled', onTap: () {}, isClick: false),
                          Container(
                            height: 1,
                          ),
                          myEnquireyCards(
                              title: 'Approved', onTap: () {}, isClick: false),
                          Container(
                            height: 1,
                          ),
                          myEnquireyCards(
                              title: 'Lodged', onTap: () {}, isClick: false),
                          Container(
                            height: 1,
                          ),
                          myEnquireyCards(
                              title: 'Enquiry Details',
                              onTap: () {},
                              isClick: true),
                          Container(
                            height: 1,
                          ),
                          AssignedLoanEnquireyReport(
                              loanEnquireyModel: loanEnquireyModel),
                          MySizedBox.height(16),
                          Text(
                            'Timeline',
                            style: MasterStyle.whiteMediumHeader,
                          ),
                          MySizedBox.height(16),
                          NewLoanEnquireyTimeline(),
                          MySizedBox.height(26),
                        ]),
                  ),
                ],
              ));
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
            ));
          }),
    );
  }

  Widget completeLoanEnquireyCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: MasterStyle.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                SimplifiedWidgets.launchInBrowser(
                    LocalConstants.uploadBankStatement, context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Upload bank statements',
                      style: MasterStyle.appBarSecondaryTextWithOpacityStyle,
                    ),
                  ),
                ],
              )),
          Divider(
            color: MasterStyle.customGreyColor,
            thickness: 1,
            height: 6,
          ),
          InkWell(
              onTap: () {
                SimplifiedWidgets.launchInBrowser(
                    LocalConstants.completeFactFind, context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Complete fact find',
                      style: MasterStyle.appBarSecondaryTextWithOpacityStyle,
                    ),
                  ),
                ],
              )),
          Divider(
            color: MasterStyle.customGreyColor,
            thickness: 1,
            height: 6,
          ),
          InkWell(
              onTap: () {
                print('click');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 14),
                    child: Text(
                      'Upload documents',
                      style: MasterStyle.appBarSecondaryTextWithOpacityStyle,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget myEnquireyCards(
      {required String title,
      required void Function() onTap,
      required bool isClick}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
        elevation: 0,
        margin: EdgeInsets.zero,
        color: MasterStyle.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 23.0, top: 18, bottom: 15),
          child: Text(
            title,
            style: isClick
                ? MasterStyle.appBarSecondaryBoldStyle
                : MasterStyle.unselectstatusStyle,
          ),
        ),
      ),
    );
  }
}
