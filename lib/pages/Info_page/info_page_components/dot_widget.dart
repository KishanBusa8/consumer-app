
import 'package:flutter/material.dart';
import 'package:hashching/models/onboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    Key? key,
    required this.controller,
    required this.onBoard,
    required this.index,
    required this.pages,
  }) : super(key: key);

  final PageController controller;
  final Onboard onBoard;
  final int index;
  final List<Container> pages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,top: 12,bottom: 56),
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: onBoard.iconColor[index % pages.length],
          dotColor: onBoard.iconColor[index % pages.length],
          dotHeight: 9,
          dotWidth: 18,
        ),
      ),
    );
  }
}
