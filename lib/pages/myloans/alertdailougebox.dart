import 'package:flutter/material.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/pages/myloans/businessloan/business_loan_enquirey.dart';
import 'package:hashching/pages/myloans/carloan/car_loan_enquirey_root.dart';
import 'package:hashching/pages/myloans/finance/finance_enquirey.dart';
import 'package:hashching/pages/myloans/homeloan/home_loan_enquirey.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class AlertDialogWidget {
  static TextButton buildContainer(text, onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          text,
          style: MasterStyle.blackTextWithNormalStyle,
        )
      ]),
    );
  }

  static dynamic alertBox(BuildContext context,ConsumerAccountModel consumerAccountModel) {
    return showDialog(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Center(
          child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
            // width: MediaQuery.of(context).size.width - 0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              // contentPadding:EdgeInsets.fromLTRB(.0, .0, 0, .0),
              color:  HexColor('#FFFFFF'),
            ),
            child: new Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildContainer(
                  'Home Loan',
                  () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeLoanEnquirey(consumerAccountModel:consumerAccountModel)));
                  },
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
                buildContainer('Business Loan', () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BusinessLoanEnquirey(consumerAccountModel:consumerAccountModel)));
                }),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
                buildContainer('Asset And Equipment Finance', () {
                    Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FinanceEnquirey(consumerAccountModel:consumerAccountModel)));
                }),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
                buildContainer('Car Loan', () {
                     Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CarLoanEnquireyRoot(consumerAccountModel:consumerAccountModel)));
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
