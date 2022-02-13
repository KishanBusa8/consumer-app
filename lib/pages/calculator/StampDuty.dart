
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
class StampDuty extends StatefulWidget {
  @override
  _StampDutyState createState() => _StampDutyState();
}
class _StampDutyState extends State<StampDuty> {
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
        title: Text(" Stamp Duty Calculator",
            style: MasterStyle.appBarTitleStyle,
        ),
        leading:IconButton(
            icon: Icon(Icons.arrow_back_ios,size:20,color:MasterStyle.secondaryThemeColor,),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[

        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stamp duty adds significantly to the cost of buying a property. Our Stamp Duty Calculator factors in stamp duty, mortgage registration fees and transfer fees based on the the state or territory the property is in. '
                        '\n\nUse the calculator below to estimate your costs.',
                    style: MasterStyle.whiteStyleOpacityWithRegular, textAlign: TextAlign.start,
                    ),
                  SizedBox(
                    height:16,
                  ),
                  Text(
                  'Property Use',
                  style:  MasterStyle.whiteStyleRegularNormal,textAlign: TextAlign.start,
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("To live in",style: MasterStyle.whiteStyleOpacityWithRegular ,) ,style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) => MasterStyle.secondaryThemeColor),
                                shape:MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                                ))
                            ))),),

                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("To invest",style: MasterStyle.whiteStyleOpacityWithRegular) ,style: ButtonStyle(
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
                    'First Home Buyer',
                    style:  MasterStyle.whiteStyleRegularNormal,textAlign: TextAlign.start,
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("Yes",style: MasterStyle.whiteStyleOpacityWithRegular,) ,style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) => MasterStyle.secondaryThemeColor),
                                shape:MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                                ))
                            ))),),

                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("No",style: MasterStyle.whiteStyleOpacityWithRegular,) ,style: ButtonStyle(
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
                    'Is This A New Or Existing Property',
                    style:  MasterStyle.whiteStyleRegularNormal,textAlign: TextAlign.start,
                  ),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("New",style: MasterStyle.whiteStyleOpacityWithRegular,) ,style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) => MasterStyle.secondaryThemeColor),
                      shape:MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ))
                    ))),),

                        Expanded(child:ButtonTheme(
                            child: ElevatedButton( onPressed: () {},child: Text("Existing",style: MasterStyle.whiteStyleOpacityWithRegular,) ,style: ButtonStyle(
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
                    'Property Price',
                    style: MasterStyle.whiteStyleRegularNormal, textAlign: TextAlign.start,),

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
                      contentPadding: EdgeInsets.only(left:12,top:0,bottom:0,right: 16),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'State/Territory',
                    style:  MasterStyle.whiteStyleRegularNormal,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                      hintText: 'ACT',hintStyle: MasterStyle.whiteStyleOpacityWithRegular,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Loan',
                        style:  MasterStyle.buttonWhiteTextStyleBold,
                      ),
                      Text(
                        '+ Add item', style: MasterStyle.secondarySmallBoldTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height:8,
                  ),
                  Text(
                    'Item Description',
                    style:  MasterStyle.whiteStyleRegularNormal,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder:formOutlineInputBorder,
                      enabledBorder: formOutlineInputBorder,
                        isDense: true,
                    ),
                  ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Cost',
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