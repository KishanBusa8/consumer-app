// ignore_for_file: unnecessary_null_comparison

class ConsumerAccountModel {
 late  String consumerType;
late   ConsumerModel consumer;
late   bool messageNotification;
 late  List<Services> services;
late   bool darkTheme;
late   bool consumerNotificationsUnread;

  ConsumerAccountModel(
      { required this.consumerType,
    required  this.consumer,
     required this.messageNotification,
     required this.services,
    required  this.darkTheme,
    required  this.consumerNotificationsUnread});

  ConsumerAccountModel.fromJson(Map<String, dynamic> json) {
    consumerType = json['consumer_type'];
    consumer = (json['consumer'] != null
        ? new ConsumerModel.fromJson(json['consumer'])
        : null)!;
    messageNotification = json['message_notification'];
    if (json['services'] != null) {
      // ignore: deprecated_member_use
      services =  List.from(json['services']).map((e)=>Services.fromJson(e)).toList();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    darkTheme = json['dark_theme'];
    consumerNotificationsUnread = json['consumer_notifications_unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consumer_type'] = this.consumerType;
    if (this.consumer != null) {
      data['consumer'] = this.consumer.toJson();
    }
    data['message_notification'] = this.messageNotification;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    data['dark_theme'] = this.darkTheme;
    data['consumer_notifications_unread'] = this.consumerNotificationsUnread;
    return data;
  }
}

class ConsumerModel{
 late  int id;
 late  String firstName;
late   String? lastName;
 late  String email;
late   String mobile;
late   String profilePic;
late   String consumerType;
late   String uniqueId;
 late  String convertMobile;

  ConsumerModel(
      {required this.id,
     required this.firstName,
    required  this.lastName,
    required  this.email,
    required  this.mobile,
    required  this.profilePic,
    required  this.consumerType,
    required  this.uniqueId,
    required  this.convertMobile});

  ConsumerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name']??'';
    email = json['email'];
    mobile = json['mobile'];
    profilePic = json['profile_pic'];
    consumerType = json['consumer_type'];
    uniqueId = json['unique_id'];
    convertMobile = json['convert_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_pic'] = this.profilePic;
    data['consumer_type'] = this.consumerType;
    data['unique_id'] = this.uniqueId;
    data['convert_mobile'] = this.convertMobile;
    return data;
  }
}

class Services {
 late  String serviceName;

  Services({required this.serviceName});

  Services.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    return data;
  }
}
