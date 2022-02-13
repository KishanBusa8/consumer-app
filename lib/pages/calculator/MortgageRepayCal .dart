
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';


class MortgageRepayCal extends StatefulWidget {
  @override
  _MortgageRepayCalState createState() => _MortgageRepayCalState();
}
class _MortgageRepayCalState extends State<MortgageRepayCal> {
  final  _formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context){
    OutlineInputBorder formOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: HexColor('#6D7B95'),
          width: 0.1,
        )
    );
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Mortgage Repayment Calculator",
            style: TextStyle(color: MasterStyle.secondaryThemeColor,fontSize:17,
              fontWeight: FontWeight.normal,
            )),
        leading:IconButton(
            icon: Icon(Icons.arrow_back_ios, color:MasterStyle.secondaryThemeColor),
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
                    'Estimate your potential mortgage repayments and savings based on your loan amount, term, fees, and interest rate. Work out what your minimum weekly, fortnightly or monthly repayments would be on your home loan below.',
                    style: MasterStyle.whiteStyleOpacityWithRegular, textAlign: TextAlign.start,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:20,bottom:8.0),
                    child: Text(
                      'Loan Amount',
                      style:  MasterStyle.whiteStyleRegularNormal,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '500,000',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                      contentPadding: EdgeInsets.only(left: 12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Loan Term (yrs.)',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '30', hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\-",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      suffixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                              },
                              child: const Text(
                                "+",
                              ),
                            ),
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
                    'Repayment Frequency',
                    style:  MasterStyle.whiteStyleRegularNormal,textAlign: TextAlign.start,
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("Monthly",style: MasterStyle.whiteStyleOpacityWithRegular ,) ,style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) => MasterStyle.secondaryThemeColor),
                                shape:MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                                ))
                            ))),),

                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("Fourthnightly",style: MasterStyle.whiteStyleOpacityWithRegular) ,style: ButtonStyle(
                                elevation: MaterialStateProperty.resolveWith((states) => 0,
                                ),
                                backgroundColor: MaterialStateProperty.resolveWith((states) => MasterStyle.backgroundColor,),

                                shape:MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                    side:BorderSide(color: MasterStyle.whiteColor.withOpacity(.1),width: 1),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))
                                ))
                            ))),),
                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("Weekly",style: MasterStyle.whiteStyleOpacityWithRegular) ,style: ButtonStyle(
                                elevation: MaterialStateProperty.resolveWith((states) => 0,
                                ),
                                backgroundColor: MaterialStateProperty.resolveWith((states) => MasterStyle.backgroundColor,),

                                shape:MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                    side:BorderSide(color: MasterStyle.whiteColor.withOpacity(.1),width: 1),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))
                                ))
                            ))),),
                      ],),),
                  Text(
                    'Current Loan',
                    style:  MasterStyle.buttonWhiteTextStyleBold,
                  ),
                  SizedBox(
                    height:7,
                  ),
                  Text(
                    'Rate of Interest',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '4.79%',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      contentPadding: EdgeInsets.only(left:12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Upfront Fee',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '0',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                    height:16,
                  ),
                  Text(
                    'Monthly Fee',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '0',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                    height:16,
                  ),
                  Text(
                    'New Loan',
                    style:  MasterStyle.buttonWhiteTextStyleBold,
                  ),
                  SizedBox(
                    height:7,
                  ),
                  Text(
                    'Rate of Interest',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '2.91%',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      contentPadding: EdgeInsets.only(left:12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height:16,
                  ),
                  Text(
                    '',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '0',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                    height:16,
                  ),
                  Text(
                    'Monthly Fee',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '0',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                    height: 24,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RaisedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                               
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