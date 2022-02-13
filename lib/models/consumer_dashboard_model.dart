class ConsumerDashboardModel {
  ConsumerDashboardModel({
    required this.allLoans,
    required this.completeTask,
    required this.allConsumerBrokers,
    required this.rewardPoints,
    required this.consumerDocumentCount,
  });
  late final List<AllLoans> allLoans;
  late final bool completeTask;
  late final List<AllConsumerBrokers> allConsumerBrokers;
  late final int rewardPoints;
  late final int consumerDocumentCount;
  ConsumerDashboardModel.fromJson(Map<String, dynamic> json){
    allLoans = List.from(json['allLoans']).map((e)=>AllLoans.fromJson(e)).toList();
    completeTask = json['complete_task'];
    allConsumerBrokers = List.from(json['all_consumer_brokers']).map((e)=>AllConsumerBrokers.fromJson(e)).toList();
    rewardPoints = json['reward_points'];
    consumerDocumentCount = json['consumer_document_count'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['allLoans'] = allLoans.map((e)=>e.toJson()).toList();
    _data['complete_task'] = completeTask;
    _data['all_consumer_brokers'] = allConsumerBrokers.map((e)=>e.toJson()).toList();
    _data['reward_points'] = rewardPoints;
    _data['consumer_document_count'] = consumerDocumentCount;
    return _data;
  }
}
class AllLoans {
  AllLoans({
    required this.id,
    required this.leadType,
    required this.productType,
    required this.loanAmount,
     this.loanType,
    required this.status,
    this.leadBrokerUserID,
    required this.brokerLeadID,
    required this.createdAt,
    this.closingStatus,
    this.brokerId,
    required this.uniqueId,
    required this.encryptkey,
    required this.loantypeshow,
    required this.createdate,
    required this.statusname,
     this.bankStatementRequested,
     this.leadDetailsMystroRequested,
     this.brokerName,
  });
  late final dynamic id;
  late final dynamic leadType;
  late final dynamic productType;
  late final dynamic loanAmount;
  late final dynamic loanType;
  late final dynamic status;
  late final dynamic leadBrokerUserID;
  late final dynamic brokerLeadID;
  late final dynamic createdAt;
  late final dynamic closingStatus;
  late final dynamic brokerId;
  late final dynamic uniqueId;
  late final dynamic encryptkey;
  late final dynamic loantypeshow;
  late final dynamic createdate;
  late final dynamic statusname;
  late final dynamic bankStatementRequested;
  late final dynamic leadDetailsMystroRequested;
  late final dynamic brokerName;
  AllLoans.fromJson(Map<String, dynamic> json){
    id = json['id']??'';
    leadType = json['lead_type']??'';
    productType = json['product_type']??'';
    loanAmount = json['loan_amount']??'';
    loanType = json['loan_type']??'';
    status = json['status']??'';
    leadBrokerUserID = json['lead_broker_userID']??'' ;
    brokerLeadID = json['broker_lead_ID']??'';
    createdAt = json['created_at']??'';
    closingStatus = json['closing_status']??'';
    brokerId = json['broker_id']??'';
    uniqueId = json['unique_id']??'';
    encryptkey = json['encryptkey']??'';
    loantypeshow = json['loantypeshow']??'';
    createdate = json['createdate']??'';
    statusname = json['statusname']??'';
    bankStatementRequested = json['bank_statement_requested']??'';
    leadDetailsMystroRequested = json['lead_details_mystro_requested']??'';
    brokerName = json['broker_name']??'';
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['lead_type'] = leadType;
    _data['product_type'] = productType;
    _data['loan_amount'] = loanAmount;
    _data['loan_type'] = loanType;
    _data['status'] = status;
    _data['lead_broker_userID'] = leadBrokerUserID;
    _data['broker_lead_ID'] = brokerLeadID;
    _data['created_at'] = createdAt;
    _data['closing_status'] = closingStatus;
    _data['broker_id'] = brokerId;
    _data['unique_id'] = uniqueId;
    _data['encryptkey'] = encryptkey;
    _data['loantypeshow'] = loantypeshow;
    _data['createdate'] = createdate;
    _data['statusname'] = statusname;
    _data['bank_statement_requested'] = bankStatementRequested;
    _data['lead_details_mystro_requested'] = leadDetailsMystroRequested;
    _data['broker_name'] = brokerName;
    return _data;
  }
}
class AllConsumerBrokers {
  AllConsumerBrokers({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.mobile,
    required this.state,
    required this.brokerId,
    required this.lastActivity,
    required this.locality,
    required this.statecode,
    required this.unreadCount,
    required this.sharedCount,
    required this.encodedId,
    required this.onlineStatus,
    required this.mobilenew,
  });
  late final int userId;
  late final String firstName;
  late final String lastName;
  late final String profilePic;

  late final String mobile;
  late final String state;
  late final int brokerId;
  late final String lastActivity;
  late final String locality;
  late final String statecode;
  late final int unreadCount;
  late final int sharedCount;
  late final String encodedId;
  late final bool onlineStatus;
  late final String mobilenew;
  AllConsumerBrokers.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];

    mobile = json['mobile'];
    state = json['state'];
    brokerId = json['broker_id'];
    lastActivity = json['last_activity'];
    locality = json['locality'];
    statecode = json['statecode'];
    unreadCount = json['unread_count'];
    sharedCount = json['shared_count'];
    encodedId = json['encoded_id'];
    onlineStatus = json['online_status'];
    mobilenew = json['mobilenew'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['profile_pic'] = profilePic;
    _data['mobile'] = mobile;
    _data['state'] = state;
    _data['broker_id'] = brokerId;
    _data['last_activity'] = lastActivity;
    _data['locality'] = locality;
    _data['statecode'] = statecode;
    _data['unread_count'] = unreadCount;
    _data['shared_count'] = sharedCount;
    _data['encoded_id'] = encodedId;
    _data['online_status'] = onlineStatus;
    _data['mobilenew'] = mobilenew;
    return _data;
  }
}