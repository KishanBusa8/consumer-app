
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/enquiry_details_static_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';

class SettledLoanDetails extends StatelessWidget {
  SettledLoanDetails({Key? key, required this.loanEnquiryModel})
      : super(key: key);
  EnquiryDetailsStaticModel loanEnquiryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Amount Settled'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.loanAmount == ''
                        ? '_'
                        : '\$' +
                            this.loanEnquiryModel.loan.loanAmount.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySizedBox.height(8),
                    detailsHeader('Settlement Date'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.settlementDate == ''
                        ? "_"
                        : this.loanEnquiryModel.loan.settlementDate.toString()),
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
                      MySizedBox.height(8),
                    detailsHeader('Rate of interest'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.closingRoi == ''
                        ? "_"
                        : this.loanEnquiryModel.loan.closingRoi.toString()+" %"),
                    MySizedBox.height(16),
                  
                  ],
                ),
              ),
                SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Lender'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquiryModel.loan.closingLender == ''
                            ? '_'
                            : this
                                .loanEnquiryModel
                                .loan
                                .closingLender
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
                    detailsHeader('Product Type'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquiryModel.loan.interestType == ''
                            ? '_'
                            : this
                                .loanEnquiryModel
                                .loan
                                .interestType
                                .toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
                SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Fixed Years'),
                    MySizedBox.height(8),
                    detailsContent(this.loanEnquiryModel.loan.fixedYears ==
                            ''
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
                    detailsContent(this.loanEnquiryModel.loan.repaymentType == ''
                        ? '_'
                        : this.loanEnquiryModel.loan.repaymentType.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
                SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Repayment Years'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquiryModel.loan.repaymentYears == ''
                            ? '_'
                            : this
                                .loanEnquiryModel
                                .loan
                                .repaymentYears
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
                    detailsHeader('Product Name'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.loanEnquiryModel.loan.productName == ''
                            ? '_'
                            : this
                                .loanEnquiryModel
                                .loan
                                .productName
                                .toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
                SizedBox(width: 16,),
           ],
          ),
     ],
      ),
    );
  }
}
