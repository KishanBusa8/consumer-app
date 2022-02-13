// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/mycol.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/loan_enquirey_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';

class SettledLoanDetails extends StatelessWidget {
  SettledLoanDetails({Key? key, required this.loanEnquireyModel})
      : super(key: key);
  LoanEnquireyModel? loanEnquireyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailsHeader('Amount settled'),
          MySizedBox.height(8),
          detailsContent('\$${this.loanEnquireyModel!.loan.loanAmount}'),
          MySizedBox.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyColumn(children: [
                detailsHeader('Settlement date'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.settlementDate.toString()),
                MySizedBox.height(16),
                detailsHeader('Rate of interest'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.secondInterestRate.toString()),
                MySizedBox.height(16),
                detailsHeader('Product type'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.productType.toString()),
                MySizedBox.height(16),
                detailsHeader('Repayment type'),
                MySizedBox.height(8),
                detailsContent('_'),
                MySizedBox.height(16),
                detailsHeader('Product name'),
                MySizedBox.height(8),
                detailsContent('_'),
                MySizedBox.height(16),
              ]),
              MyColumn(children: [
                detailsHeader('Approved date'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.approvedDate.toString()),
                MySizedBox.height(16),
                detailsHeader('Lender'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.closingLender.toString()),
                MySizedBox.height(16),
                detailsHeader('Fixed year'),
                MySizedBox.height(8),
                detailsContent(
                    this.loanEnquireyModel!.loan.fixedYears.toString()),
                MySizedBox.height(16),
                detailsHeader('Repayment year'),
                MySizedBox.height(8),
                detailsContent('_'),
                MySizedBox.height(16),
                detailsHeader('Property type'),
                MySizedBox.height(8),
                detailsContent(this.loanEnquireyModel!.loan.productType),
                MySizedBox.height(16),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
