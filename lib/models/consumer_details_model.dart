class ConsumerDetailsModel {
  ConsumerDetailsModel({
    required this.consumerDetails,
    required this.guidesTips,
    required this.emailMarketing,
    required this.smsMarketing,
    required this.necessaryMessages,
    required this.darkTheme,
  });
  late final ConsumerDetails consumerDetails;
  late final bool guidesTips;
  late final bool emailMarketing;
  late final bool smsMarketing;
  late final bool necessaryMessages;
  late final bool darkTheme;
  
  ConsumerDetailsModel.fromJson(Map<String, dynamic> json){
    consumerDetails = ConsumerDetails.fromJson(json['consumer_details']);
    guidesTips = json['guides_tips'];
    emailMarketing = json['email_marketing'];
    smsMarketing = json['sms_marketing'];
    necessaryMessages = json['necessary_messages'];
    darkTheme = json['dark_theme'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['consumer_details'] = consumerDetails.toJson();
    _data['guides_tips'] = guidesTips;
    _data['email_marketing'] = emailMarketing;
    _data['sms_marketing'] = smsMarketing;
    _data['necessary_messages'] = necessaryMessages;
    _data['dark_theme'] = darkTheme;
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
  late final  firstName;
  late final  lastName;
  late final  mobile;
  late final  email;
  late final  profilePic;
  late final  profilePicLink;
  
  ConsumerDetails.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'];
    lastName = json['last_name'];
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