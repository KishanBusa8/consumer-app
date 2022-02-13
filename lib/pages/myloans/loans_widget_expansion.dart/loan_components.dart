
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/masterstyle.dart';

WidgetSpan PrivacyPolicy({required String text,context}) {
  return   WidgetSpan(
    child: InkWell(onTap: () { SimplifiedWidgets.launchInBrowser('https://www.hashching.co.uk/privacy',context); },
    child: Text(text, style: MasterStyle.primaryContent )),
  );
}

WidgetSpan TermsAndConditions({required String text,context}) {
  return   WidgetSpan(
    child: InkWell(onTap: () { SimplifiedWidgets.launchInBrowser('https://www.hashching.co.uk/terms-conditions',context); },
    child: Text(text, style: MasterStyle.primaryContent )),
  );
}