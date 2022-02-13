import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/customshape.dart';
import 'package:hashching/models/chatmessage.dart';
import 'package:hashching/styles/masterstyle.dart';


class SendMessageScreen extends StatefulWidget {
  ChatMessageModel message;

   SendMessageScreen({ Key? key, required this.message, }) : super(key: key);

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  Widget messageTextGroup (message){ return Flexible(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MasterStyle.secondaryThemeColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        CustomPaint(painter: CustomShape(MasterStyle.secondaryThemeColor)),
      ],
    ));
  }


  Widget messageImageGroup (image){ return Flexible(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>chatImageFullScreenView(image: image)));
            },
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: MasterStyle.secondaryThemeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Image.file(image),
            ),
          ),
        ),
        CustomPaint(painter: CustomShape(MasterStyle.secondaryThemeColor)),
      ],
    ));
  }
   
  
  @override
  Widget build(BuildContext context) {
    print( widget.message);
    return  Padding(
  padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      SizedBox(height: 30),
      widget.message.messageType !='text'?messageImageGroup( widget.message.image):
      messageTextGroup(widget.message.message),
    ],
  ),
);
  }
}



class chatImageFullScreenView extends StatelessWidget {
   chatImageFullScreenView({Key? key,required this.image}) : super(key: key);
final File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      body: Container(width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:Image.file(image),
      ),

    );
  }
}