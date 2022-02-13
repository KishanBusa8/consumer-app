  import 'package:flutter/material.dart';
import 'package:hashching/styles/masterstyle.dart';

  Widget detailsHeader(headerValue) {
    return Text(
      headerValue,
      style: MasterStyle.whiteSmallWithOpacityStyle,
    );
  }

  Widget detailsContent(contentValue) {
    return Text(
      contentValue,
      style: MasterStyle.whiteTextStyleMediumSize,
    );
  }