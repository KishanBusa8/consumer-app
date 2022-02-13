// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/hash_convenyancing_model.dart';
import 'package:hashching/pages/mydeals/hash_connect/hash_connect_enquirey.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:http/http.dart' as http;

class HashConvenyancing extends StatefulWidget {
  HashConvenyancing({Key? key, required this.consumerAccountModel,required this.hashConveyacingRawList})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;
  HashConveyacingRawList hashConveyacingRawList;

  @override
  State<HashConvenyancing> createState() => _HashConvenyancingState();
}

class _HashConvenyancingState extends State<HashConvenyancing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: MasterStyle.appBarIconColor)),
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: MasterStyle.backgroundColor,
          title: Text(
            "HashConvenyancing",
            style: MasterStyle.appBarTitleStyle,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SimplifiedWidgets.elevatedButton(
                        color: MasterStyle.appSecondaryColor,
                        textStyle: MasterStyle.buttonWhiteTextStyleBold,
                        padding: EdgeInsets.only(
                            left: 47.w, top: 6.h, right: 47.w, bottom: 7.h),
                        text: 'Make a request',
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onPresed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HashConnectEnquirey(
                                      consumerAccountModel:
                                          widget.consumerAccountModel)));
                        }),
                  ],
                ),
              ),
             
              FutureBuilder<dynamic>(
                  future: ApiServices.fetchHashConvenyancingList(),
                  builder: (context, snapshot) {
                    print("dat    ${snapshot}");
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        // print(
                        //     'hashConvenyancingList ${snapshot.data['hashconveyacing_list'][0]['invoice_amount']}');
                        var hashConvenyancingSnapshot = snapshot.data;
                        var hashConvenyancingList =
                            hashConvenyancingSnapshot['hashconveyacing_list'];
                        if (hashConvenyancingList.length == 0) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 20.h),
                            child: SimplifiedWidgets.elevatedButton(
                                color: HexColor('#485C71'),
                                textStyle:
                                    MasterStyle.buttonWhiteTextStyleRegular,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                text: 'No HashConvenyancing Request Found',
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                onPresed: () {}),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 16.83.h),
                            height: 198.h,
                            decoration: BoxDecoration(
                              color: MasterStyle.whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)),
                            ),
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: hashConvenyancingList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding:
                                      EdgeInsets.only(top: 16.h, bottom: 16.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              hashConvenyancingList[index]
                                                      ['property_address']
                                                  .toString(),
                                              style: MasterStyle.blackBoldStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('New lead from Hashching',
                                              style: MasterStyle
                                                  .smallsecontarystyle)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.5,
                                      ),
                                      Text(
                                          '${hashConvenyancingList[index]['first_name']} . ${hashConvenyancingList[index]['mobile']}',
                                          style: MasterStyle
                                              .blackTextWithOpacityStyle
                                              .merge(
                                                  TextStyle(fontSize: 13.sp))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(top: 8.5),
                                              child: RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 4.9.w,
                                                        bottom: 1.h),
                                                    child: Icon(
                                                      Icons.email_outlined,
                                                      color:
                                                          HexColor('#4C4C4C'),
                                                      size: 12,
                                                    ),
                                                  )),
                                                  TextSpan(
                                                      text:
                                                          hashConvenyancingList[
                                                                      index]
                                                                  ['email']
                                                              .toString(),
                                                      style: MasterStyle
                                                          .blackTextWithOpacityStyle
                                                          .merge(TextStyle(
                                                              fontSize: 13.sp)))
                                                ]),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 1.h),
                                            child: Text(
                                                hashConvenyancingList[index]
                                                        ['unique_id']
                                                    .toString(),
                                                style: MasterStyle
                                                    .blackTextWithOpacityStyle
                                                    .merge(TextStyle(
                                                        fontSize: 13.sp))),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: HexColor('#CED4DB')))),
                                );
                              },
                            ),
                          );
                        }
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
                      ));
                    }
                    return SizedBox();
                  }),
              Image.asset(
                'assets/images/hash_convenyancing_card.png',
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: EdgeInsets.only(right: 8, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SimplifiedWidgets.elevatedButton(
                        color: MasterStyle.appSecondaryColor,
                        textStyle: MasterStyle.buttonWhiteTextStyleBold,
                        padding: EdgeInsets.symmetric(
                            horizontal: 67.5, vertical: 7.5),
                        text: 'Download PDF',
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onPresed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<HashConvenyancingListModel> fetchAlbum() async {
    final response =
        await http.get(Uri.parse(LocalConstants.hashConvenyancingListenerUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return HashConvenyancingListModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
