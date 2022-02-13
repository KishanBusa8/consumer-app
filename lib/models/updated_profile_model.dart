class UpdatedProfileModel {
  UpdatedProfileModel({
    required this.status,
    required this.consumerDetails,
  });
  late final bool status;
  late final ConsumerDetails consumerDetails;
  
  UpdatedProfileModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    consumerDetails = ConsumerDetails.fromJson(json['consumer_details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['consumer_details'] = consumerDetails.toJson();
    return _data;
  }
}

class ConsumerDetails {
  ConsumerDetails({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.profilePic,
    required this.profilePicLink,
  });
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String email;
  late final String profilePic;
  late final String profilePicLink;
  
  ConsumerDetails.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'] != null ? json['first_name'] : '';
    lastName = json['last_name'] != null ? json['last_name'] : '';
    mobile = json['mobile'];
    email = json['email'];
    profilePic = json['profile_pic'];
    profilePicLink = json['profile_pic_link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['mobile'] = mobile;
    _data['email'] = email;
    _data['profile_pic'] = profilePic;
    _data['profile_pic_link'] = profilePicLink;
    return _data;
  }
}