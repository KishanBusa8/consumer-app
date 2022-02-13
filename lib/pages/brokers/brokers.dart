// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_brokers_list_model.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/pages/brokers/brokerprofile.dart';
import 'package:hashching/pages/brokers/brokerschat.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:provider/provider.dart';

class Brokers extends StatefulWidget {
  Brokers({Key? key, required this.brokerNavigation}) : super(key: key);
  Widget brokerNavigation;

  @override
  State<Brokers> createState() => _BrokersState();
}

class _BrokersState extends State<Brokers> {
  @override
  Widget build(BuildContext context) {
    ConsumerDashboardModel consumerDashboardModel =
        Provider.of<ConsumerDashboardModel>(context);
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: appbar(context, this.widget.brokerNavigation),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
            itemCount: consumerDashboardModel.allConsumerBrokers.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return mybrokerList(
                  consumerInformation:
                      consumerDashboardModel.allConsumerBrokers[index],
                  brokerName: consumerDashboardModel
                          .allConsumerBrokers[index].firstName +
                      ' ' +
                      consumerDashboardModel.allConsumerBrokers[index].lastName,
                  brokerAddress: consumerDashboardModel
                          .allConsumerBrokers[index].locality +
                      ', ' +
                      consumerDashboardModel.allConsumerBrokers[index].state,
                  profileImage: consumerDashboardModel
                      .allConsumerBrokers[index].profilePic,
                  context: context,
                  phoneNumber:
                      consumerDashboardModel.allConsumerBrokers[index].mobile);
            }),
      ),
    );
  }

  AppBar appbar(context,brokerNavigation) {
    return AppBar(
      centerTitle: false,
      backgroundColor: MasterStyle.backgroundColor,
      elevation: 0,
      leading: brokerNavigation,
      title: Text(
        'Broker',
        style: MasterStyle.appTitleStyle,
      ),
      titleSpacing: 0,
      actions: [
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search,
        //       color: MasterStyle.appBarIconColor,
        //     )),
      ],
    );
  }

  Container mybrokerList(
      {brokerName,
      brokerAddress,
      profileImage,
      context,
    required AllConsumerBrokers  consumerInformation,
      phoneNumber}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
              color: Colors.white,
              image: DecorationImage(image: NetworkImage(profileImage)),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NewColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brokerName,
                    style: MasterStyle.lightBlackRegularStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      brokerAddress,
                      style: MasterStyle.greySmallTextStyle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BrokersChat(consumerBrokers: consumerInformation,)));
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: MasterStyle.iconBackgroundColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.sms_outlined,
                            color: MasterStyle.appIconColor,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SimplifiedWidgets.triggerToCall(phoneNumber);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: MasterStyle.iconBgCircleColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.call,
                            color: MasterStyle.appIconColor,
                            size: 14,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      //  InkWell(
                      //     onTap: () {},
                      //     child: SvgPicture.asset(
                      //         'assets/icons/vedio_call_icon.svg'),
                      //   ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BrokerProfile(
                                        consumerBrokers: consumerInformation,
                                      )));
                        },
                        child: SvgPicture.asset('assets/icons/info_icon.svg'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
