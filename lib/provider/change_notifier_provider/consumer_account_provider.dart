import 'package:flutter/material.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/provider/initialdata.dart';
import 'package:hashching/services/api_services.dart';

class ConsumerAccountProvider with ChangeNotifier{
  ConsumerAccountModel consumerAccountModel = InitialData.consumerAccountDataInitialData;
  bool loading = false;
  
  getPostData() async {
    loading = true;
   // consumerAccountModel = await ApiServices.fetchConsumerAccountData();
    loading = false;

    notifyListeners();
  }

}

