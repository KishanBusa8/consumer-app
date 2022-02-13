
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/pages/leave_page/leave_page_components/leave_page_components.dart';
import 'package:hashching/styles/styles.dart';

class LeavePage extends StatelessWidget {
  LeavePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 31,
              color: IconColors.ternary,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NewColumnMain(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Leave us a message',
                style: BoldHeader.primaryText,
              ),
              DetailsWidget(title:'Your name(optional)',hinttext: "sheldoncooper89@gmail.com",),
              DetailsWidget(title:'E-mail address',hinttext: '',),
              MessageWidget(),
              DottedWidget(),
              ButtonWidget(formKey: _formKey)
            ],
          ),
        ),
      ),
    );
  }
}



