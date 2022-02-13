// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/lodged_process_timeline.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/enquiry_details_static_model.dart';
import 'package:hashching/pages/myloans/approved_loan_details.dart';
import 'package:hashching/pages/myloans/enquirey_details/enquiry_details_report.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloan_enquirey_timeline.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/settled_loan_details.dart';
import 'package:hashching/pages/myloans/lodged_details.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class AssignedEnquiryDetails extends StatefulWidget {
  AssignedEnquiryDetails(
      {Key? key,
      required this.encryptkey,
      this.statusName,
      this.loanTypeDisplay})
      : super(key: key);

  String encryptkey;
  dynamic statusName;
  dynamic loanTypeDisplay;

  @override
  _AssignedEnquiryDetailsState createState() => _AssignedEnquiryDetailsState();
}

class _AssignedEnquiryDetailsState extends State<AssignedEnquiryDetails> {
  bool isClickToComplete = false;
  bool isSettled = false;
  bool isApproved = false;
  bool isLodged = false;
  bool isEnquiryReport = true;
  bool isSettledEnabled = false;
  bool isApprovedEnabled = false;
  bool isLodgedEnabled = false;
  bool isEnquiryReportEnabled = true;
  bool isUnsuccessfulEnabled = false;
  late Future<EnquiryDetailsStaticModel?> fetchLoanEnquireyDetails;
  @override
  void initState() {
    fetchLoanEnquireyDetails =
        ApiServices.getEnquiryLoanDetails(encryptId: widget.encryptkey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("***********enquiry");
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: SimplifiedWidgets.appbar(
            appBarTitle: widget.loanTypeDisplay, context: context),
        body: FutureBuilder<EnquiryDetailsStaticModel?>(
            future: fetchLoanEnquireyDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var loanEnquireyModel = snapshot.data;
                print('loanEnquireyModel${loanEnquireyModel!}');
                isUnsuccessfulEnabled =
                    loanEnquireyModel.loan.closingStatus.toString() != '-1';

                if (!(loanEnquireyModel.loan.status.toString() != '-1' &&
                    loanEnquireyModel.loan.closingStatus.toString() != '1')) {
                  if (loanEnquireyModel.loan.closingStatus.toString() != '0') {
                    isSettledEnabled = true;
                  } else {
                    isSettledEnabled = false;
                  }
                }
                ;
                isApprovedEnabled =
                    !(loanEnquireyModel.loan.status.toString() != '-1' &&
                        loanEnquireyModel.loan.status.toString() != '3');
                isLodgedEnabled =
                    !(loanEnquireyModel.loan.status.toString() != '-1' &&
                        loanEnquireyModel.loan.status.toString() != '3' &&
                        loanEnquireyModel.loan.status.toString() != '5');
                isEnquiryReportEnabled = true;
                print(isSettledEnabled.toString() + '--');
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(shrinkWrap: true, children: [
                      Container(
                          child: LodgedLoanProcessTimelinePage(
                        statusName: widget.statusName,
                        loan: loanEnquireyModel.loan,
                        brokerDetail: loanEnquireyModel.brokerDetail,
                      )),
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
                            backgroundImage: NetworkImage(loanEnquireyModel
                                .brokerDetail
                                .profilePic), //,.brokerDetail.profilePic),
                          ),
                        ),
                        title: Text(
                          loanEnquireyModel
                              .brokerDetail.name, //.brokerDetail.name,
                          style: MasterStyle.whiteStyleWithRegular,
                        ),
                        subtitle: Text(
                            loanEnquireyModel.brokerDetail.mobilenew
                                .toString(), //brokerDetail.mobile,
                            style: MasterStyle.whiteTextStyleNormal),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // InkWell(
                            //   onTap: () {},
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
                                    loanEnquireyModel.brokerDetail.mobilenew);
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
                      loanEnquireyModel.loan.leadDetailsMystroRequested ||
                              loanEnquireyModel.loan.bankStatementRequest
                          ? InkWell(
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
                            )
                          : SizedBox(),
                      isClickToComplete
                          ? SimplifiedWidgets.completeLoanEnquiryCard(
                              loanEnquireyModel.loan, context)
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
                      myEnquiryCards(
                          conditions: loanEnquireyModel.loan.status != '-1' &&
                              loanEnquireyModel.loan.closingStatus != '1',
                          status: isSettledEnabled,
                          title: 'Settled',
                          onTap: () {
                            if (isSettled) {
                              setState(() {
                                isSettled = !isSettled;
                              });
                            } else {
                              setState(() {
                                isSettled = !isSettled;
                                isApproved = false;
                                isEnquiryReport = false;
                                isLodged = false;
                              });
                            }
                          },
                          isClick: isSettled),
                      Container(
                        height: 1,
                      ),
                      isSettled
                          ? SettledLoanDetails(
                              loanEnquiryModel: loanEnquireyModel,
                            )
                          : SizedBox(),
                      myEnquiryCards(
                          conditions: loanEnquireyModel.loan.status != '-1' &&
                              loanEnquireyModel.loan.status != '3',
                          status: isApprovedEnabled,
                          title: 'Approved',
                          onTap: () {
                            if (isApproved) {
                              setState(() {
                                isApproved = !isApproved;
                              });
                            } else {
                              setState(() {
                                isApproved = !isApproved;

                                isEnquiryReport = false;
                                isLodged = false;
                                isSettled = false;
                              });
                            }
                          },
                          isClick: isApproved),
                      Container(
                        height: 1,
                      ),
                      isApproved
                          ? ApprovedLoanDetails(
                              loanEnquiryModel: loanEnquireyModel,
                            )
                          : SizedBox(),
                      myEnquiryCards(
                          conditions: loanEnquireyModel.loan.status != '-1' &&
                              loanEnquireyModel.loan.status != '3' &&
                              loanEnquireyModel.loan.status != '5',
                          status: isLodgedEnabled,
                          title: 'Lodged',
                          onTap: () {
                            if (isLodged) {
                              setState(() {
                                isLodged = !isLodged;
                              });
                            } else {
                              setState(() {
                                isLodged = !isLodged;
                                isApproved = false;
                                isEnquiryReport = false;
                                isSettled = false;
                              });
                            }
                          },
                          isClick: isLodged),
                      Container(
                        height: 1,
                      ),
                      isLodged
                          ? LodgedLoanDetails(
                              lodgedEnquiryModel: loanEnquireyModel,
                            )
                          : SizedBox(),
                      myEnquiryCards(
                          conditions: true,
                          status: isEnquiryReportEnabled,
                          title: 'Enquiry report',
                          onTap: () {
                            if (isEnquiryReport) {
                              setState(() {
                                isEnquiryReport = !isEnquiryReport;
                              });
                            } else {
                              setState(() {
                                isEnquiryReport = !isEnquiryReport;
                                isApproved = false;
                                isLodged = false;
                                isSettled = false;
                              });
                            }
                          },
                          isClick: isEnquiryReport),
                      Container(
                        height: 1,
                      ),
                      isEnquiryReport
                          ? LoanEnquiryReport(
                              loanEnquireyModel: loanEnquireyModel,
                            )
                          : MySizedBox.height(16),
                      MySizedBox.height(16),
                      Text(
                        'Timeline',
                        style: MasterStyle.whiteMediumHeader,
                      ),
                      MySizedBox.height(16),
                      NewLoanEnquireyTimeline(),
                      MySizedBox.height(26),
                    ]));
              }
              return Center(
                  child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
              ));
            }));
  }

  Color hideContentColor = HexColor('#EFF6FF');
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
                print('click');
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
                print('click');
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

  Widget myEnquiryCards(
      {required String title,
      required void Function() onTap,
      required bool isClick,
      required bool status,
      required bool conditions}) {
    return InkWell(
      onTap: status ? onTap : null,
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
                : status
                    ? MasterStyle.blackTextStyleNormalSize
                    : MasterStyle.unselectstatusStyle,
          ),
        ),
      ),
    );
  }
}
