// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/masterstyle.dart';

class HomeLoanType extends StatefulWidget {
  HomeLoanType(
      {Key? key,
      required this.isNewLoan,
      required this.controller,
      required this.isRefinance,
      required this.newLoanButtonColor,
      required this.refinanceButtonColor
      })
      : super(key: key);
  bool isNewLoan;
  AnimationController controller;
  bool isRefinance;
  Color newLoanButtonColor;
  Color refinanceButtonColor;

  @override
  _HomeLoanTypeState createState() => _HomeLoanTypeState();
}

class _HomeLoanTypeState extends State<HomeLoanType> {
  @override
  Widget build(BuildContext context) {

    return NewColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select loan type :',
          style: MasterStyle.secondarySemiBoldTextStyle,
        ),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 8),
          child: SimplifiedWidgets.elevatedButton(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color:  widget.newLoanButtonColor,
              text: 'New Loan',
              padding: EdgeInsets.symmetric(vertical: 12),
              onPresed: () {
                setState(() {
                  if (widget.isNewLoan) {
                    widget.isNewLoan = !widget.isNewLoan;
                    widget.controller.reset();
                    widget.newLoanButtonColor=MasterStyle.whiteColor;
                  } else {
                     widget.newLoanButtonColor=MasterStyle.appSecondaryColor;
                    widget.isNewLoan = !widget.isNewLoan;
                    widget.isRefinance = false;
                    widget.controller.forward();
                  }
                });
              },
              textStyle: widget.isNewLoan
                  ? MasterStyle.buttonWhiteTextStyle
                  : MasterStyle.blackTextStyleNormalSize),
        ),
        Container(
          child: SimplifiedWidgets.elevatedButton(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: widget.isRefinance
                  ? MasterStyle.appSecondaryColor
                  : MasterStyle.whiteColor,
              text: 'Refinance',
              padding: EdgeInsets.symmetric(vertical: 12),
              onPresed: () {
                setState(() {
                  if (widget.isRefinance) {
                    widget.isRefinance = !widget.isRefinance;
                    widget.controller.reset();
                    
                  } else {
                    widget.isRefinance = !widget.isRefinance;
                    widget.isNewLoan = false;
                    widget.controller.forward();
                  }
                });
              },
              textStyle: widget.isRefinance
                  ? MasterStyle.buttonWhiteTextStyle
                  : MasterStyle.blackTextStyleNormalSize),
        )
      ],
    );
  }
}
