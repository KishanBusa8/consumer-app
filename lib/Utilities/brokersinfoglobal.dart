import 'package:hashching/models/consumer_dashboard_model.dart';

class BrokerInfoGlobal{
  static ConsumerDashboardModel readBrokerInfoDoc(
      String documentId, userInfoWithDocumentId) {
    ConsumerDashboardModel consumerDashboardModel =
        userInfoWithDocumentId
            .firstWhere((element) => element.documentId == documentId);
    return consumerDashboardModel;
  }
}