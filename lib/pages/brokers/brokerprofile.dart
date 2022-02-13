import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/brokers_details_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';

// ignore: must_be_immutable
class BrokerProfile extends StatefulWidget {
  BrokerProfile({Key? key, required this.consumerBrokers}) : super(key: key);
  AllConsumerBrokers consumerBrokers;

  @override
  _BrokerProfileState createState() => _BrokerProfileState();
}

class _BrokerProfileState extends State<BrokerProfile> {
  late Future<BrokersDetailsModel?> streamBrokerProfile;
  @override
  void initState() {
    super.initState();
    print(widget.consumerBrokers.brokerId.toString());
    streamBrokerProfile = ApiServices.getBrokerProfileInfo(
        id: widget.consumerBrokers.brokerId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BrokersDetailsModel?>(
        future: streamBrokerProfile,
        builder: (context, snapshot) {
          // ignore: unnecessary_null_comparison
          if (snapshot.hasData) {
            //  BrokersDetailsModel? brokerProfileInfo =snapshot.data;
          }
          return Scaffold(
            backgroundColor: MasterStyle.backgroundColor,
            appBar: AppBar(
              backgroundColor: MasterStyle.backgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: MasterStyle.appBarIconColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Broker profile',
                style: MasterStyle.appBarTitleStyle,
              ),
              titleSpacing: 0,
            ),
            body: Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      // height: 129.h,
                      // width: 129.w,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.consumerBrokers.profilePic),
                        maxRadius: 50.r,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 26),
                    child: Text(
                      widget.consumerBrokers.firstName +
                          ' ' +
                          widget.consumerBrokers.lastName,
                      style: MasterStyle.whiteTextStyleMedium
                          .merge(TextStyle(fontWeight: FontWeight.normal)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                // brokerProfileInfo.brokerDetail.reviews.toString()
                                '22' + ' reviews',
                                textAlign: TextAlign.center,
                                style: MasterStyle.whiteStyleWithOpacity,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating:
                                  4, // brokerProfileInfo.brokerDetail.rating,
                              itemSize: 16,
                              minRating: 1,
                              direction: Axis.horizontal,
                              unratedColor: Colors.white,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                'Status',
                                textAlign: TextAlign.center,
                                style: MasterStyle.whiteStyleWithOpacity,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 11,
                                    width: 11,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: widget.consumerBrokers.onlineStatus
                                          ? MasterStyle.customGreenColor
                                          : MasterStyle.whiteColor
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      widget.consumerBrokers.onlineStatus
                                          ? 'Online'
                                          : 'Offline',
                                      style: MasterStyle.whiteStyleRegularSmall,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  customDivider(),
                  bodyContent('Mobile', widget.consumerBrokers.mobile),
                  bodyContent('Email', 'lynda@gmail.com'),
                  bodyContent(
                      'Location',
                      widget.consumerBrokers.locality +
                          ', ' +
                          widget.consumerBrokers.state),
                  // Center(
                  //   child: Container(
                  //       height: 57,
                  //       width: 57,
                  //       margin: EdgeInsets.only(top: 17, bottom: 37),
                  //       child: Image(
                  //         image:
                  //             AssetImage('assets/images/award_image.png'),
                  //       )),
                  // ),
                  customDivider()
                ],
              ),
            ),
          );
          // } else {
          //   return Scaffold(
          //     body: CircularProgressIndicator(),
          //   );
        });
  }

  Container bodyContent(title, subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: NewColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MasterStyle.whiteStyleWithOpacity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 8),
            child: Text(
              subtitle,
              style: MasterStyle.whiteTextNormal,
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: MasterStyle.dividerColorSmall,
          )
        ],
      ),
    );
  }

  Divider customDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: MasterStyle.dividerColorSmall,
    );
  }
}
