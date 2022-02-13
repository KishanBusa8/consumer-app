// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/mycol.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/loan_enquirey_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';

class EnquireyReport extends StatelessWidget {
  EnquireyReport({Key? key, required this.loanEnquireyModel})
      : super(key: key);
  LoanEnquireyModel? loanEnquireyModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailsHeader('Enquiry Amount'),
          MySizedBox.height(8),
          detailsContent('\$${this.loanEnquireyModel!.loan.loanAmount}'),
          MySizedBox.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyColumn(children: [
                detailsHeader('Enquiry Date'),
                MySizedBox.height(8),
                 detailsContent(
                    this.loanEnquireyModel!.loan.settlementDate.toString()),
               MySizedBox.height(16),
                detailsHeader('Loan type'),
                MySizedBox.height(8),
               detailsContent(this.loanEnquireyModel!.loan.loanType),
                 MySizedBox.height(16),
                ]),
              MyColumn(children: [
                detailsHeader('Current Rate'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.secondInterestRate.toString()),
               MySizedBox.height(16),
                detailsHeader('Current Lender'),
                MySizedBox.height(8),
                detailsContent(
                  "-"),
                MySizedBox.height(16),
            
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
