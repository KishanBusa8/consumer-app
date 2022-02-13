// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/pages/myloans/alertdailougebox.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloandetails.dart';
import 'package:hashching/pages/myloans/loans_list.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:provider/provider.dart';

import 'loans_widget_expansion/closed_enquiry_details.dart';
import 'loans_widget_expansion/loan_enquiry_details.dart';

List myLoansList = ['Home Loan', 'Personal Loan', 'Educational loan'];

class MyLoans extends StatefulWidget {
  MyLoans({Key? key, required this.myLoanNavigation}) : super(key: key);
  Widget myLoanNavigation;

  @override
  _MyLoansState createState() => _MyLoansState();
}

class _MyLoansState extends State<MyLoans> {
  List myLoansList = [];
  fetchBrokersList() {}
  @override
  void initState() {
    super.initState();
    myLoansList = ['Home Loan', 'Personal Loan', 'Educational loan'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConsumerDashboardModel consumerLoansModel =
        Provider.of<ConsumerDashboardModel>(context);
    ConsumerAccountModel consumerAccountModel =
        Provider.of<ConsumerAccountModel>(context);

    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: MasterStyle.backgroundColor,
        title: Text(
          "My Loans",
          style: MasterStyle.appBarTitleStyle,
        ),
        leading: widget.myLoanNavigation,
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.search, color: MasterStyle.appBarIconColor)),
        ],
      ),
      body: Container(
        color: MasterStyle.backgroundColor,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset('assets/myloans/myloan.svg')]),
            ),
            Container(
                child: CarouselSlider(
              options: CarouselOptions(
                height: 290.h,
                // aspectRatio: 1.1,
                viewportFraction: 0.58,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enableInfiniteScroll: false,
                initialPage: 1,
                autoPlay: false,
              ),
              items: myLoansCard(),
            )),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyLoansList(
                              consumerAccountModel: consumerAccountModel,
                              consumerLoansModel: consumerLoansModel)));
                },
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 32, left: 20, right: 20),
                    child: Text(
                      'Show list >',
                      style: MasterStyle.primaryContentBold,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimplifiedWidgets.elevatedButton(
                    color: MasterStyle.appSecondaryColor,
                    textStyle: MasterStyle.buttonWhiteTextStyle,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    text: 'Apply for a new loan',
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    onPresed: () {
                      AlertDialogWidget.alertBox(context, consumerAccountModel);
                    }),
              ],
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SimplifiedWidgets.elevatedButton(
            //         color: MasterStyle.appSecondaryColor,
            //         textStyle: MasterStyle.buttonWhiteTextStyle,
            //         padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            //         text: 'Finish previous form',
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //         onPresed: () {
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (context) => Progress()));
            //         }),
            //   ],
            // ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  Text contentHeading(text) {
    return Text(
      text,
      style: MasterStyle.blackTextSemiBoldMediumSize,
    );
  }

  Text content(text) {
    return Text(
      text,
      style: MasterStyle.blackWithRegularSmallStyle,
    );
  }

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

  List<Widget> myLoansCard() {
    ConsumerDashboardModel consumerLoansModel =
        Provider.of<ConsumerDashboardModel>(context);

    return consumerLoansModel.allLoans.map((loansDetails) {
      // readBrokerInfo(String brokerId) {
      //   var brokerDocument = consumerLoansModel.allConsumerBrokers
      //       .firstWhere((element) => element.userId.toString() == '193');
      //       print("*****${brokerDocument}");

      //   return brokerDocument;
      // }

      print("status" + loansDetails.status.toString());
      return InkWell(
        onTap: () {
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
          margin: EdgeInsets.symmetric(horizontal: 7.w),
          color: Colors.transparent,
          child: Card(
            color: MasterStyle.loansCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                top: 10.h,
                right: 10.w,
              ),
              child: SingleChildScrollView(
                child: NewColumnMin(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 61.9.h,
                                width: 61.9.w,
                                child: SvgPicture.asset(
                                  getImageAssets(
                                    loansDetails.loantypeshow,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Text(
                        loansDetails.loantypeshow,
                        style: MasterStyle.blackWithSemiBoldStyle,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          contentHeading('Broker name : '),
                          Expanded(
                              child: content(loansDetails.statusname != 'New'
                                  ? loansDetails.brokerName
                                  : " _")),
                        ],
                      ),
                      MySizedBox.height(8.h),
                      Row(
                        children: [
                          contentHeading('Loan Amount : '),
                          Expanded(
                              child: content(
                                  '\$${loansDetails.loanAmount.split('.').first}')),
                        ],
                      ),
                      MySizedBox.height(8.h),
                      Row(
                        children: [
                          contentHeading('Status :  '),
                          Expanded(child: content(loansDetails.statusname)),
                        ],
                      ),
                      MySizedBox.height(8.h),
                      Row(
                        children: [
                          contentHeading('Application ID :  '),
                          Expanded(child: content(loansDetails.id.toString())),
                        ],
                      ),
                      MySizedBox.height(8),
                    ]),
              ),
            ),
          ),
        ),
      );
    }).toList();

    //  FutureBuilder<LoanEnquireyModel?>(
    //     future: ApiServices.fetchLoanDetails(
    //         encryptId: loansDetails.encryptkey),
    //     builder: (context, snapshot) {

    //       LoanEnquireyModel? loanEnquireyModel = snapshot.data;

    //       return
  }
}
