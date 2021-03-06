import 'package:flutter/material.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Column NewColumn(
    {required crossAxisAlignment, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: crossAxisAlignment,
    children: children,
  );
}

Column NewColumnMin(
    {required crossAxisAlignment,
    required List<Widget> children,
    required MainAxisSize mainAxisSize}) {
  return Column(
    crossAxisAlignment: crossAxisAlignment,
    mainAxisSize: mainAxisSize,
    children: children,
  );
}

Column NewColumnMain(
    {required crossAxisAlignment,
    required List<Widget> children,
    required MainAxisAlignment mainAxisAlignment}) {
  return Column(
    crossAxisAlignment: crossAxisAlignment,
    mainAxisAlignment: mainAxisAlignment,
    children: children,
  );
}

class SimplifiedWidgets {
  static Widget completeLoanEnquiryCard(loanEnquiryModel, context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: MasterStyle.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Visibility(
            visible: loanEnquiryModel.bankStatementRequest,
            child: InkWell(
                onTap: () {
                  SimplifiedWidgets.launchInBrowser(
                      loanEnquiryModel.bankStatementIframeLink, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Upload bank statements',
                        style: MasterStyle.appBarSecondaryTextWithOpacityStyle,
                      ),
                    ),
                  ],
                )),
          ),
          Visibility(
            visible: loanEnquiryModel.bankStatementRequest,
            child: Divider(
              color: MasterStyle.customGreyColor,
              thickness: 1,
              height: 6,
            ),
          ),
          loanEnquiryModel.mystroServicesList.length != 0
              ? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          SimplifiedWidgets.launchInBrowser(
                              loanEnquiryModel
                                  .mystroServicesList[index].iframeLink,
                              context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                loanEnquiryModel
                                    .mystroServicesList[index].title,
                                style: MasterStyle
                                    .appBarSecondaryTextWithOpacityStyle,
                              ),
                            ),
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      color: MasterStyle.customGreyColor,
                    );
                  },
                  itemCount: loanEnquiryModel.mystroServicesList.length,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  static ElevatedButton elevatedButton(
      {required String text,
      required TextStyle textStyle,
      EdgeInsetsGeometry? padding,
      required Color color,
      required BorderRadiusGeometry borderRadius,
      required void Function()? onPresed}) {
    return ElevatedButton(
      child: Center(
          child: Text(
        text,
        style: textStyle,
      )),
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                  borderRadius: borderRadius,
                )),
        backgroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return color;
            else if (states.contains(MaterialState.disabled))
              return Colors.grey;
            return color; // Use the component's default.
          },
        ),
        padding: MaterialStateProperty.resolveWith((states) => padding),
      ),
      onPressed: onPresed,
    );
  }

  static getloanAmountWithComma(string) {
    const _locale = 'en';
    String _formatNumber(String s) =>
        NumberFormat.decimalPattern(_locale).format(int.parse(s));
    var stringToInt = int.parse(string.toString().split('.').first);

    var formatter = NumberFormat('#,##,000');
    var _dummy =
        NumberFormat.simpleCurrency(decimalDigits: 0, name: "", locale: _locale)
            .format(stringToInt);
    return _dummy;

    // return "";
  }

  static snackBar(String? message, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent[400],
        content: Text(
          message!,
          style: MasterStyle.whiteTextStyleNormal,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static AppBar appbar({appBarTitle, context}) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: MasterStyle.backgroundColor,
      title: Text(
        appBarTitle,
        style: MasterStyle.appBarTitleStyle,
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor)),
      actions: [
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.search, color: MasterStyle.appBarIconColor)),
      ],
    );
  }

  static AppBar MyAppbar(
      {required String appBarTitle, required BuildContext context}) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: MasterStyle.backgroundColor,
      title: Text(
        appBarTitle,
        style: MasterStyle.appBarTitleStyle,
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor)),
    );
  }

  static Container containerBox(
      {EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin,
      required double radius,
      Widget? child,
      Color? color,
      double? height,
      double? width}) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: child,
    );
  }

  static Container indicator(
      {double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding}) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: MasterStyle.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(100))),
      height: 5,
      width: width,
    );
  }

  static InputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        width: 1,
        color: MasterStyle.whiteColor,
      ));

  static triggerToCall(String callNumber) {
    return launch('tel:' + callNumber);
  }

  static launchURL(context, url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      snankBar(
        context,
        "Could not launch $url",
      );
    }
  }

  static Future<void> launchInBrowser(String url, context) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      snankBar(
        context,
        "Could not launch $url",
      );
    }
  }

  static snankBar(context, message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: MasterStyle.themeColor,
          content: Text(
            message,
            style: MasterStyle.whiteStyleRegularSmall,
          )),
    );
  }

  static NoPropertyAlertBox(context) {
    return showDialog(
        //   barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Container(
                  height: 200,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'No Record Found for this property',
                              textAlign: TextAlign.center,
                              style: MasterStyle.commonTextStyle.merge(
                                  TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Please try another search',
                                textAlign: TextAlign.center,
                                style: MasterStyle.commonTextStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
