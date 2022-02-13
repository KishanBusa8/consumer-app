// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/mycol.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/newloan_enquirey_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';


class LoanEnquiryReport extends StatelessWidget {
  LoanEnquiryReport({Key? key, required this.loanEnquireyModel})
      : super(key: key);
  dynamic loanEnquireyModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    detailsHeader('Enquiry Amount'),
                    MySizedBox.height(8.h),
                    detailsContent(
                        '\$${this.loanEnquireyModel!.loan.loanAmount}'),
                    MySizedBox.height(16.h),
                    detailsHeader('Enquiry Date'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquireyModel!.loan.createdAt.toString()),
                    MySizedBox.height(16),
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    detailsHeader('Loan type'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquireyModel!.loan.loantypeLabel),
                    MySizedBox.height(16),
                    detailsHeader('Current Lender'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquireyModel!.loan.currentLender == ''
                            ? "-"
                            : this.loanEnquireyModel!.loan.currentLender),
                    MySizedBox.height(16),
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}
