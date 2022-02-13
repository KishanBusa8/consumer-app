// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/pages/myloans/alertdailougebox.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloandetails.dart';
import 'package:hashching/styles/masterstyle.dart';

import 'loans_widget_expansion/closed_enquiry_details.dart';
import 'loans_widget_expansion/loan_enquiry_details.dart';

class MyLoansList extends StatefulWidget {
  MyLoansList(
      {Key? key,
      required this.consumerLoansModel,
      required this.consumerAccountModel})
      : super(key: key);
  ConsumerDashboardModel consumerLoansModel;
  ConsumerAccountModel consumerAccountModel;

  @override
  State<MyLoansList> createState() => _MyLoansListState();
}

class _MyLoansListState extends State<MyLoansList> {
  String getImageAssets(String loanType) {
    switch (loanType) {
      case 'Home Loan':
        return 'assets/myloans/home_loan.svg';

      case 'Personal Loan':
        return 'assets/myloans/personal_loan.svg';

      case 'Business Loan':
        return 'assets/myloans/business_loan.svg';

      case 'Educational Loan':
        return 'assets/myloans/scholarship.svg';

      case 'Car Finance':
        return 'assets/myloans/car_loan.svg';

      case 'Assets & Equipment Finance':
        return 'assets/myloans/finance_loan.svg';

      default:
        return 'assets/myloans/personal_loan.svg';
    }
  }

  TextStyle getStatusColor(String statusName) {
    TextStyle statusStyle = TextStyle();
    switch (statusName) {
      case 'Settled':
        statusStyle = MasterStyle.greenContentWithBold;

        break;
      case 'Qualified':
        statusStyle = MasterStyle.qualifiedTextStyle;

        break;
      case 'Unsuccessful':
        statusStyle = MasterStyle.qualifiedTextStyle
            .merge(TextStyle(color: Colors.redAccent));

        break;

      default:
        statusStyle =
            MasterStyle.commonTextStyle.merge(TextStyle(fontSize: 15.h));
    }
    return statusStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      bottomNavigationBar: Container(
          height: 60,
          child: Container(
            padding: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SimplifiedWidgets.elevatedButton(
                      color: MasterStyle.appSecondaryColor,
                      textStyle: MasterStyle.buttonWhiteTextStyle,
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 10.h),
                      text: 'Apply for a new loan',
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onPresed: () {
                        AlertDialogWidget.alertBox(
                            context, widget.consumerAccountModel);
                      })
                ]),
              ],
            ),
          )),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: MasterStyle.backgroundColor,
        title: Text(
          "My Loans",
          style: MasterStyle.appBarTitleStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:
                Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor)),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.search, color: MasterStyle.appBarIconColor)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: ListView.builder(
            itemCount: widget.consumerLoansModel.allLoans.length,
            itemBuilder: (context, int index) {
              return NewColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loan ${index + 1}',
                    style: MasterStyle.whiteStyleWithBold,
                  ),
                  InkWell(
                    onTap: () {
                      var loansDetails =
                          widget.consumerLoansModel.allLoans[index];
                      if (loansDetails.statusname == "New") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewLoanEnquireyDetails(
                                    encryptkey: loansDetails.encryptkey,
                                    loanTypeDisplay: loansDetails.loanType == ''
                                        ? loansDetails.loantypeshow
                                        : loansDetails.loanType)));
                      } else if (loansDetails.statusname == 'Closed') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClosedEnquiryDetails(
                                    encryptkey: loansDetails.encryptkey,
                                    loanTypeDisplay: loansDetails.loanType == ''
                                        ? loansDetails.loantypeshow
                                        : loansDetails.loanType)));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanEnquiryDetails(
                                    encryptkey: loansDetails.encryptkey,
                                    statusName: loansDetails.statusname,
                                    loanTypeDisplay: loansDetails.loanType == ''
                                        ? loansDetails.loantypeshow
                                        : loansDetails.loanType)));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: MasterStyle.whiteColor,
                      ),
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                      margin: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 62.w,
                                  width: 62.h,
                                  child: SvgPicture.asset(getImageAssets(widget
                                      .consumerLoansModel
                                      .allLoans[index]
                                      .loantypeshow))),
                              Expanded(
                                child: Container(
                                  height: 62.h,
                                  padding: EdgeInsets.only(left: 14.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          widget.consumerLoansModel
                                              .allLoans[index].loantypeshow,
                                          style: MasterStyle
                                              .blackWithSemiBoldStyle),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithStyle('Broker name :'),
                                  textWithStyle('Loan Amount :'),
                                  textWithStyle('Application ID :'),
                                  textWithStyle('Status '),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    textWithStyle(widget.consumerLoansModel
                                                .allLoans[index].statusname ==
                                            'New'
                                        ? '  _'
                                        : widget.consumerLoansModel
                                            .allLoans[index].brokerName),
                                    textWithStyle(
                                        '\$${widget.consumerLoansModel.allLoans[index].loanAmount.split('.').first}'),
                                    textWithStyle(widget
                                        .consumerLoansModel.allLoans[index].id
                                        .toString()),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.0.h),
                                      child: Text(
                                        widget.consumerLoansModel
                                            .allLoans[index].statusname,
                                        style: getStatusColor(widget
                                            .consumerLoansModel
                                            .allLoans[index]
                                            .statusname),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );

              /*  FutureBuilder<LoanEnquireyModel?>(
                  future: ApiServices.fetchLoanDetails(
                      encryptId:
                          widget.consumerLoansModel.allLoans[index].encryptkey),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      LoanEnquireyModel? loanEnquireyModel = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loan ${index+1}',
                            style: MasterStyle.whiteStyleWithBold,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: MasterStyle.whiteColor,
                            ),
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.fromLTRB(20, 8, 20, 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        height: 62,
                                        width: 62,
                                        child: SvgPicture.asset(getImageAssets(
                                            widget
                                                .consumerLoansModel
                                                .allLoans[index]
                                                .loantypeshow))),
                                    Padding(
                                      padding: EdgeInsets.only(left: 14),
                                      child: Text(
                                          widget.consumerLoansModel
                                              .allLoans[index].loantypeshow,
                                          style: MasterStyle
                                              .blackWithSemiBoldStyle),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textWithStyle('Broker name :'),
                                        textWithStyle('Loan Amount :'),
                                        textWithStyle('Application ID :'),
                                        textWithStyle('Status'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        textWithStyle('  _'
                                            // loanEnquireyModel!
                                            //   .brokerDetail.name

                                            ),
                                        textWithStyle(
                                            loanEnquireyModel!.loan.loanAmount),
                                        textWithStyle('  _'
                                            // loanEnquireyModel
                                            //   .loan.applicationNumber.toString()
                                            ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            loanEnquireyModel
                                                        .loan.closingStatus ==
                                                    null
                                                ? '  _'
                                                : "",
                                            style: getStatusColor(
                                                loanEnquireyModel.loan
                                                            .closingStatus ==
                                                        null
                                                    ? '  _'
                                                    : ''),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return SkeletonLoaderMyLoan();
                    }
                  });
         
          */
            }),
      ),
    );
  }

  Padding textWithStyle(text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Text(
        text,
        style: MasterStyle.blackTextStyleNormalSize,
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
