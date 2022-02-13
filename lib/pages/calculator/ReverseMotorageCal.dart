
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';


class ReverseMotorageCal extends StatefulWidget {
  @override
  _ReverseMotorageCalState createState() => _ReverseMotorageCalState();
}
class _ReverseMotorageCalState extends State<ReverseMotorageCal> {
  final  _formKey = GlobalKey<FormState>();
  bool isLow = false;
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
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Reverse Mortgage Calculator",
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
                    'The comparison rate is the interest rate of your home loan when accounting for all fees and charges. The comparison rate helps you have a better understanding of the true cost of your loan, and all lenders are required to disclose it by law.',
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
                      hintText: '30 years',hintStyle:MasterStyle.whiteStyleOpacityWithRegular,
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
                    'Home value',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '400,000',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\$",style: MasterStyle.whiteStyleOpacityWithRegular,),
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
                    'Lump sum',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '100,000',hintStyle:MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\$",style: MasterStyle.whiteStyleOpacityWithRegular),
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
                    'Monthly payments',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '500',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\$",style: MasterStyle.whiteStyleOpacityWithRegular,),
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
                    'Monthly fees',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '15',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                    'Upfront cost',
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
                            Text("\%",style: MasterStyle.whiteStyleOpacityWithRegular,),
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
                    'Interest',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: '7',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
                      prefixIcon: Container(
                        color:MasterStyle.whiteColor.withOpacity(0.1),
                        padding: EdgeInsets.all( 8),
                        margin: EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("\%",style: MasterStyle.whiteStyleOpacityWithRegular),
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
                    'Assumed increase in home value',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(value: 1, groupValue: 'null',


                              fillColor: MaterialStateProperty.resolveWith((states) => MasterStyle.whiteColor),
                              activeColor: MasterStyle.whiteColor.withOpacity(0.1),toggleable: isLow, onChanged: (Object? value) {
                  setState(() {
                    isLow = !isLow;
                  });
                            },),
                          Text('Low',style: MasterStyle.whiteStyleOpacityWithRegular,)
                        ],
                      ),
                      Row(
                        children: [
                          Radio(fillColor: MaterialStateProperty.resolveWith((states) => MasterStyle.whiteColor),value: 1, groupValue: 'null', activeColor: MasterStyle.whiteColor.withOpacity(0.1),toggleable: true,onChanged: (index) {}),
                          Text('Medium',style: MasterStyle.whiteStyleOpacityWithRegular,)
                        ],
                      ),
                      Row(
                        children: [
                          Radio(fillColor: MaterialStateProperty.resolveWith((states) => MasterStyle.whiteColor),value: 1, groupValue: 'null', activeColor: MasterStyle.whiteColor.withOpacity(0.1),toggleable: true,onChanged: (index) {}),
                          Text('High',style: MasterStyle.whiteStyleOpacityWithRegular,)
                        ],
                      ),
                      Row(
                        children: [
                          Radio(fillColor: MaterialStateProperty.resolveWith((states) => MasterStyle.whiteColor),value: 1, groupValue: 'null', activeColor: MasterStyle.whiteColor.withOpacity(0.1),toggleable: true,onChanged: (index) {}),
                          Text('Set my own',style: MasterStyle.whiteStyleOpacityWithRegular,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height:16,
                  ),
                  Text(
                    'Increase',
                    style: MasterStyle.whiteStyleRegularNormal,),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:MasterStyle.whiteColor.withOpacity(0.1)),
                      ),
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