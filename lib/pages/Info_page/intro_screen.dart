
import 'package:flutter/material.dart';
import 'package:hashching/pages/Info_page/info_page_components/info_widget.dart';
import 'package:hashching/styles/masterstyle.dart';


class IntroScreen extends StatelessWidget {

  final controller =
      PageController(viewportFraction: 1, keepPage: true, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(3, (index) => Container());
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            itemBuilder: (_, index) {
              return InfoWidget(
                pages: pages,
                index: index % pages.length,
                controller:controller
              );
            },
          ),
        ),
      ),
    );
  }
}
