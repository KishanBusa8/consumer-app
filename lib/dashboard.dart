import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';

void main() => runApp(
    MaterialApp(
        home:Dashboard()
    )
);

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(" Your loan",
              style: TextStyle(color: Color(0XFFff9b15),fontSize:20,
                fontWeight: FontWeight.normal,fontFamily: 'Lato',)),
          leading:Icon(Icons.arrow_back_ios,size:30, color: Colors.orange,),
          actions: <Widget>[

          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: NewColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Home Loans",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal, fontFamily: 'Lato',),
                    textAlign: TextAlign.start,),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                    child:Center(
                    child: Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      children: <Widget>[
                        SizedBox(
                          width:1000.0, height: 150.0,
                          child: Card(
                            margin: EdgeInsets. only(right: 5.0),
                            shadowColor: Colors.grey,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),

                            child: Row(
                                    children: <Widget>[
                            Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                     child: Text(
                                            "Lender name                     Amiya potts\n"
                                            "Amount                             500\n"
                                            "Submission date                    22Aug 2021 \n"
                                            "\nExpected settlement"
                                            "\nInterest rate"
                                            "\nStatus",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal,
                                          fontSize: 15.0, fontFamily: 'Lato', height: 1.5 ,),),),
                                     Align(
                                       alignment: Alignment.bottomRight,
                                       child: Text(
                                             "\n 22 Aug, 2021"
                                             "\n 12%",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal,
                                        fontSize: 15.0, fontFamily: 'Lato', height: 1.5 ,)
                                      ),),

                                    ],),),),
                        SizedBox(
                          width: 1000.0,
                          height: 150.0,
                          child: Card(
                            shadowColor: Colors.grey,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0) ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Notes",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20.0, fontFamily: 'Lato',),),
                                      SizedBox(
                                        height: 5.0,),
                                      Text(
                                        "12 Items",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w100, fontFamily: 'Lato',
                                        ),)
                                    ],),)),),),
                        SizedBox(
                          width:1000.0,
                          height: 150.0,
                          child: Card(
                            elevation: 3.0,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0) ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,),
                                      Text(
                                        "Settings",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,fontFamily: 'Lato',
                                            fontSize: 20.0 ),),
                                      SizedBox(
                                        height: 5.0,),
                                      Text(
                                        "6 Items",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w100, fontFamily: 'Lato',
                                        ),)
                                    ],),)
                            ),),),
                      ],),),),
              ],))));
  }
}