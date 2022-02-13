class BrokersDetailsModel {
  BrokersDetailsModel({
    required this.brokerDetail,
  });
  late final BrokerDetail brokerDetail;
  
  BrokersDetailsModel.fromJson(Map<String, dynamic> json){
    brokerDetail = BrokerDetail.fromJson(json['broker_detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['broker_detail'] = brokerDetail.toJson();
    return _data;
  }
}

class BrokerDetail {
  BrokerDetail({
    required this.name,
    required this.mobile,
    required this.reviews,
    required this.rating,
    required this.brokerRatingBlock,
    required this.state,
    required this.profilePic,
    required this.brokerCategory,
    required this.address,
    required this.onlineStatus,
    required this.about,
    required this.mobilenew,
  });
  late final String name;
  late final String mobile;
  late final  reviews;
  late final  rating;
  late final String brokerRatingBlock;
  late final String state;
  late final String profilePic;
  late final String brokerCategory;
  late final String address;
  late final bool onlineStatus;
  late final String about;
  late final String mobilenew;
  
  BrokerDetail.fromJson(Map<String, dynamic> json){
    name = json['name'];
    mobile = json['mobile'];
    reviews = json['reviews'];
    rating = json['rating'];
    brokerRatingBlock = json['broker_rating_block'];
    state = json['state'];
    profilePic = json['profile_pic'];
    brokerCategory = json['brokerCategory'];
    address = json['address'];
    onlineStatus = json['online_status'];
    about = json['about'];
    mobilenew = json['mobilenew'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['mobile'] = mobile;
    _data['reviews'] = reviews;
    _data['rating'] = rating;
    _data['broker_rating_block'] = brokerRatingBlock;
    _data['state'] = state;
    _data['profile_pic'] = profilePic;
    _data['brokerCategory'] = brokerCategory;
    _data['address'] = address;
    _data['online_status'] = onlineStatus;
    _data['about'] = about;
    _data['mobilenew'] = mobilenew;
    return _data;
  }
}