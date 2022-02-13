
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';


class ComparisonRateCal extends StatefulWidget {
  @override
  _ComparisonRateCalState createState() => _ComparisonRateCalState();
}

class _ComparisonRateCalState extends State<ComparisonRateCal> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder formOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: HexColor('#6D7B95'),
          width: 0.1,
        ));
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Text("Comparison Rate Calculator",
            style: TextStyle(
              color: MasterStyle.secondaryThemeColor,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
              color: MasterStyle.secondaryThemeColor),
            onPressed: () {
              Navigator.pop(context);
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
                    'The comparison rate is the interest rate of your home loan when accounting for all fees and charges. The comparison rate helps you have a better understanding of the true cost of your loan, and all lenders are required to disclose it by law.',
                    style: MasterStyle.whiteStyleOpacityWithRegular,
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8.0),
                    child: Text(
                      'Loan term',
                      style: MasterStyle.whiteStyleRegularNormal,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '30 years',
                      hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: MasterStyle.whiteColor,
                          ),
                          onPressed: () {}),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 0, bottom: 0, right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Loan amount',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '350,000',
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
                    'Fixed rate',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '3.80',
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
                    'Fixed period(months)',
                    style: MasterStyle.whiteStyleRegularNormal,
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
                              "\m",
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
                    'Ongoing rate',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '3.80',
                      hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color: MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\%",
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
                    'Upfront fees',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '500',
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
                    'Fees',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: formOutlineInputBorder,
                            enabledBorder: formOutlineInputBorder,
                            hintText: '35',
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color:MasterStyle.whiteColor.withOpacity(0.1), width:1,),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Text('Monthly',style:MasterStyle.whiteStyleOpacityWithRegular,))),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Discharge fee',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '300',
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
