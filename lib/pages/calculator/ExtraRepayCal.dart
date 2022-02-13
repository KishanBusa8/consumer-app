
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';


class ExtraRepayCal extends StatefulWidget {
  @override
  _ExtraRepayCalState createState() => _ExtraRepayCalState();
}
class _ExtraRepayCalState extends State<ExtraRepayCal> {
  final  _formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context){
    OutlineInputBorder formOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
            color: HexColor('#6D7B95'),
            width: 0.2,
        )
    );
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(" Extra Repayment Calculator",
            style: TextStyle(color: MasterStyle.secondaryThemeColor,fontSize:17,
              fontWeight: FontWeight.normal,
            )),
        leading:IconButton(
            icon: Icon(Icons.arrow_back_ios,size:30, color:MasterStyle.secondaryThemeColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
        ],
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
                    'Making extra repayments toward your mortgage can cut years off the term of the loan and even save you money on interest charges. Use the calculator below to estimate just how much you could save.',
                    style: MasterStyle.whiteStyleOpacityWithRegular, textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20,bottom:8.0),
                    child: Text(
                      'Loan term',
                      style:  MasterStyle.whiteStyleRegularNormal,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '30 years',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down_sharp,
                            color: MasterStyle.whiteColor,),
                          onPressed: () {}),
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Loan amount',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '350,000',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\$",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(left:12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Interest rate',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '3.80',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\%",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(left:12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Repayment frequency',
                    style:  MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height:8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '30 years',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down_sharp,
                            color: MasterStyle.whiteColor,),
                          onPressed: () {}),
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Extra monthly repayments',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '3.80',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\%",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(left:12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height:16,
                  ),
                  Text(
                    'Start extra repayments at',
                    style:  MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '30 years',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down_sharp,
                            color: MasterStyle.whiteColor,),
                          onPressed: () {}),
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RaisedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                             
                              }
                            },
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical:20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Text('Calculate',
                              style: TextStyle(color: MasterStyle.whiteColor),),
                            color: MasterStyle.secondaryThemeColor,),),
                      ),
                    ],
                  ),],),),),),),);}}