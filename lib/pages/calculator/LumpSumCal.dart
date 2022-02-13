// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class LumpSumCal extends StatefulWidget {
  @override
  _LumpSumCalState createState() => _LumpSumCalState();
}

class _LumpSumCalState extends State<LumpSumCal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _loanTermController = TextEditingController();
  TextEditingController _repaymentFrequancyController = TextEditingController();
  TextEditingController _lumpSumYearController = TextEditingController();
  List<String> ListOfLoanTerms = [];
  List<String> ListOfLumpSumYear = [];
  List<String> ListOfRepaymentFrequancy = ['Monthly','Fourthnightly','Weekly'];
  fetchInitialData() {
  

    ListOfLoanTerms = listGenerate(51);
    ListOfLumpSumYear = listGenerate(21);
    ListOfLumpSumYear.removeAt(0);
    
    ListOfLoanTerms.removeAt(0);
    _loanTermController.text = ListOfLoanTerms[1];
    _repaymentFrequancyController.text =ListOfRepaymentFrequancy[0];
    _lumpSumYearController.text = ListOfLumpSumYear[0];
  }
listGenerate(indexLenght){
var genrateList = List.generate(
        indexLenght,
        (index) => index != 1
            ? index.toString() + ' Years'
            : index.toString() + ' year');
            return genrateList;
}
  @override
  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Widget build(BuildContext context) {
    OutlineInputBorder formOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: HexColor('#6D7B95'), width: 0.2));
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(" Lump Sum Calculator",
            style: TextStyle(
              color: MasterStyle.secondaryThemeColor,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            )),
            titleSpacing: 0,
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
                    'How much can you save by paying a lump sum off of your mortgage? Estimate how much interest you could save and how much sooner you could pay off your loan with the lump sum calculator below.',
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: HexColor('#6D7B95'), width: 0.2),
                    ),
                    padding:
                        EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 2),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _loanTermController.text,
                        icon:  Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: MasterStyle.whiteColor,
                            ),
                        elevation: 16,
                        style: MasterStyle.commonTextStyle,
                        onChanged: (String? newValue) {
                          setState(() {
                            _loanTermController.text = newValue!;
                          });
                        },
                        dropdownColor: MasterStyle.backgroundColor,
                        items: ListOfLoanTerms.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                child: Text(
                              value,
                              style: MasterStyle.whiteStyleRegularNormal,
                            )),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     focusedBorder: formOutlineInputBorder,
                  //     enabledBorder: formOutlineInputBorder,
                  //     hintText: '30 years',
                  //     hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                  //     suffixIcon: IconButton(
                  //         icon: Icon(
                  //           Icons.keyboard_arrow_down_sharp,
                  //           color: MasterStyle.whiteColor,
                  //         ),
                  //         onPressed: () {}),
                  //     isDense: true,
                  //     contentPadding: EdgeInsets.only(
                  //         left: 12, top: 0, bottom: 0, right: 16),
                  //   ),
                  // ),
                
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
                    style:  MasterStyle.whiteStyleOpacityWithRegular,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '350,000',
                      hintStyle: MasterStyle.hintOpacityWithRegular,
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
                    'Interest rate',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    style:  MasterStyle.whiteStyleOpacityWithRegular,
                    keyboardType: TextInputType.number,
                    
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '3.80',
                      hintStyle: MasterStyle.hintOpacityWithRegular,
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
                    'Repayment frequency',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                     Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: HexColor('#6D7B95'), width: 0.2),
                    ),
                    padding:
                        EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 2),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _repaymentFrequancyController.text,
                        icon:  Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: MasterStyle.whiteColor,
                            ),
                        elevation: 16,
                        style: MasterStyle.commonTextStyle,
                        onChanged: (String? newValue) {
                          setState(() {
                            _repaymentFrequancyController.text = newValue!;
                          });
                        },
                        dropdownColor: MasterStyle.backgroundColor,
                        items: ListOfRepaymentFrequancy.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                child: Text(
                              value,
                              style: MasterStyle.whiteStyleRegularNormal,
                            )),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
               
                  
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     focusedBorder: formOutlineInputBorder,
                  //     enabledBorder: formOutlineInputBorder,
                  //     hintText: 'Monthly',
                  //     hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                  //     suffixIcon: IconButton(
                  //         icon: Icon(
                  //           Icons.keyboard_arrow_down_sharp,
                  //           color: MasterStyle.whiteColor,
                  //         ),
                  //         onPressed: () {}),
                  //     isDense: true,
                  //     contentPadding: EdgeInsets.only(
                  //         left: 12, top: 0, bottom: 0, right: 16),
                  //   ),
                  // ),
                
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Once-off lump sum repayment',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
               
                  TextFormField(
                      style:  MasterStyle.whiteStyleOpacityWithRegular,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '5000',
                      hintStyle: MasterStyle.hintOpacityWithRegular,
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
                    'Lump sum made at year',
                    style: MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                   Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: HexColor('#6D7B95'), width: 0.2),
                    ),
                    padding:
                        EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 2),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _lumpSumYearController.text,
                        icon:  Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: MasterStyle.whiteColor,
                            ),
                        elevation: 16,
                        style: MasterStyle.commonTextStyle,
                        onChanged: (String? newValue) {
                          setState(() {
                            _lumpSumYearController.text = newValue!;
                          });
                        },
                        dropdownColor: MasterStyle.backgroundColor,
                        items: ListOfLumpSumYear.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                child: Text(
                              value,
                              style: MasterStyle.whiteStyleRegularNormal,
                            )),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
               
               
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     focusedBorder: formOutlineInputBorder,
                  //     enabledBorder: formOutlineInputBorder,
                  //     hintText: '5 years',
                  //     hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                  //     suffixIcon: IconButton(
                  //         icon: Icon(
                  //           Icons.keyboard_arrow_down_sharp,
                  //           color: MasterStyle.whiteColor,
                  //         ),
                  //         onPressed: () {}),
                  //     isDense: true,
                  //     contentPadding: EdgeInsets.only(
                  //         left: 12, top: 0, bottom: 0, right: 16),
                  //   ),
                  // ),
                 
                 
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
                  // lumpCalResult()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  lumpCalResult(){
  return  ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.pink,
        ),
      );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {


    Path path = Path()
    ..lineTo(0, size.height)
    ..relativeConicTo(100, 400,222,33,22)
    ..lineTo(size.width, size.height) 
    ..close();
  
  return path;
  }
  

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
