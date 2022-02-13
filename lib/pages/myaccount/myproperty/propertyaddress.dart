// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/property_details_model.dart';
import 'package:hashching/pages/myaccount/myproperty/importantinformation.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';

class PropertyAddressSearch extends StatefulWidget {
  PropertyAddressSearch(
      {Key? key, required this.propertyId, required this.suggestion})
      : super(key: key);
  String propertyId;
  String suggestion;

  @override
  _PropertyAddressSearchState createState() => _PropertyAddressSearchState();
}

class _PropertyAddressSearchState extends State<PropertyAddressSearch>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  TextEditingController searchController = TextEditingController();
  late final Animation<double> curve;
  late bool onExpansionChanged = false;
  InputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: MasterStyle.textBoxBorderColor,
        width: 4,
      ));
  late Future<PropertyDetailsModel?> fetchPropertyData;
  initialData(propertyId){
    fetchPropertyData = ApiServices.fetchPropertyDetails(propertyId);
    searchController.text = widget.suggestion;
  }
  @override
  void initState() {
    super.initState();
    fetchPropertyData = ApiServices.fetchPropertyDetails(widget.propertyId);
    searchController.text = widget.suggestion;
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    curve = CurvedAnimation(parent: controller!, curve: Curves.easeOut);
  }

  final _currentPageNotifier = ValueNotifier<int>(0);
  final pageController = PageController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PropertyDetailsModel?>(
        future: fetchPropertyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PropertyDetailsModel? propertyDetailsModel = snapshot.data;
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
                    icon: Icon(Icons.arrow_back_ios,
                        color: MasterStyle.appBarIconColor)),
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Enter an address to get started',
                      style: MasterStyle.appBarTitleStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 18),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            searchController.text = '';
                          });
                        },
                        child: TypeAheadFormField(
                          minCharsForSuggestions  :3,
                          loadingBuilder: (context) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    MasterStyle.appSecondaryColor),
                              ),
                            );
                          },
                          keepSuggestionsOnLoading: false,
                          hideOnEmpty: true,
                          hideOnLoading: false,
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: searchController,
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(30, 14, 14, 14)),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          suggestionsCallback: (pattern) async {
                            return await ApiServices.getSuggestions(pattern);
                          },
                          itemBuilder:
                              (context, Map<String, String> suggestion) {
                            return Column(
                              children: [
                                ListTile(
                                    visualDensity: VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    title: suggestion['status'] == "true"
                                        ? Text(
                                            suggestion['suggestions']!,
                                            style: MasterStyle.greyNormalStyle,
                                          )
                                        : Text(
                                            suggestion['suggestions']!,
                                            style:
                                                MasterStyle.negativeStatusStyle,
                                          )),
                                suggestion['status'] == "true"
                                    ? Divider()
                                    : SizedBox()
                              ],
                            );
                          },
                          onSuggestionSelected:
                              (Map<String, String> suggestion) {
                            if (suggestion['status'] == "true") {
                               if (suggestion['propertyId'] == "0") {
                 SimplifiedWidgets.NoPropertyAlertBox(context);
                } else {
                              // initialData(suggestion['propertyId']);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PropertyAddressSearch(
                                              propertyId:
                                                  suggestion['propertyId']
                                                      .toString(),
                                              suggestion:
                                                  suggestion['suggestions']
                                                      .toString())));
                }
                            } else {}
                          },
                        ),
                      ),
                    ),

                    propertyDetailsModel!.images.secondaryImageList.length != 0
                        ? Stack(
                            alignment: Alignment.bottomCenter,
                            fit: StackFit.passthrough,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 0, right: 0, bottom: 17, top: 0),
                                height: 269,
                                width: MediaQuery.of(context).size.width - 16,
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: propertyDetailsModel
                                      .images.secondaryImageList.length,
                                  onPageChanged: (int index) {
                                    setState(() {
                                      _currentPageNotifier.value = index;
                                    });
                                    print(
                                        ' _currentPageNotifier.value  :${_currentPageNotifier.value}');
                                  },
                                  itemBuilder: (_, index) {
                                    return Image.network(
                                      propertyDetailsModel
                                              .images.secondaryImageList[index]
                                          ["mediumPhotoUrl"],
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                              // Positioned(
                              // bottom: 36,
                              //   child: Container(
                              //     width: 100,
                              //     child: SingleChildScrollView(
                              //       scrollDirection: Axis.horizontal,
                              //       child: Row(
                              //         children: [
                              //           CirclePageIndicator(
                              //             itemCount:propertyDetailsModel
                              //               .images.secondaryImageList.length,
                              //             currentPageNotifier: _currentPageNotifier,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          )
                        : Container(
                            margin: EdgeInsets.only(
                              bottom: 17.h,
                            ),
                            height: 269.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: SvgPicture.asset(
                                "assets/property/property_home_image.svg"),
                          ),
                    Text(
                      'Property details :',
                      style: MasterStyle.whiteMediumHeader
                          .merge(TextStyle(fontSize: 17.sp)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(widget.suggestion,
                          style: MasterStyle.primaryContent
                              .merge(TextStyle(fontSize: 19.sp))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textSpan('bed_icon',
                            '${propertyDetailsModel.core.beds} bed', 1),
                        textSpan('bath_icon',
                            '${propertyDetailsModel.core.baths} bath', 2),
                        textSpan(
                            'noun_Car',
                            '${propertyDetailsModel.core.carSpaces} car space',
                            3)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 26.h, top: 16.h),
                      child: Row(children: [
                        Text(
                          'Property type : ',
                          style: MasterStyle.whiteTextNormal,
                        ),
                        Container(
                          width: 15.w,
                          height: 14.h,
                          child: SvgPicture.asset(
                              'assets/property/noun_House.svg'),
                        ),
                        Text(
                          " ${propertyDetailsModel.core.propertyType}",
                          style: MasterStyle.whiteTextNormal,
                        )
                      ]),
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: elevatedButtonWithStyle('Additional information',(){

                    //       }),
                    //     ),
                    //     SizedBox(
                    //       width: 19.w,
                    //     ),   elevatedButtonWithStyle('Generate report',(){

                    //     })
                    //   ],
                    // ),
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
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
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
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: MasterStyle.backgroundColor,
              body: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
                ),
              ),
            );
          }
        });
  }

  textSpan(img, title, index) {
    return RichText(
        text: TextSpan(children: [
      WidgetSpan(
        child: Container(
          margin: EdgeInsets.only(right: 5.w, bottom: 2.w),
          height: index == 1
              ? 12.27.h
              : index == 2
                  ? 13.49.h
                  : 12.6.h,
          width: index == 1
              ? 25.45.w
              : index == 2
                  ? 15.42.w
                  : 14.77.w,
          child: SvgPicture.asset(
            'assets/property/$img.svg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      TextSpan(text: title, style: MasterStyle.whiteTextNormal),
    ]));
  }

  elevatedButtonWithStyle(title,onPressed) {
    return Container(
      height: 32.h,
      child: ElevatedButton(
        child: Text(
          title,
          style: MasterStyle.whiteStyleRegularSmallNormal,
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  )),
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => MasterStyle.appSecondaryColor),
          padding: MaterialStateProperty.resolveWith(
              (states) => EdgeInsets.fromLTRB(10, 6, 10, 6)),
        ),
        onPressed:onPressed ,
      ),
    );
  }
}
