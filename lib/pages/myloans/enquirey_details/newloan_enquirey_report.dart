// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/mycol.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/newloan_enquirey_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';

class NewLoanEnquireyReport extends StatelessWidget {
  NewLoanEnquireyReport({Key? key, required this.loanEnquireyModel})
      : super(key: key);
  NewLoanEnquireyModel? loanEnquireyModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailsHeader('Enquiry Amount'),
          MySizedBox.height(8.h),
           detailsContent('\$${this.loanEnquireyModel!.loan.loanAmount}'),
          MySizedBox.height(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyColumn(children: [
                  detailsHeader('Enquiry Date'),
                  MySizedBox.height(8),
                   detailsContent(
                      this.loanEnquireyModel!.loan.createdAt.toString()),
                 MySizedBox.height(16),
                  detailsHeader('Loan type'),
                  MySizedBox.height(8),
                  detailsContent(this.loanEnquireyModel!.loan.loantypeLabel),
                   MySizedBox.height(16),
                  ]),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    detailsHeader('Product type'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquireyModel!.loan.productType.toString()),
                   MySizedBox.height(16),
                    detailsHeader('Current Lender'),
                    MySizedBox.height(8),
                    detailsContent(
                      "-"),
                    MySizedBox.height(16),
                            
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
