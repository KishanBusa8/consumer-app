// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';

class CarLoanEnquirey extends StatefulWidget {
  CarLoanEnquirey(
      {Key? key,
      required this.isNewType,
      required this.isUsedType,
      required this.listOfPages,
      required this.currentPageNotifier,
      required this.isDealershipNo,
      required this.isDealershipYes,
      required this.pageController,
      required this.buildLinearProgressIndicator})
      : super(key: key);
  bool isNewType;
  bool isUsedType;
  List listOfPages;
  bool isDealershipYes;
  bool isDealershipNo;
  ValueNotifier<int> currentPageNotifier;
  PageController pageController;
 var  buildLinearProgressIndicator;

  @override
  _CarLoanEnquireyState createState() => _CarLoanEnquireyState();
}

class _CarLoanEnquireyState extends State<CarLoanEnquirey> {


 
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
             NewColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isNewType || widget.isUsedType
                      ? widget.buildLinearProgressIndicator()
                      : SizedBox(),
                  Expanded(
                    child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: widget.pageController,
                      itemCount: widget.listOfPages.length,
                      onPageChanged: (int index) {
                        setState(() {
                         widget.currentPageNotifier.value = index;
                        });

                        print('index :$index');
                        print(
                            ' _currentPageNotifier.value  :${widget.currentPageNotifier.value}');
                      },
                      itemBuilder: (_, index) {
                        return widget.listOfPages[index];
                      },
                    ),
                  ),
                ],
              )
           );
  }



}
