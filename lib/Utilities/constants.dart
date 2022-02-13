class LocalConstants {
  static final dashboard = 'Dashboard';
  static final notification = 'Notification';
  static String facebookLoginUrl =
      "https://www.hashching.co.uk/facebook-login-borrower";
  static String googleLoginUrl =
      "https://www.hashching.co.uk/google-login-borrower";
  static String uploadBankStatement =
      "https://hashching-dev.wealthdesk.com.au/iv/connections";
  static String completeFactFind =
      "https://app.mystro.com.au/b/PrBP5crL43alcV2Njqk";

  static String loginPostUrl =
      "https://api.hashching.com.au/api/v1/consumer-login-email";
  static String loginOtpUrl =
      "https://api.hashching.com.au/api/v1/submit-mobile-code-consumer";
  static String SignupEmailUrl =
      "https://api.hashching.com.au/api/v1/send-code-new-account";
  static String SignupOtpUrl =
      "https://api.hashching.com.au/api/v1/send-code-new-account";
  static String ConsumerAccountUrl =
      "https://api.hashching.com.au/api/v1/consumer-account";
  static String ConsumerDeshboardUrl =
      "https://api.hashching.com.au/api/v1/consumer-dashboard";
  static String ConsumerAllLoansUrl =
      "https://api.hashching.com.au/api/v1/all-consumer-loans";
  static String ConsumerAllBrokersUrl =
      "https://api.hashching.com.au/api/v1/all-assigned-brokers";
  static String ConsumerSettingsUrl =
      "https://api.hashching.com.au/api/v1/get-consumer-settings";
  static String updatedConsumerProfileUrl =
      "https://api.hashching.com.au/api/v1/update-consumer-profile";
  static String fetchBrokerDetailsUrl =
      "https://api.hashching.com.au/api/v1/fetch-broker-details";
  static String getConsumerRewardsUrl =
      "https://api.hashching.com.au/api/v1/get-consumer-rewards";
  static String consumerAllDocumentsUrl =
      "https://api.hashching.com.au/api/v1/all-consumer-documents";
  static String deleteConsumerDocumentsUrl =
      "https://api.hashching.com.au/api/v1/delete-consumer-vault-documents";
  static String shareConsumerDocumentsUrl =
      "https://api.hashching.com.au/api/v1/share-document-with-broker";
  static String getPropertyCreditUrl =
      "https://api.hashching.com.au/api/v1/get-property-credit-info";
  static String fetchLoanDetailsUrl =
      "https://api.hashching.com.au/api/v1/fetch-loan-detail";
  static String addNewLoanUrl =
      "https://api.hashching.com.au/api/v1/add-new-loan";
  static String addNewHashAutoUrl =
      "https://api.hashching.com.au/api/v1/add-new-consumer-hashauto";
  static String addNewHashConnectUrl =
      "https://api.hashching.com.au/api/v1/add-new-consumer-hashconnect";
  static String addNewHashConvenyancingUrl =
      "https://api.hashching.com.au/api/v1/add-new-consumer-hashconveyancing";
  static String propertyDetailsUrl =
      "https://api.hashching.com.au/api/v1/property-details";
  static String UrlUploadProfilePic =
      "https://api.hashching.com.au/api/v1/upload-profile-pic";
  static String propertySuggestionsUrl =
      "https://api.hashching.com.au/api/v1/property-suggestions";
  static String postcodeSuggestionsUrl =
      "https://api.hashching.com.au/api/v1/postcodes-list";
  static String getDocumentIFrameLinkUrl =
      "https://api.hashching.com.au/api/v1/get-document-iframe-link";
  static String sendMessageToBroker =
      "https://api.hashching.com.au/api/v1/send-message";
  static String getCarMakeList =
      "https://api.hashching.com.au/api/v1/car-make";
  static String getCarMakeModelList =
      "https://api.hashching.com.au/api/v1/car-model";
  static String addConsumerUploadDocumentUrl =
      "https://api.hashching.com.au/api/v1/add-consumer-document-file";
  static String hashConvenyancingListenerUrl =
      "https://api.hashching.com.au/api/v1/all-consumer-conveyancing-listing";
  static String otpSend2ConsumerUrl =
      "https://api.hashching.com.au/api/v1/send-mobile-code-consumer";
  static String verifyOtpUrl =
      "https://api.hashching.com.au/api/v1/validate-mobile-code";
  static String hashAutoListenerUrl =
      "https://api.hashching.com.au/api/v1/all-consumer-hashauto-listing";
  static String hashConnectListenerUrl =
      "https://api.hashching.com.au/api/v1/all-consumer-hashconnect-listing";
  static List networkImageList = [
    'https://randomuser.me/api/portraits/women/3.jpg',
    'https://randomuser.me/api/portraits/men/3.jpg',
    'https://randomuser.me/api/portraits/women/2.jpg'
  ];
  static String appPreviouslyRunKey = "seen";
  static String loggedIn = "loggedIn";
  static String userToken = "userToken";
}

class SettingConstant {
  static const String switchTheme = 'switchTheme';
  static const String switchGuideAndTips = "switchGuideAndTips";
  static const String switchEmailMarket = "switchEmailMarket";
  static const String switchSmsMarket = "switchSmsMarket";
  static const String switchNecessaryMessage = "switchNecessaryMessage";
}
