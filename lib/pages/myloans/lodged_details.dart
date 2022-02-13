// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/enquiry_details_static_model.dart';
import 'package:hashching/pages/myloans/details_widgets.dart';

class LodgedLoanDetails extends StatelessWidget {
  LodgedLoanDetails({Key? key, required this.lodgedEnquiryModel})
      : super(key: key);
  EnquiryDetailsStaticModel lodgedEnquiryModel;

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
                    
                    detailsHeader('Loan Amount'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.loanAmount == ''
                        ? '_'
                        : '\$' +
                            this.lodgedEnquiryModel.loan.loanAmount.toString()),
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
                    detailsHeader('Rate of interest'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.closingRoi == ''
                        ? "_"
                        : this.lodgedEnquiryModel.loan.closingRoi.toString()+" %"),
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
                    detailsHeader('Product type'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.interestType ==
                            ''
                        ? '_'
                        : this.lodgedEnquiryModel.loan.interestType.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
                SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsHeader('Repayment type'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.lodgedEnquiryModel.loan.repaymentType == ''
                            ? '_'
                            : this
                                .lodgedEnquiryModel
                                .loan
                                .repaymentType
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
                    detailsHeader('Expected Approval Date'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.lodgedEnquiryModel.loan.estimatedApprovalDate == ''
                            ? '_'
                            : this
                                .lodgedEnquiryModel
                                .loan
                                .estimatedApprovalDate
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
                    detailsHeader('Product name'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.productName ==
                            ''
                        ? '_'
                        : this.lodgedEnquiryModel.loan.productName.toString()),
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
                    detailsHeader('Lodgement Date'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.lodgedDate == ''
                        ? '_'
                        : this.lodgedEnquiryModel.loan.lodgedDate.toString()),
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
                        this.lodgedEnquiryModel.loan.closingLender == ''
                            ? '_'
                            : this
                                .lodgedEnquiryModel
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
                    detailsHeader('Repayment year'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.lodgedEnquiryModel.loan.repaymentYears == ''
                            ? '_'
                            : this
                                .lodgedEnquiryModel
                                .loan
                                .repaymentYears
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
                    detailsHeader('Fixed year'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.fixedYears == ''
                        ? '_'
                        : this.lodgedEnquiryModel.loan.fixedYears.toString()),
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
                    detailsHeader('Lodgement Type'),
                    MySizedBox.height(8),
                    detailsContent(this.lodgedEnquiryModel.loan.interestType ==
                            ''
                        ? '_'
                        : this.lodgedEnquiryModel.loan.interestType.toString()),
                    MySizedBox.height(16),
                  ],
                ),
              ),
                SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 detailsHeader('Loan type'),
                    MySizedBox.height(8),
                    detailsContent(
                        this.lodgedEnquiryModel.loan.loanType == ''
                            ? '_'
                            : this
                                .lodgedEnquiryModel
                                .loan
                                .loanType
                                .toString()),
                    MySizedBox.height(16),
                  ],
                ),
              )
            ],
          ),
         // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     MyColumn(children: [
          //       detailsHeader('Amount settled'),
          //       MySizedBox.height(8),
          //       detailsContent(this.lodgedEnquiryModel.loan.loanAmount == ''
          //           ? '_'
          //           : '\$' +
          //               this.lodgedEnquiryModel.loan.loanAmount.toString()),
          //       MySizedBox.height(16),
          //       detailsHeader('Rate of interest'),
          //       MySizedBox.height(8),
          //       detailsContent(this.lodgedEnquiryModel.loan.closingRoi == ''
          //           ? "_"
          //           : this.lodgedEnquiryModel.loan.closingRoi.toString()),
          //       MySizedBox.height(16),
          //       detailsHeader('Product type'),
          //       MySizedBox.height(8),
          //       detailsContent(this.lodgedEnquiryModel.loan.productType == ''
          //           ? '_'
          //           : this.lodgedEnquiryModel.loan.productType.toString()),
          //       MySizedBox.height(16),
          //       detailsHeader('Repayment type'),
          //       MySizedBox.height(8),
          //       detailsContent(this.lodgedEnquiryModel.loan.repaymentType == ''
          //           ? '_'
          //           : this.lodgedEnquiryModel.loan.repaymentType.toString()),
          //       MySizedBox.height(16),
          //       detailsHeader('Product name'),
          //       MySizedBox.height(8),
          //       detailsContent(this.lodgedEnquiryModel.loan.productName == ''
          //           ? '_'
          //           : this.lodgedEnquiryModel.loan.productType.toString()),
          //       MySizedBox.height(16),
          //       detailsHeader('Expected Approval Date'),
          //       MySizedBox.height(8),
          //       detailsContent(
          //           this.lodgedEnquiryModel.loan.estimatedApprovalDate == ''
          //               ? '_'
          //               : this
          //                   .lodgedEnquiryModel
          //                   .loan
          //                   .estimatedApprovalDate
          //                   .toString()),
          //       MySizedBox.height(16),
          //     ]),
          //     Expanded(
          //       child: MyColumn(children: [
          //         detailsHeader('Lodgement Date'),
          //         MySizedBox.height(8),
          //         detailsContent(this.lodgedEnquiryModel.loan.lodgedDate == ''
          //             ? '_'
          //             : this.lodgedEnquiryModel.loan.lodgedDate.toString()),
          //         MySizedBox.height(16),
          //         detailsHeader('Lender'),
          //         MySizedBox.height(8),
          //         detailsContent(this.lodgedEnquiryModel.loan.closingLender ==
          //                 ''
          //             ? '_'
          //             : this.lodgedEnquiryModel.loan.closingLender.toString()),
          //         MySizedBox.height(16),
          //         detailsHeader('Fixed year'),
          //         MySizedBox.height(8),
          //         detailsContent(this.lodgedEnquiryModel.loan.fixedYears == ''
          //             ? '_'
          //             : this.lodgedEnquiryModel.loan.fixedYears.toString()),
          //         MySizedBox.height(16),
          //         detailsHeader('Repayment year'),
          //         MySizedBox.height(8),
          //         detailsContent(this.lodgedEnquiryModel.loan.repaymentYears ==
          //                 ''
          //             ? '_'
          //             : this.lodgedEnquiryModel.loan.productType.toString()),
          //         MySizedBox.height(16),
          //         detailsHeader('Property type'),
          //         MySizedBox.height(8),
          //         detailsContent(this.lodgedEnquiryModel.loan.productType == ''
          //             ? '_'
          //             : this.lodgedEnquiryModel.loan.productType.toString()),
          //         MySizedBox.height(16),
          //         detailsHeader('Loan type'),
          //         MySizedBox.height(8),
          //         detailsContent(this.lodgedEnquiryModel.loan.loantypeLabel ==
          //                 ''
          //             ? '_'
          //             : this.lodgedEnquiryModel.loan.loantypeLabel.toString()),
          //         MySizedBox.height(16),
          //       ]),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
