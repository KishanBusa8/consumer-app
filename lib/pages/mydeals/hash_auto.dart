// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/hash_auto_model.dart';
import 'package:hashching/pages/mydeals/hash_auto/hash_auto_enquirey.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashAuto extends StatelessWidget {
  HashAuto({Key? key, required this.consumerAccountModel}) : super(key: key);
  ConsumerAccountModel consumerAccountModel;
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
            "HashAuto",
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
                                  builder: (context) => HashAutoEnquirey(
                                        consumerAccountModel:
                                            consumerAccountModel,
                                      )));
                        }),
                  ],
                ),
              ),

              // hash auto listing
              FutureBuilder<HashautoListingModel>(
                  future: ApiServices.fetchHashAutoList(),
                  builder: (context, snapshot) {
                    print("dat    ${snapshot}");
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        HashautoListingModel? hashautoListingModel =
                            snapshot.data;
                        if (hashautoListingModel!.hashautoList.length == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 20),
                            child: SimplifiedWidgets.elevatedButton(
                                color: HexColor(
                                    '#485C71'), //MasterStyle.whiteColor.withOpacity(0.3),
                                textStyle:
                                    MasterStyle.buttonWhiteTextStyleRegular,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                text: 'No HashAuto Request Found',
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
                              itemCount:
                                  hashautoListingModel.hashautoList.length,
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
                                              hashautoListingModel
                                                      .hashautoList[index]
                                                      .make +
                                          " " +
                                                  hashautoListingModel
                                                      .hashautoList[index]
                                                      .model+  " | " + hashautoListingModel
                                                  .hashautoList[index].condition ,
                                              style: MasterStyle.blackBoldStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text( hashautoListingModel
                                              .hashautoList[index].uniqueId,
                                              style: MasterStyle
                                                  .blackTextWithOpacityStyle
                                                  .merge(
                                                  TextStyle(fontSize: 13.sp)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${hashautoListingModel.hashautoList[index].firstName + " " + hashautoListingModel.hashautoList[index].lastName}'+" . "
                                              ' ${hashautoListingModel.hashautoList[index].phone}',
                                              style: MasterStyle
                                                  .blackTextWithOpacityStyle
                                                  .merge(
                                                      TextStyle(fontSize: 13.sp))),
                                          Text("Status : " + hashautoListingModel
                                              .hashautoList[index].statusname,
                                              style: MasterStyle
                                                  .commonTextStyle
                                                  .merge(
                                                  TextStyle(fontSize: 13.sp)))
                                        ],
                                      ),
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
                        valueColor: AlwaysStoppedAnimation(
                            MasterStyle.appSecondaryColor),
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            MasterStyle.appSecondaryColor),
                      ));
                    }
                    return SizedBox();
                  }),

              Image.asset(
                'assets/images/hash_auto_card.png',
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
}
