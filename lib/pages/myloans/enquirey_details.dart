// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/process_timeline.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/loan_enquirey_model.dart';
import 'package:hashching/pages/myloans/enquirey_report.dart';
import 'package:hashching/pages/myloans/enquirey_timeline.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class EnquireyDetails extends StatefulWidget {
  EnquireyDetails({Key? key, required this.encryptkey}) : super(key: key);

  String encryptkey;

  @override
  _EnquireyDetailsState createState() => _EnquireyDetailsState();
}

class _EnquireyDetailsState extends State<EnquireyDetails> {
  bool isClickToComplete = false;
  bool isSettled = false;
  bool isApproved = false;
  bool isLodget = false;
  bool isEnquireyReport = false;
  late Future<LoanEnquireyModel?> fetchLoanEnquireyDetails;
  @override
  void initState() {
    fetchLoanEnquireyDetails =
        ApiServices.fetchLoanDetails(encryptId: widget.encryptkey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("***********enquiry");
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: SimplifiedWidgets.appbar(
            appBarTitle: 'Enquiry Details', context: context),
        body: FutureBuilder<LoanEnquireyModel?>(
            future: fetchLoanEnquireyDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var loanEnquireyModel = snapshot.data;
                print('loanEnquireyModel${loanEnquireyModel!}');
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(shrinkWrap: true, children: [
                      Container(child: ProcessTimelinePage()),
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
                                .consumerType), //,.brokerDetail.profilePic),
                          ),
                        ),
                        title: Text(
                          loanEnquireyModel.consumerType, //.brokerDetail.name,
                          style: MasterStyle.whiteStyleWithRegular,
                        ),
                        subtitle: Text(
                            loanEnquireyModel.loan.status
                                .toString(), //brokerDetail.mobile,
                            style: MasterStyle.whiteTextStyleNormal),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    color: MasterStyle.iconBackgroundColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.sms_outlined,
                                  color: MasterStyle.appIconColor,
                                  size: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: () {},
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
                                style: MasterStyle.whiteStyleRegularSmallNormal,
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
                                isLodget = false;
                                isEnquireyReport = false;
                              });
                            }
                          },
                          isClick: isSettled),
                      Container(
                        height: 1,
                      ),
                      // isSettled
                      //     ? SettledLoanDetails(
                      //         loanEnquiryModel: loanEnquiryModel)
                      //    : SizedBox(),
                      myEnquireyCards(
                          title: 'Approved',
                          onTap: () {
                            if (isApproved) {
                              setState(() {
                                isApproved = !isApproved;
                              });
                            } else {
                              setState(() {
                                isApproved = !isApproved;

                                isSettled = false;
                                isLodget = false;
                                isEnquireyReport = false;
                              });
                            }
                          },
                          isClick: isApproved),
                      Container(
                        height: 1,
                      ),
                      isApproved
                          ? SizedBox()
                          // ? ApprovedLoanDetails(
                          //     loanEnquiryModel: loanEnquireyModel)
                          : SizedBox(),
                      myEnquireyCards(
                          title: 'Lodged',
                          onTap: () {
                            if (isLodget) {
                              setState(() {
                                isLodget = !isLodget;
                              });
                            } else {
                              setState(() {
                                isLodget = !isLodget;
                                isSettled = false;
                                isApproved = false;
                                isEnquireyReport = false;
                              });
                            }
                          },
                          isClick: isLodget),
                      Container(
                        height: 1,
                      ),
                      // isLodget
                      //     ? LodgedLoanDetails(
                      //         loanEnquireyModel: loanEnquireyModel)
                      //     : SizedBox(),
                      myEnquireyCards(
                          title: 'Enquiry report',
                          onTap: () {
                            if (isEnquireyReport) {
                              setState(() {
                                isEnquireyReport = !isEnquireyReport;
                              });
                            } else {
                              setState(() {
                                isEnquireyReport = !isEnquireyReport;
                                isSettled = false;
                                isApproved = false;
                                isLodget = false;
                              });
                            }
                          },
                          isClick: isEnquireyReport),
                      Container(
                        height: 1,
                      ),
                      isEnquireyReport
                          ? EnquireyReport(loanEnquireyModel: loanEnquireyModel)
                          : MySizedBox.height(16),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        SimplifiedWidgets.elevatedButton(
                            textStyle: MasterStyle.buttonWhiteTextStyle,
                            color: MasterStyle.secondaryButtonColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onPresed: () {},
                            padding: EdgeInsets.symmetric(
                                vertical: 8.5, horizontal: 32.5),
                            text: 'Leave a review')
                      ]),
                      MySizedBox.height(16),
                      Text(
                        'Timeline',
                        style: MasterStyle.whiteMediumHeader,
                      ),
                      MySizedBox.height(16),
                      EnquireyTimeline(),
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
                : MasterStyle.blackTextWithNormalStyle,
          ),
        ),
      ),
    );
  }
}
