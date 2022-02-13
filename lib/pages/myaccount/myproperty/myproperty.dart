import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/pages/myaccount/myproperty/importantinformation.dart';
import 'package:hashching/pages/myaccount/myproperty/propertyaddress.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';

class MyProperty extends StatefulWidget {
  const MyProperty({Key? key}) : super(key: key);

  @override
  _MyPropertyState createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late final Animation<double> curve;
  late bool onExpansionChanged = false;
  NoPropertyAlertBox() {
    showDialog(
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

  InputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: MasterStyle.textBoxBorderColor,
        width: 4,
      ));
  TextEditingController serchInputField = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    curve = CurvedAnimation(parent: controller!, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: MasterStyle.backgroundColor,
        title: Text(
          "My Property",
          style: MasterStyle.appBarTitleStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:
                Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor)),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
        child: ListView(children: [
          SizedBox(
            height: 130,
          ),
          Container(
            child: SvgPicture.asset('assets/images/my_property_home.svg'),
          ),

          TypeAheadFormField(
            minCharsForSuggestions  :3,
            loadingBuilder: (context) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
                ),
              );
            },
            keepSuggestionsOnLoading: true,
            hideOnEmpty: true,
            hideOnLoading: false,
            textFieldConfiguration: TextFieldConfiguration(
              enableInteractiveSelection: false,
              autocorrect: true,
              onSubmitted: (value) {
                setState(() {
                  serchInputField.text = '';
                });
              },
              controller: serchInputField,
              style: MasterStyle.formTextStyle,
              cursorColor: MasterStyle.customGreyColor,
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: MasterStyle.hintStyle,
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  filled: true,
                  fillColor: MasterStyle.whiteColor,
                  hoverColor: MasterStyle.whiteColor,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: MasterStyle.customGreyColor,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14)),
              textCapitalization: TextCapitalization.sentences,
            ),
            suggestionsCallback: (pattern) async {
              return await ApiServices.getSuggestions(pattern);
            },
            itemBuilder: (context, Map<String, String> suggestion) {
              return Column(
                children: [
                  ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: suggestion['status'] == "true"
                          ? Text(
                              suggestion['suggestions']!,
                              style: MasterStyle.greyNormalStyle,
                            )
                          : Text(
                              suggestion['suggestions']!,
                              style: MasterStyle.negativeStatusStyle,
                            )),
                  suggestion['status'] == "true" ? Divider() : SizedBox()
                ],
              );
            },
            onSuggestionSelected: (Map<String, String> suggestion) {
              if (suggestion['status'] == "true") {
                print('property Id :  ${suggestion['propertyId']}');
                if (suggestion['propertyId'] == "0") {
                  NoPropertyAlertBox();
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PropertyAddressSearch(
                              propertyId: suggestion['propertyId'].toString(),
                              suggestion:
                                  suggestion['suggestions'].toString())));
                }
              } else {}
            },
          ),

          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => PropertyAddressSearch()));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 16, bottom: 18),
          //     child: TextFormField(
          //       enabled: true,
          //       style: MasterStyle.formTextStyle,
          //       cursorColor: MasterStyle.customGreyColor,
          //       decoration: InputDecoration(
          //           hintText: "Search",
          //           hintStyle: MasterStyle.hintStyle,
          //           border: outlineInputBorder,
          //           enabledBorder: outlineInputBorder,
          //           focusedBorder: outlineInputBorder,
          //           filled: true,
          //           fillColor: MasterStyle.whiteColor,
          //           hoverColor: MasterStyle.whiteColor,
          //           prefixIcon: Icon(
          //             Icons.search,
          //             size: 20,
          //             color: MasterStyle.customGreyColor,
          //           ),
          //           contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14)),
          //       textCapitalization: TextCapitalization.sentences,
          //     ),
          //   ),
          // ),

          Row(
            children: [
              Expanded(
                child: NewColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.35.h,
                    ),
                    Text(
                      'Get a Free Property Report',
                      style: MasterStyle.appTitleStyle,
                    ),
                    MySizedBox.height(8),
                    Text(
                      'Discover the value, key details, and location statistics for your property, or for a potential future property. Use this tool to download up to 3 free property reports per month.',
                      style: MasterStyle.whiteStyleRegularSmall,
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/neo.png',
                height: 111,
                width: 93,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              child: ExpansionTile(
                  trailing: SizedBox(),
                  onExpansionChanged: (value) {
                    setState(() {
                      onExpansionChanged = !onExpansionChanged;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                  expandedAlignment: Alignment.topLeft,
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  collapsedIconColor: MasterStyle.appBarIconColor,
                  tilePadding: EdgeInsets.only(bottom: 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Row(
                    children: [
                      Container(
                        child: Text(
                          'Important Information ',
                          style: MasterStyle.appTitleStyle,
                        ),
                      ),
                      onExpansionChanged
                          ? RotationTransition(
                              turns: curve,
                              child: Icon(
                                Icons.expand_less,
                                color: MasterStyle.appBarIconColor,
                              ),
                            )
                          : RotationTransition(
                              turns: curve,
                              child: Icon(
                                Icons.expand_more,
                                color: MasterStyle.appBarIconColor,
                              ),
                            ),
                    ],
                  ),
                  iconColor: MasterStyle.appBarIconColor,
                  children: ImportantInformationContent(context)),
            ),
          ),
        ]),
      ),
    );
  }
}
