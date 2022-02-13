import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50.h),
        height: 41.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: ButtonBorders.primaryButton,
            ),
            primary: MasterStyle.appSecondaryColor,
            padding: EdgeInsets.symmetric(horizontal: 99.w, vertical: 0),
          ),
          child: Text(
            'Send ',
            style: new TextStyle(fontSize: 15.0, color: Colors.white),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
          },
        ),
      ),
    );
  }
}
