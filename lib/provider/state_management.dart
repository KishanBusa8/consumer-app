// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/shared_preference.dart';
import 'package:hashching/models/all_loans_model.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/consumer_notification_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:hashching/pages/mainpage/hashcing_dashboard.dart';
import 'package:hashching/provider/initialdata.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:provider/provider.dart';

class StateManagementProvider extends StatelessWidget {
  const StateManagementProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitialData.uploaded_files = [];
    InitialData.carMakeList = [];
    return MultiProvider(
        providers: [
          FutureProvider<ConsumerDashboardModel?>.value(
              value: ApiServices.fetchConsumerDashboard(),
              initialData: InitialData.consumerDashboardInitialData),
          FutureProvider<ConsumerAccountModel?>.value(
            value: ApiServices.fetchConsumerAccountData(),
            initialData: InitialData.consumerAccountDataInitialData,
          ),
        ],
        builder: (context, child) {
          var consumerDashboardContext =
              Provider.of<ConsumerDashboardModel>(context);
          var consumerAccountContext =
              Provider.of<ConsumerAccountModel?>(context);
          bool ConsumerAccountDataExists = consumerAccountContext !=
              InitialData.consumerAccountDataInitialData;
          bool ConsumerDashboardDataExists = consumerDashboardContext !=
              InitialData.consumerDashboardInitialData;
          print("ConsumerAccountDataExists  $ConsumerAccountDataExists");
          return ConsumerAccountDataExists &&
                  LocalStorage.UserToken != "" &&
                  ConsumerDashboardDataExists
              ? MultiProvider(
                  providers: [
                      FutureProvider<ConsumerDetailsModel?>.value(
                        value: ApiServices.getConsumerSettings(),
                        initialData:
                            InitialData.consumerDetailsModelInitialData,
                      ),
                      FutureProvider<RewardsModel?>.value(
                          value: ApiServices.getConsumerRewards(),
                          initialData: InitialData.rewardsModelData),
                      FutureProvider<ConsumerDocumentListModel?>.value(
                          value: ApiServices.getConsumerAllDocuments(),
                          initialData: InitialData.consumerDocumentList),
                      FutureProvider<ConsumerLoansModel?>.value(
                          value: ApiServices.fetchConsumerLoansList(),
                          initialData: InitialData.consumerLoansList),
                    ChangeNotifierProvider<ConsumerNotificationsModel?>(
                      create: (_) =>  ConsumerNotificationsModel(
                            consumerNotifications: [],
                            consumerNotificationsUnread: 0),

                        // create: (_) => ApiServices.fetchConsumerNotification(),
                        // value: ApiServices.fetchConsumerNotification(),
                      )
                    ],
                  builder: (context, child) {
                    return HaschingDashboard();
                  })
              : Scaffold(
                  backgroundColor: MasterStyle.backgroundColor,
                  body: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          MasterStyle.thedaryColor),
                    ),
                  ),
                );
        });
  }
}
