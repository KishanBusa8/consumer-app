class ConsumerDashboardModel {
  ConsumerDashboardModel({
    required this.allLoans,
    required this.allConsumerBrokers,
    required this.rewardPoints,
    required this.consumerDocumentCount,
  });
  late final List<AllLoans> allLoans;
  late final List<AllConsumerBrokers> allConsumerBrokers;
  late final int rewardPoints;
  late final int consumerDocumentCount;

  ConsumerDashboardModel.fromJson(Map<String, dynamic> json) {
    allLoans =
        List.from(json['allLoans']).map((e) => AllLoans.fromJson(e)).toList();
    allConsumerBrokers = List.from(json['all_consumer_brokers'])
        .map((e) => AllConsumerBrokers.fromJson(e))
        .toList();
    rewardPoints = json['reward_points'];
    consumerDocumentCount = json['consumer_document_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['allLoans'] = allLoans.map((e) => e.toJson()).toList();
    _data['all_consumer_brokers'] =
        allConsumerBrokers.map((e) => e.toJson()).toList();
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
  });
  late final int id;
  late final String leadType;
  late final String productType;
  late final String loanAmount;
  late final String? loanType;
  late final int status;
  late final int? leadBrokerUserID;
  late final int brokerLeadID;
  late final String createdAt;
  late final String? closingStatus;
  late final int? brokerId;
  late final String uniqueId;
  late final String encryptkey;
  late final String loantypeshow;
  late final String createdate;
  late final String statusname;
  late final dynamic brokerName;

  AllLoans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadType = json['lead_type'] ?? "null";
    productType = json['product_type'] ?? "null";
    loanAmount = json['loan_amount'] ?? "null";
    loanType = null;
    status = json['status'];
    leadBrokerUserID = null;
    brokerLeadID = json['broker_lead_ID'] ?? "null";
    createdAt = json['created_at'] ?? "null";
    closingStatus = null ?? "null";
    brokerId = null;
    uniqueId = json['unique_id'] ?? "null";
    encryptkey = json['encryptkey'] ?? "null";
    loantypeshow = json['loantypeshow'] ?? "null";
    createdate = json['createdate'] ?? "null";
    statusname = json['statusname'] ?? "null";
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
    return _data;
  }
}

class AllConsumerBrokers {
  AllConsumerBrokers({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    this.provider,
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
  late final Null provider;
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

  AllConsumerBrokers.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'] ?? "null";
    lastName = json['last_name'] ?? "null";
    profilePic = json['profile_pic'] ?? "null";
    provider = null;
    mobile = json['mobile'] ?? "null";
    state = json['state'] ?? "null";
    brokerId = json['broker_id'];
    lastActivity = json['last_activity'] ?? "null";
    locality = json['locality'] ?? "null";
    statecode = json['statecode'] ?? "null";
    unreadCount = json['unread_count'];
    sharedCount = json['shared_count'];
    encodedId = json['encoded_id'] ?? "null";
    onlineStatus = json['online_status'];
    mobilenew = json['mobilenew'] ?? "null";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['profile_pic'] = profilePic;
    _data['provider'] = provider;
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
