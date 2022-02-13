import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/all_loans_model.dart';
import 'package:hashching/models/carmake_model_list.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_brokers_list_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'dart:io';

import 'package:hashching/styles/masterstyle.dart';

class InitialData {
  static ConsumerAccountModel consumerAccountDataInitialData =
      ConsumerAccountModel(
          consumerType: '',
          consumer: ConsumerModel(
              id: 0,
              firstName: '',
              lastName: '',
              email: '',
              mobile: '',
              profilePic: '',
              consumerType: '',
              uniqueId: '',
              convertMobile: ''),
          messageNotification: false,
          services: [],
          darkTheme: false,
          consumerNotificationsUnread: false);
  static ConsumerDashboardModel consumerDashboardInitialData =
      ConsumerDashboardModel(
          allLoans: [],
          allConsumerBrokers: [],
          rewardPoints: 0,
          consumerDocumentCount: 0, completeTask: false);
  static ConsumerLoansModel consumerLoansList =
      ConsumerLoansModel(allLoans: []);
  static ConsumerDocumentListModel consumerDocumentList =
      ConsumerDocumentListModel(documents: []);
  static RewardsModel rewardsModelData = RewardsModel(
      rewards: Rewards(rewardPoints: 0, rewardCredit: []), surveyPoints: '');
  static ConsumerBrokersListModel consumerBrokersList =
      ConsumerBrokersListModel(allConsumerBrokers: [], consumerBroker: []);
  static ConsumerDetailsModel consumerDetailsModelInitialData =
      ConsumerDetailsModel(
          consumerDetails: ConsumerDetails(
              firstName: '',
              lastName: '',
              mobile: '',
              email: '',
              profilePic: '',
              profilePicLink: ''),
          guidesTips: false,
          emailMarketing: false,
          smsMarketing: false,
          necessaryMessages: false,
          darkTheme: false);
  static List uploaded_files = [];
  static File? image;
  static bool isImageSelected = false;
  static List carMakeList = [];
  static brokerDetails(loanEnquireyModel){
    Text(
      'Broker details',
      style: MasterStyle.whiteTextStyleNormal,
    );
    ListTile(
    contentPadding: EdgeInsets.all(0),
    horizontalTitleGap: 16,
    leading: Container(
    height: 51,
    width: 51,
    child: CircleAvatar(
    backgroundImage: NetworkImage(
    loanEnquireyModel.brokerDetail.profilePic),//,.brokerDetail.profilePic),
    ),
    ),
    title: Text(
    loanEnquireyModel.brokerDetail.name,
    style: MasterStyle.whiteStyleWithRegular,
    ),
    subtitle: Text(
    loanEnquireyModel.brokerDetail.mobilenew,
    style: MasterStyle.whiteTextStyleNormal),
    trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    // InkWell(
    //   onTap: () {},
    //   child: Container(
    //     height: 28,
    //     width: 28,
    //     decoration: BoxDecoration(
    //         color: MasterStyle.iconBackgroundColor,
    //         shape: BoxShape.circle),
    //     child: Icon(
    //       Icons.sms_outlined,
    //       color: MasterStyle.appIconColor,
    //       size: 14,
    //     ),
    //   ),
    // ),
    SizedBox(
    width: 16,
    ),
    InkWell(
    onTap: () {
    SimplifiedWidgets.triggerToCall( loanEnquireyModel.brokerDetail.mobilenew);
    },
    child: Container(
    height: 28,
    width: 28,
    decoration: BoxDecoration(
    color: MasterStyle.iconBackgroundColor,
    shape: BoxShape.circle),
    child: Icon(
    Icons.phone,
    color: MasterStyle.appIconColor,
    size: 14,
    ),
    ),
    ),
    ],
    ),
    );
  }
}
