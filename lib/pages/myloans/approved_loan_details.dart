// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/enquiry_details_static_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';

class ApprovedLoanDetails extends StatelessWidget {
  ApprovedLoanDetails({Key? key, required this.loanEnquiryModel})
      : super(key: key);
  EnquiryDetailsStaticModel loanEnquiryModel;

  @override
  Widget build(BuildContext context) {
    print("loanEnquiryModel________${loanEnquiryModel.loan}");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailsHeader('Amount settled'),
          MySizedBox.height(8),
          detailsContent('\$${this.loanEnquiryModel.loan.loanAmount}'),
          MySizedBox.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Approval Date'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.approvedDate == ''
                        ? '_'
                        : this.loanEnquiryModel.loan.approvedDate.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySizedBox.height(8),
                    detailsHeader('Approved Loan Amount'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquiryModel.loan.approvedLoanAmount == ''
                            ? "_"
                            : this
                                .loanEnquiryModel
                                .loan
                                .approvedLoanAmount
                                .toString()),
                    MySizedBox.height(16),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Lender'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.closingLender ==
                            ''
                        ? '_'
                        : this.loanEnquiryModel.loan.closingLender.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Rate of interest'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.closingRoi == ''
                        ? '_'
                        : this.loanEnquiryModel.loan.closingRoi.toString() +
                            " %"),
                    MySizedBox.height(16),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Product Type'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.interestType == ''
                        ? '_'
                        : this.loanEnquiryModel.loan.interestType.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Fixed Years'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.fixedYears == ''
                        ? '_'
                        : this.loanEnquiryModel.loan.fixedYears.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Repayment Type'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.repaymentType ==
                            ''
                        ? '_'
                        : this.loanEnquiryModel.loan.repaymentType.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Repayment Years'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.repaymentYears ==
                            ''
                        ? '_'
                        : this.loanEnquiryModel.loan.repaymentYears.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
