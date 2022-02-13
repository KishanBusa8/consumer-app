import 'package:flutter/material.dart';
import 'package:hashching/Utilities/customshape.dart';
import 'dart:math' as math;

import 'package:hashching/styles/masterstyle.dart';


class RecieverMessageScreen extends StatefulWidget {
  final String message;

  const RecieverMessageScreen({ Key? key, required this.message, }) : super(key: key);

  @override
  _RecieverMessageScreenState createState() => _RecieverMessageScreenState();
}

class _RecieverMessageScreenState extends State<RecieverMessageScreen> {
 Widget  messageTextGroup (message){return Flexible(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: CustomShape(Colors.white),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MasterStyle.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {

    return  Padding(
  padding: EdgeInsets.only(right: 28.0, left: 20, top: 15, bottom: 5),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      SizedBox(height: 30),
      messageTextGroup(widget.message),
    ],
  ),
);
  }
}