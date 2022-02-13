// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/hash_connect_model.dart';
import 'package:hashching/pages/mydeals/hash_conveyancing.dart/hash_convenyancing_enquirey.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class HashConnect extends StatelessWidget {
    HashConnect({Key? key, required this.consumerAccountModel})
      : super(key: key);
  ConsumerAccountModel consumerAccountModel;

  @override
  Widget build(BuildContext context) {
    //title.replaceFirst(title[0], title[0].toUpperCase())


    String getFirstLetterCapital(String text){
      var tempValue = text.replaceFirst(text[0], text[0].toUpperCase());
      return tempValue;
    }
    return Scaffold(
        backgroundColor: MasterStyle.backgroundColor,
        appBar: AppBar(
          centerTitle:false,
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
            "HashConnect",
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
                        padding:
                                  EdgeInsets.only(left: 47.w, top: 6.h,right: 47.w,bottom: 7.h),
                        text: 'Make a request',
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onPresed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HashConvenyancingEnquirey(
                                      consumerAccountModel: consumerAccountModel
                                      )));
                        }),
                  ],
                ),
              ),

              // hash connect listing
              FutureBuilder<HashConnectListModel>(
                  future: ApiServices.fetchHashConnectList(),
                  builder: (context, snapshot) {
                    print("dat    ${snapshot}");
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        HashConnectListModel? hashConnectListingModel =
                            snapshot.data;
                        if (hashConnectListingModel!.hashconnectList.length == 0) {
                          return  Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
                            child: SimplifiedWidgets.elevatedButton(
                                color: HexColor('#485C71'),
                                textStyle: MasterStyle.buttonWhiteTextStyleRegular,
                                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                text: 'No HashConnect Request Found',
                                borderRadius: BorderRadius.all(Radius.circular(8)),
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
                             hashConnectListingModel.hashconnectList.length,
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
                                              getFirstLetterCapital(
                                              hashConnectListingModel
                                                  .hashconnectList[index]
                                                  .firstName) +
                                                  " " +
                                                  getFirstLetterCapital(
                                                  hashConnectListingModel
                                                      .hashconnectList[index]
                                                      .lastName) ,
                                              style: MasterStyle.blackBoldStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                          hashConnectListingModel
                                              .hashconnectList[index].uniqueId!.toString(),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Move-in date : '
                                                  ,
                                              style: MasterStyle
                                                  .blackTextWithOpacityStyle
                                                  .merge(
                                                  TextStyle(fontSize: 13.sp))),
                                          Text("${hashConnectListingModel.hashconnectList[index].moveIndate}",
                                              style: MasterStyle
                                                  .possitiveStatusStyle
                                                  .merge(
                                                  TextStyle(fontSize: 13.sp,color:HexColor("#349600").withOpacity(.7))))
                                        ],
                                      ),
                                      SizedBox(height: 10.12.h,),
                                      Row(
                                        children: [
                                          Icon(Icons.email_outlined,size: 13,),
                                          Text(" "+hashConnectListingModel.hashconnectList[index].email),
                                        SizedBox(width: 16,),
                                          Icon(Icons.phone_outlined ,size:13),
                                          Text(" "+hashConnectListingModel.hashconnectList[index].phone),
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

              Image.asset('assets/images/hash_connect_card.png'),
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
