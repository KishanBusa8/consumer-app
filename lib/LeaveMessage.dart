
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class LeaveMessage extends StatefulWidget {
  @override
  _LeaveMessageState createState() => _LeaveMessageState();
}
class _LeaveMessageState extends State<LeaveMessage> {
  final  _formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.close,size:50, color: Colors.orange,),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                 child: Text(
                    'Leave us a message',
                    style: TextStyle(color: Color(0XFFff9b15),fontSize:30,
                      fontWeight: FontWeight.bold,
                        height: 2.0,
                    )
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Your name(optional)',
                        style: TextStyle(color:Color(0xFF000000),fontFamily:'Lato',
                          fontWeight: FontWeight.bold, fontSize: 17,
                            height: 2.0,
                        ),
                        ),
                    ),

                  Container(
                      child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "sheldoncooper89@gmail.com",
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),fontFamily:'Lato',
                                fontWeight: FontWeight.normal, fontSize: 15,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            String? pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = new RegExp(pattern);
                            if (value!.length == 0) {
                              return "Name is Required";
                            } else if (!regExp.hasMatch(value)) {
                              return "enter a valid Name";
                            } else {
                              return null;
                            }
                          }
                      ),

                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'E-mail Address',
                        style: TextStyle(color: Color(0xFF000000),fontSize:17,
                          fontWeight: FontWeight.bold,height: 2.0,
                        )
                    ),
                  ),

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(

                          decoration: InputDecoration(
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            String? pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = new RegExp(pattern);
                            if (value!.length == 0) {
                              return "email is Required";
                            } else if (!regExp.hasMatch(value)) {
                              return "enter a valid email";
                            } else {
                              return null;
                            }
                          }
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'How can we help you?',
                        style: TextStyle(color: Color(0xFF000000),fontSize:17,
                          fontWeight: FontWeight.bold,
                            height: 2.0,
                        )

                    ),
                  ),

                  Container(
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(90.20),


                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "please enter a message";
                            }
                            return null;
                          }
                      ),
                  ),


                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'How can we help you?',
                        style: TextStyle(color: Color(0xFF000000),fontSize:17,
                          fontWeight: FontWeight.bold,
                          height: 2.0,
                        )

                    ),
                  ),

                  Container(
                      child: DottedBorder(
                        strokeWidth: 1,
                        dashPattern: [10,10],
                        color: Colors.grey,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.attach_file_sharp) ,
                                 hintText: 'Add upto 5 files',
                                hintStyle: TextStyle(
                                  color: Color(0xFF707070),fontFamily:'Lato',
                                  fontWeight: FontWeight.normal, fontSize: 15,
                                  height: 2.0,
                                ),),),),),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            padding: EdgeInsets.symmetric(horizontal: 100, vertical:20),
                        ),
                          child: Text('Send ',style: new TextStyle(fontSize: 15.0, color: Colors.white),),


                        onPressed:(){
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}



