class ConsumerBrokersListModel {
  ConsumerBrokersListModel({
    required this.consumerBroker, required List allConsumerBrokers,
  });
  late final List<ConsumerBrokers> consumerBroker;
  
  ConsumerBrokersListModel.fromJson(Map<String, dynamic> json){
    consumerBroker = List.from(json['all_consumer_brokers']).map((e)=>ConsumerBrokers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['all_consumer_brokers'] = consumerBroker.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ConsumerBrokers {
  ConsumerBrokers({
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
  
  ConsumerBrokers.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    provider = null;
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