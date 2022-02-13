import 'package:hashching/models/all_loans_model.dart';
import 'package:hashching/models/carmake_model_list.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_brokers_list_model.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'dart:io';

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
          consumerDocumentCount: 0);
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
}
