// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class BorrowingCalulator extends StatefulWidget {
  const BorrowingCalulator({Key? key}) : super(key: key);

  @override
  _BorrowingCalulatorState createState() => _BorrowingCalulatorState();
}

class _BorrowingCalulatorState extends State<BorrowingCalulator> {
  OutlineInputBorder formOutlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: HexColor('#6D7B95'),
        width: 0.2,
      ));
  final _formKey = GlobalKey<FormState>();
  bool isOne = true;
  bool isTwo = false;
  int depentancies = 1;
  int loanTerms = 1;

  calulator(){
    // ignore: unused_local_variable
    var calll = (100000)*(1+0.1);
    var squr = pow(11000,20);
    print("calli === $squr");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Text("Borrowing Calculator",
            style: TextStyle(
              color: MasterStyle.secondaryThemeColor,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: MasterStyle.secondaryThemeColor),
            onPressed: () {
              calulator();
              // Navigator.pop(context);
            }),
        actions: <Widget>[],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How much can you borrow? Our borrowing calculator can provide you with an estimate of how much you can afford to borrow, based on factors such as your income and expenditure.',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 8.0, left: 16),
                    child: Text(
                      'How Many Borrowers Are There?',
                      style: MasterStyle.whiteStyleOpacityWithRegular,
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (isOne) {
                                    } else {
                                      setState(() {
                                        isTwo = false;
                                        isOne = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "One",
                                    style: MasterStyle
                                        .whiteStyleOpacityWithRegular,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: isOne
                                          ? MaterialStateProperty.resolveWith(
                                              (states) => MasterStyle
                                                  .secondaryThemeColor)
                                          : MaterialStateProperty.resolveWith(
                                              (states) =>
                                                  MasterStyle.backgroundColor),
                                      shape: MaterialStateProperty.resolveWith(
                                          (states) => RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5))))))),
                        ),
                        Expanded(
                          child: ButtonTheme(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (isTwo) {
                                      setState(() {
                                        isTwo = true;
                                        isOne = false;
                                      });
                                    } else {
                                      setState(() {
                                        isTwo = true;
                                        isOne = false;
                                      });
                                    }
                                  },
                                  child: Text("Two",
                                      style: MasterStyle
                                          .whiteStyleOpacityWithRegular),
                                  style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.resolveWith(
                                        (states) => 0,
                                      ),
                                      backgroundColor: isTwo
                                          ? MaterialStateProperty.resolveWith((states) =>
                                              MasterStyle.secondaryThemeColor)
                                          : MaterialStateProperty.resolveWith((states) =>
                                              MasterStyle.backgroundColor),
                                      shape: MaterialStateProperty.resolveWith(
                                          (states) => RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: MasterStyle.whiteColor
                                                      .withOpacity(.1),
                                                  width: 1),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomRight: Radius.circular(5))))))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'How Many Dependents Do You Have?',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    
                    decoration: BoxDecoration(      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: HexColor('#6D7B95'),
        width: 0.2,),),
                    child: Row(
                      children: [
                        Container(    color: MasterStyle.whiteColor.withOpacity(0.1),
                        child: InkWell(
                          onTap: (){
                         if(depentancies ==0){}
                            else{
                            setState(() {
                              depentancies--;
                            });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                            '-',style: MasterStyle.whiteStyleOpacityWithRegular,
                          ),),
                        ),),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text('${depentancies}',style: MasterStyle.whiteStyleRegularNormal,),
                        )),
                        Container(    color: MasterStyle.whiteColor.withOpacity(0.1),
                        child: InkWell(
                          onTap: (){
                            
                        
                            setState(() {
                              depentancies++;
                            });
                            
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                            '+',style: MasterStyle.whiteStyleOpacityWithRegular,
                          ),),
                        ),),
                      ],
                    ),
                  ),
                 SizedBox(
                    height: 13,
                  ),
                  Text(
                    'What is your net income?',
                    style: MasterStyle.buttonWhiteTextStyleBold,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Salary Income',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(.1),
                                    width: 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      child: Text(
                                        '\$',
                                        style: MasterStyle.whiteTextStyleNormal,
                                      )),
                                ),
                                TextSpan(
                                    text: '50,000',
                                    style: MasterStyle.whiteTextStyleNormal)
                              ]),
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(.1),
                                  width: 1),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 7.0, left: 7.0, top: 7.0, bottom: 7.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Annually',
                                style: MasterStyle.whiteStyleOpacityWithRegular,
                              ),
                              WidgetSpan(
                                  child: Icon(
                                Icons.keyboard_arrow_down,
                                color: MasterStyle.whiteColor,
                              ))
                            ])),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Other Income',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(.1),
                                    width: 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      child: Text(
                                        '\$',
                                        style: MasterStyle.whiteTextStyleNormal,
                                      )),
                                ),
                                TextSpan(
                                    text: '0',
                                    style: MasterStyle.whiteTextStyleNormal)
                              ]),
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(.1),
                                  width: 1),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 8.0, bottom: 8.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Annually',
                                style: MasterStyle.whiteStyleOpacityWithRegular,
                              ),
                              WidgetSpan(
                                  child: Icon(
                                Icons.keyboard_arrow_down,
                                color: MasterStyle.whiteColor,
                              ))
                            ])),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Rental Income',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(.1),
                                    width: 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      child: Text(
                                        '\$',
                                        style: MasterStyle.whiteTextStyleNormal,
                                      )),
                                ),
                                TextSpan(
                                    text: '0',
                                    style: MasterStyle.whiteTextStyleNormal)
                              ]),
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(.1),
                                  width: 1),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 8.0, bottom: 8.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Annually',
                                style: MasterStyle.whiteStyleOpacityWithRegular,
                              ),
                              WidgetSpan(
                                  child: Icon(
                                Icons.keyboard_arrow_down,
                                color: MasterStyle.whiteColor,
                              ))
                            ])),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'What are your monthly expenses?',
                    style: MasterStyle.buttonWhiteTextStyleBold,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Living Expense',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '2000',
                      hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color: MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 0, bottom: 0, right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Credit Card Limit',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '0',
                      hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color: MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 0, bottom: 0, right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'New Loan',
                    style: MasterStyle.buttonWhiteTextStyleBold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Other Loan Repayment',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('Rate of Interest',
                      style: MasterStyle.whiteStyleOpacityWithRegular),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '2.91%',
                      hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 0, bottom: 0, right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Loan Term (yrs.)',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    
                    decoration: BoxDecoration(      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: HexColor('#6D7B95'),
        width: 0.2,),),
                    child: Row(
                      children: [
                        Container(    color: MasterStyle.whiteColor.withOpacity(0.1),
                        child: InkWell(
                          onTap: (){
                         if(loanTerms ==0){}
                            else{
                            setState(() {
                              loanTerms--;
                            });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                            '-',style: MasterStyle.whiteStyleOpacityWithRegular,
                          ),),
                        ),),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text('${loanTerms}',style: MasterStyle.whiteStyleRegularNormal,),
                        )),
                        Container(    color: MasterStyle.whiteColor.withOpacity(0.1),
                        child: InkWell(
                          onTap: (){
                            
                        
                            setState(() {
                              loanTerms++;
                            });
                            
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                            '+',style: MasterStyle.whiteStyleOpacityWithRegular,
                          ),),
                        ),),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                ;
                              }
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              'Calculate',
                              style: TextStyle(color: MasterStyle.whiteColor),
                            ),
                            color: MasterStyle.secondaryThemeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
