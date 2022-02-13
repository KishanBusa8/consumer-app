import 'package:flutter/material.dart';

class NotificationLocal extends StatelessWidget {
   NotificationLocal({ Key? key ,required this.floatingPanelWidget}) : super(key: key);
Widget floatingPanelWidget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
    
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No new notifications"),
            ],
          ),
          
        ),
        this.floatingPanelWidget
      ],
    );
  }
}