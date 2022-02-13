import 'package:flutter/cupertino.dart';

class Onboard {
  List<String> onboadingImages;
  List<String> onboardingDetails;
  List<String> onboardingTitles;
  List<Color> color;
  List<TextStyle> headerstyle;
  List<TextStyle> descriptionstyle;
  List<String>buttonText;
  List<Color> iconColor;
  Onboard({
    required this.onboadingImages,
    required this.onboardingDetails,
    required this.onboardingTitles,
    required this.color,
    required this.buttonText,
    required this.descriptionstyle,required this.headerstyle,required this.iconColor
  });
}
