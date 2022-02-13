import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

String label = 'label';
String hint = 'hint';


List<String> listOfLabel = ['Built year :', 'Equipment make :', 'Equipment model :'];
List<String> listOfHintText = [
  'Select year',
  'Ex',
  'Ex'
];
List listOfAdditionalDetails = [
  {label: 'Industry type :', hint: '\$50,000'},
  {label: 'Price of equipment :', hint: 'E.g 2000 or Richmond'}
];
List icons = [
  Icons.date_range_outlined,
  Icons.timer

];

Widget financeEnquireyDetails() {
  return ListView(
    shrinkWrap: true,
    children: [
     
      SimplifiedWidgets.containerBox(
        radius: 10,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
        color: MasterStyle.whiteColor.withOpacity(0.1),
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            listOfLabel[index],
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              hintText: listOfHintText[index],
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder: SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder: SimplifiedWidgets.outlineInputBorder,
                            ),
                          ),
                        ),
                      ]);
                }),
            // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //   SimplifiedWidgets.elevatedButton(
            //       text: 'Send code',
            //       textStyle: MasterStyle.whiteStyleRegularNormal,
            //       color: MasterStyle.appSecondaryColor,
            //       borderRadius: BorderRadius.all(Radius.circular(5)),
            //       onPresed: () {})
            // ])
          ],
        ),
      ),
    ],
  );
}

Widget financeLoanAdditionalDetails() {
  return ListView(
    shrinkWrap: true,
    children: [
      SimplifiedWidgets.containerBox(
        radius: 10,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
        color: MasterStyle.whiteColor.withOpacity(0.1),
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            listOfAdditionalDetails[index][label],
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              hintText: listOfAdditionalDetails[index][hint],
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder: SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder: SimplifiedWidgets.outlineInputBorder,
                            ),
                          ),
                        ),
                      ]);
                }),
          ],
        ),
      ),
    ],
  );
}

Widget financeLoanContactDetails(Checkbox checkBox) {
  return ListView(
    shrinkWrap: true,
    children: [
      SimplifiedWidgets.containerBox(
        radius: 10,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 24),
        color: MasterStyle.whiteColor.withOpacity(0.1),
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                             listOfAdditionalDetails[index][label],
                            style: MasterStyle.secondarySemiBoldTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TextFormField(
                            
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              hintText:'Ex',
                              hintStyle: MasterStyle.whiteHintStyle,
                              enabledBorder: SimplifiedWidgets.outlineInputBorder,
                              border: SimplifiedWidgets.outlineInputBorder,
                              focusedBorder: SimplifiedWidgets.outlineInputBorder,
                            ),
                          ),
                        ),
                      ]);
                }),
          ],
        ),
      ),
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Theme(data: ThemeData(unselectedWidgetColor:HexColor('#6D7B95')),
         child: checkBox),
        Flexible(
          child: RichText(text: TextSpan(
            children: [
            
              textSpanNormal(
                text: 'I understand and accept the '
              ),
              textSpaHighLigth(text: 'privacy policy '),
              textSpanNormal(text: 'and '),
              textSpaHighLigth(text: 'terms of use.')

            ]
          )
          ),
        )
      ],),
    )
    
    ],
  );
}


TextSpan textSpanNormal({required String text}){
 return TextSpan(text:text,style: MasterStyle.whiteTextStyleNormal);
}
TextSpan textSpaHighLigth({required String text}){
 return TextSpan(text:text,style: MasterStyle.primaryContent);
}

