// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/lodged_process_timeline.dart';
import 'package:hashching/Utilities/process_timeline.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/all_loans_model.dart';
import 'package:hashching/models/enquiry_details_static_model.dart';
import 'package:hashching/models/loan_enquirey_model.dart';
import 'package:hashching/models/lodged_enquiry_model.dart';
import 'package:hashching/pages/myloans/approved_loan_details.dart';
import 'package:hashching/pages/myloans/enquirey_details/enquiry_details_report.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloan_enquirey_timeline.dart';
import 'package:hashching/pages/myloans/enquirey_report.dart';
import 'package:hashching/pages/myloans/enquirey_timeline.dart';
import 'package:hashching/pages/myloans/lodged_details.dart';
import 'package:hashching/pages/myloans/setteld_loan_Info.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

import '../lodged_details.dart';

class LodgedEnquiryDetails extends StatefulWidget {
  LodgedEnquiryDetails(
      {Key? key, required this.encryptkey, this.loanTypeDisplay})
      : super(key: key);

  String encryptkey;
  dynamic loanTypeDisplay;

  @override
  _LodgedEnquiryDetailsState createState() => _LodgedEnquiryDetailsState();
}

class _LodgedEnquiryDetailsState extends State<LodgedEnquiryDetails> {
  bool isClickToComplete = false;
  bool isSettled = false;
  bool isApproved = false;
  bool isLodged = false;
  bool isEnquiryReport = true;
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

                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(shrinkWrap: true, children: [
                      Container(
                          child: LodgedLoanProcessTimelinePage(
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
                          loanEnquireyModel.brokerDetail.name,
                          style: MasterStyle.whiteStyleWithRegular,
                        ),
                        subtitle: Text(loanEnquireyModel.brokerDetail.mobilenew,
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
                          status: "disable",
                          title: 'Settled',
                          onTap: () {},
                          isClick: isSettled),
                      Container(
                        height: 1,
                      ),
                      myEnquiryCards(
                          status: "disable",
                          title: 'Approved',
                          onTap: () {},
                          isClick: isApproved),
                      Container(
                        height: 1,
                      ),
                      myEnquiryCards(
                          status: "enable",
                          title: 'Lodged',
                          onTap: () {
                            if (isLodged) {
                              setState(() {
                                isLodged = !isLodged;
                              });
                            } else {
                              setState(() {
                                isLodged = !isLodged;

                                isEnquiryReport = false;
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
                          status: "enable",
                          title: 'Enquiry report',
                          onTap: () {
                            if (isEnquiryReport) {
                              setState(() {
                                isEnquiryReport = !isEnquiryReport;
                              });
                            } else {
                              setState(() {
                                isEnquiryReport = !isEnquiryReport;

                                isLodged = false;
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

  Widget myEnquiryCards({
    required String title,
    required void Function() onTap,
    required bool isClick,
    required String status,
  }) {
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
                : status == "enable"
                    ? MasterStyle.blackTextStyleNormalSize
                    : MasterStyle.unselectstatusStyle,
          ),
        ),
      ),
    );
  }
}
