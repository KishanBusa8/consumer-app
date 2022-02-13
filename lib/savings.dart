
import 'package:flutter/material.dart';

class Savings1 extends StatefulWidget {
  @override
  _Savings1State createState() => _Savings1State();
}
class _Savings1State extends State<Savings1> {
  @override

  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.topLeft,
            child:Text("Savings",
              style: TextStyle(color: Color(0XFFff9b15),fontSize:20,
                fontWeight: FontWeight.normal,fontFamily: 'Lato', ))),
          leading:Icon(Icons.arrow_back_ios,size:30, color: Colors.orange,),
          actions: <Widget>[
          ],
        ),

        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 350.0, height: 200.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0) ),
                        child:Center(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Buying or selling car made easy with hashauto',
                                      style: TextStyle(color:Color(0xFF1F3751),fontSize:20, fontWeight: FontWeight.bold,),),),
                                  Padding(
                                    padding: const EdgeInsets.only(top:10.0) ),
                                 Align(
                                      alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Let our professional team \n' 'take care of the entire \n' 'process.',
                                      style: TextStyle(color: Color(0xFF000000)),),),
                                  Align(
                                   alignment: Alignment.bottomRight,
                                     child: new Image.asset( 'VehicleSalePana2.png',
                                      width: 165, height: 75,),),],),),),),

                    Padding(
                      padding: const EdgeInsets.only(top:30.0,left:30.0),
                      child:  Align(
                        alignment: Alignment.bottomLeft,
                      child: Text(
                        "Services",
                        style: TextStyle(
                          color: Color(0xFF1F3751), fontSize: 17.0,
                          fontWeight: FontWeight.normal, fontFamily: 'Lato',),
                        textAlign: TextAlign.start,),),),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                      child:Center(
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: 250.0,
                              height: 100.0,
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
                                          Text(
                                            "12 Items",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w100, fontFamily: 'Lato',),),],),)),),),
                            SizedBox(
                              width: 250.0,
                              height: 100.0,
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
                                          Text(
                                            "12 Items",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w100, fontFamily: 'Lato', ),),],),)),),),
                            SizedBox(
                              width:250.0,
                              height: 100.0,
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
                                          Text(
                                            "Settings",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,fontFamily: 'Lato',
                                                fontSize: 20.0 ),),
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