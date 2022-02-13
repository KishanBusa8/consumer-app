
import 'package:flutter/material.dart';
import 'package:hashching/pages/chatsupport/chatsupport.dart';
import 'package:hashching/pages/leave_page/leave_page.dart';
import 'package:hashching/styles/styles.dart';


class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      
      child: GestureDetector(
        onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatWithSupport(),
                   
                    ),
                  );
                },
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0,bottom: 43,left: 16,top: 16),
          child: Text(
            'Chat with support',
            style: TextFonts.primaryText,
          ),
        ),
      ),
      alignment: Alignment.bottomRight,
    );
  }
}