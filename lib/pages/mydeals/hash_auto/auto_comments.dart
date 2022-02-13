// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/myloans/businessloan/business_loan_personal_details.dart';
import 'package:hashching/pages/myloans/loans_widget_expansion.dart/loan_components.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashAutoComments extends StatefulWidget {
   HashAutoComments({ Key? key,required this.hashCommentsController ,required this.checkbox}) : super(key: key);
  TextEditingController hashCommentsController;
  Checkbox checkbox;

  @override
  _HashAutoCommentsState createState() => _HashAutoCommentsState();
}

class _HashAutoCommentsState extends State<HashAutoComments> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
                 Container(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Text('About the vehicle ',style: MasterStyle.whiteTextStyleNormal,),
      ),
        SimplifiedWidgets.containerBox(
          radius: 10,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          color: MasterStyle.whiteColor.withOpacity(0.1),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWithStyle('Comments :'),
    
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: MasterStyle.whiteTextInputStyle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.trim().isEmpty ) {
                      return 'Please enter valid Comments';
                    }
                    return null;
                  },
                  maxLines: 5,
                  controller: widget.hashCommentsController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText:'Type your message',
                    hintStyle: MasterStyle.whiteHintStyle,
                    enabledBorder: SimplifiedWidgets.outlineInputBorder,
                    border: SimplifiedWidgets.outlineInputBorder,
                    focusedBorder: SimplifiedWidgets.outlineInputBorder,
                  ),
                ),
              ),

             Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Theme(
                      data:
                          ThemeData(unselectedWidgetColor: HexColor('#6D7B95')),
                      child: widget.checkbox),
                  Flexible(
                    child: RichText(
                        text: TextSpan(children: [
                      textSpanNormal(text: 'I understand and accept the '),
                      PrivacyPolicy(text: 'privacy policy ',context:context),
                      textSpanNormal(text: 'and '),
                      TermsAndConditions(text: 'terms of use.',context:context)
                    ])),
                  )
                ],
              ),
            )
         


            ],
          ),
        ),
      ],
    );
  
  }
}