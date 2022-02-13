
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/pages/calculator/ComparisonRateCal.dart';
import 'package:hashching/pages/calculator/ExtraRepayCal.dart';
import 'package:hashching/pages/calculator/LumpSumCal.dart';
import 'package:hashching/pages/calculator/MortgageRepayCal%20.dart';
import 'package:hashching/pages/calculator/ReverseMotorageCal.dart';
import 'package:hashching/pages/calculator/SavingsCal.dart';
import 'package:hashching/pages/calculator/SplitCal.dart';
import 'package:hashching/pages/calculator/StampDuty.dart';
import 'package:hashching/pages/calculator/borrowing_calculator.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Text("Loan Calculator",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: MasterStyle.secondaryThemeColor,
              fontSize: 17,
              fontWeight: FontWeight.normal,
              fontFamily: 'Lato',
            )),
        leading:
            IconButton(icon: Icon(Icons.arrow_back_ios, color: MasterStyle.secondaryThemeColor),onPressed: (){
              Navigator.pop(context);
            },),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 17.0, top: 8.0, bottom: 32.0, right: 16.0),
              child: Text(
                'Our free to use Home Loan Calculators and tools will give you quick answers to your home loan questions and help you own your home sooner.',
                style: MasterStyle.whiteStyleRegularNormal,
              ),
            ),
            wrapWithRow(
              navigateLeft: (){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BorrowingCalulator(),
                        fullscreenDialog: true,
                      ),
                    );
              },
              navigateRight: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LumpSumCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },
                calculatorCardOneName: 'Borrowing Calculator',
                card1topcolor: HexColor('#C660EC'),
                calculator2Name: ('Lump Sum Calculator'),
                card2topcolor: HexColor('#7698C3')),
            wrapWithRow( navigateRight: (){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ComparisonRateCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },navigateLeft: (){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MortgageRepayCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },
                calculatorCardOneName: 'Mortgage Repayment Calculator',
                card1topcolor: HexColor('#BF8758'),
                calculator2Name: ('Comparison Rate Calculators'),
                card2topcolor: HexColor('#BD4F6B')),
            wrapWithRow(
              navigateLeft: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StampDuty(),
                        fullscreenDialog: true,
                      ),
                    );
              },
              navigateRight: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExtraRepayCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },
                calculatorCardOneName: 'Stamp Duty Calculator',
                card1topcolor: HexColor('#60DBB9'),
                calculator2Name: ('Extra Repayment Calculator'),
                card2topcolor: HexColor('#F3DB61')),
            wrapWithRow(
              navigateRight: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReverseMotorageCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },
              navigateLeft: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SplitCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },
                calculatorCardOneName: 'Split Calculators',
                card1topcolor: HexColor('#7DCA5C'),
                calculator2Name: ('Reverse Mortgage Calculator'),
                card2topcolor: HexColor('#907274')),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
              child: Text(
                'Financial Tools',
                style: MasterStyle.whiteTextInputStyle,
              ),
            ),
            wrapWithRow(
              navigateLeft: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SavingsCal(),
                        fullscreenDialog: true,
                      ),
                    );
              },
                calculatorCardOneName: 'Savings Calculator',
                card1topcolor: HexColor('#FDFFF1'),
                calculator2Name: ('Budget Calculator'),
                card2topcolor: HexColor('#FDFFF1')),
          ],
        ),
      ),
    );
  }

  Padding wrapWithRow(
      {calculatorCardOneName, card1topcolor, calculator2Name, card2topcolor,navigateLeft,navigateRight}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: navigateLeft,
              child: Container(
                color: Colors.transparent,
                height: 94.0,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 8,
                          color: card1topcolor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.1, bottom: 5.73),
                          child: SvgPicture.asset(
                            'assets/icons/calculator.svg',
                            height: 20.26,
                            width: 20.26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 11, right: 11),
                          child: Text(calculatorCardOneName,
                              textAlign: TextAlign.center,
                              style: MasterStyle.blackTextboldSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: InkWell(
              onTap: navigateRight,
              child: Container(
                color: Colors.transparent,
                height: 94.0,
                child: Card(
                  margin: EdgeInsets.all(0),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 8,
                        color: card2topcolor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.1,
                          bottom: 5.73,
                        ),
                        child: SvgPicture.asset('assets/icons/calculator.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11, right: 11),
                        child: Text(calculator2Name,
                            textAlign: TextAlign.center,
                            style: MasterStyle.blackTextboldSize),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
