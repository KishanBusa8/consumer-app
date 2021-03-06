import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:hashching/models/all_loans_model.dart';
//import 'package:hashching/models/consumer_details_model.dart';
//import 'package:hashching/pages/myloans/enquirey_details.dart';
//import 'package:hashching/pages/myloans/enquirey_details/assigned_loan_details.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloandetails.dart';
//import 'package:hashching/pages/myloans/loans_widget_expansion/approved_enquiry_details.dart';
//import 'package:hashching/pages/myloans/loans_widget_expansion/assigned_loan_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/closed_enquiry_details.dart';
//import 'package:hashching/pages/myloans/loans_widget_expansion/lodged_enquiry_details.dart';
//import 'package:hashching/pages/myloans/loans_widget_expansion/onholed_enquiry_details.dart';
//import 'package:hashching/pages/myloans/loans_widget_expansion/qualified_enquiry_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion/loan_enquiry_details.dart';
import 'package:hashching/styles/masterstyle.dart';
//import 'package:provider/provider.dart';

class HomeMyLoansPanel extends StatelessWidget {
  final String loanType;
  final String status;
  final String createDate;
  final String loanAmount;
  final String encryptkey;
  final dynamic loanTypeDisplay;
  const HomeMyLoansPanel(
      {Key? key,
      required this.loanType,
      required this.status,
      required this.createDate,
      required this.loanAmount,
      required this.encryptkey,
      required this.loanTypeDisplay})
      : super(key: key);
  String getImageAssets(String loanType) {
    switch (loanType) {
      case 'Home Loan':
        return 'assets/home_assets/home_loan.svg';

      case 'Personal Loan':
        return 'assets/home_assets/personal_loan.svg';

      case 'Business Loan':
        return 'assets/home_assets/business_loan.svg';

      case 'Educational Loan':
        return 'assets/home_assets/scholarship.svg';

      case 'Car Finance':
        return 'assets/home_assets/car_loan.svg';

      case 'Assets & Equipment Finance':
        return 'assets/home_assets/assets_finance_loan.svg';

      default:
        return 'assets/home_assets/personal_loan.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    // ConsumerLoansModel consumerLoansModel =
    //     Provider.of<ConsumerLoansModel>(context);
    return InkWell(
      onTap: () {
        if (status == "New") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewLoanEnquireyDetails(
                      encryptkey: this.encryptkey,
                      loanTypeDisplay: loanTypeDisplay)));
        } else if (status == 'Closed') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClosedEnquiryDetails(
                      encryptkey: this.encryptkey,
                      loanTypeDisplay: loanTypeDisplay)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoanEnquiryDetails(
                      encryptkey: this.encryptkey,
                      statusName: status,
                      loanTypeDisplay: loanTypeDisplay)));
        }
        //
        //
        //  else if(status =='Lodged') {
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //            builder: (context) =>
        //                LodgedEnquiryDetails(encryptkey: this.encryptkey,loanTypeDisplay:loanTypeDisplay)));
        //
        //  }
        //  else if(status =='Approved') {
        //    print("-------------$status");
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //            builder: (context) =>
        //                ApprovedEnquiryDetails(encryptkey: this.encryptkey,loanTypeDisplay:loanTypeDisplay)));
        //
        //  }
        //  else if(status =='Qualified') {
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //            builder: (context) =>
        //                QualifiedEnquiryDetails(encryptkey: this.encryptkey,loanTypeDisplay: loanTypeDisplay,)));
        //
        //  }
        //
        //  else if(status =='On-Hold') {
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //            builder: (context) =>
        //                OnHoldEnquiryDetails(encryptkey: this.encryptkey,loanTypeDisplay:loanTypeDisplay)));
        //
        //  }
        // else if(status == "Assigned"){
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //            builder: (context) =>
        //                AssignedEnquiryDetails(encryptkey: this.encryptkey,statusName: status,loanTypeDisplay:loanTypeDisplay)));
        //  }
        //  else {
        //    Navigator.push(
        //        context,
        //        MaterialPageRoute(
        //            builder: (context) =>
        //                AssignedEnquiryDetails(encryptkey: this.encryptkey,loanTypeDisplay:loanTypeDisplay)));
        //   // Navigator.push(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //         builder: (context) => EnquireyDetails(
        //   //
        //   //             encryptkey: this.encryptkey)));
        // }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
                height: 33.1.h,
                width: 33.54.w,
                margin: EdgeInsets.only(right: 11.w),
                child: SvgPicture.asset(
                  getImageAssets(this.loanType),
                  height: 31.1.h,
                  width: 32.54.w,
                )),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        loanType.toString(),
                        style: MasterStyle.blackTextSemiBoldMediumSize,
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Text(
                        status == 'Closed' ? 'Unsuccessful' : status,
                        style: status == 'Settled' || status == 'New'
                            ? MasterStyle.possitiveStatusStyle
                            : status == 'Closed'
                                ? MasterStyle.negativeStatusStyle
                                : MasterStyle.assignedStatusStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Submitted on: $createDate",
                        style: MasterStyle.greySmallStyle,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '\$${loanAmount}',
                            style: MasterStyle.blackTextStyleNormalSize,
                            // minFontSize: 10,
                            // maxFontSize: 15,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
