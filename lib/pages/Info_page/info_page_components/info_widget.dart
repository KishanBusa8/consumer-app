import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/onboard.dart';
import 'package:hashching/pages/authentication/login_page/loginscreen.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';
import 'package:transparent_image/transparent_image.dart';
import 'info_page_components.dart';

class InfoWidget extends StatelessWidget {
  InfoWidget(
      {Key? key,
      required this.index,
      required this.pages,
      required this.controller})
      : super(key: key);
  final int index;
  final List<Container> pages;
  final PageController controller;
  final onBoard = Onboard(
    iconColor: [IconColors.primary, IconColors.primary, IconColors.primary],
    onboadingImages: [
      'assets/Financeapp-amico.png',
      'assets/images/assistance_image.svg',
      'assets/Savings-amico.png',
    ],
    onboardingDetails: [
      'Track and manage every aspect of your application from one easy-to-use place.',
      'Access trusted advice from top brokers Australia-wide and ongoing support from the Hashching team.',
      'Take advantage of great rates and exclusive special offers while earning reward points just for using the app.',
    ],
    onboardingTitles: [
      'Dashboard',
      'Assistance',
      'Savings',
    ],
    color: [AppColors.primary, AppColors.secondary, AppColors.ternary],
    buttonText: ['Next', 'Next', 'Get Started'],
    headerstyle: [
      HeaderFonts.primaryHeader,
      HeaderFonts.secondaryHeader,
      HeaderFonts.ternaryHeader,
    ],
    descriptionstyle: [
      TextFonts.primaryText,
      TextFonts.secondaryText,
      TextFonts.ternaryText,
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: onBoard.color[index % pages.length],
      child: SingleChildScrollView(
        child: NewColumnMain(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // shrinkWrap:true,
          // scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                index == 0 || index == 1
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Skip',
                              style: MasterStyle.whiteStyleOpacityWithRegular,
                            )),
                      )
                    : SizedBox(
                        height: 20,
                      )
              ],
            ),
            index == 1
                ? SvgPicture.asset(
                    onBoard.onboadingImages[index % pages.length],
                    height: MediaQuery.of(context).size.height / 2.4,
                  )
                : index == 0
                    ? FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: AssetImage(
                          onBoard.onboadingImages[index % pages.length],
                        ),
                      )
                    : Image.asset(
                        onBoard.onboadingImages[index % pages.length],
                      ),
            TextWidget(onBoard: onBoard, index: index, pages: pages),
            Align(
                alignment: Alignment.centerLeft,
                child: DotWidget(
                    controller: controller,
                    onBoard: onBoard,
                    index: index,
                    pages: pages)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 124,
                    padding: EdgeInsets.only(left: 16, bottom: 16),
                    child: ButtonWidget(
                        controller: controller,
                        onBoard: onBoard,
                        index: index,
                        pages: pages)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
