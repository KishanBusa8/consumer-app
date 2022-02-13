import 'package:flutter/cupertino.dart';
import 'package:hashching/services/api_services.dart';

class ConsumerNotificationsModel extends ChangeNotifier {
  ConsumerNotificationsModel({
    required this.consumerNotifications,
    required this.consumerNotificationsUnread,
  });
  List<ConsumerNotifications>? consumerNotifications;
  int? consumerNotificationsUnread;
  ConsumerNotificationsModel.fromJson(Map<String, dynamic> json){
    consumerNotifications = List.from(json['consumer_notifications']).map((e)=>ConsumerNotifications.fromJson(e)).toList();
    consumerNotificationsUnread = json['consumer_notifications_unread'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['consumer_notifications'] = consumerNotifications!.map((e)=>e.toJson()).toList();
    _data['consumer_notifications_unread'] = consumerNotificationsUnread;
    return _data;
  }
  void changeValue() async  {
    ApiServices.fetchConsumerNotification().then((value) {
      this.consumerNotifications = value!.consumerNotifications;
      // this.consumerNotifications = [];
      this.consumerNotificationsUnread = value.consumerNotificationsUnread;
      notifyListeners();
    });
  }
}
class ConsumerNotifications {
  ConsumerNotifications({
    required this.id,
    required this.leadId,
    required this.ownerId,
    required this.consumerId,
    required this.ownerType,
    required this.action,
    required this.link,
    required this.readUnread,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.notificationTime,
    required this.encryptId,
  });
  late final dynamic id;
  late final dynamic leadId;
  late final dynamic ownerId;
  late final dynamic consumerId;
  late final dynamic ownerType;
  late final dynamic action;
  late final dynamic link;
  late final dynamic readUnread;
  late final dynamic title;
  late final dynamic status;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final dynamic notificationTime;
  late final dynamic encryptId;
  ConsumerNotifications.fromJson(Map<String, dynamic> json){
    id = json['id']?? '';
    leadId = json['lead_id'] ?? '';
    ownerId = json['owner_id']?? '';
    consumerId = json['consumer_id']?? '';
    ownerType = json['owner_type']?? '';
    action = json['action']?? '';
    link = json['link']?? '';
    readUnread = json['read_unread']?? '';
    title = json['title']?? '';
    status = json['status']?? '';
    createdAt = json['created_at']?? '';
    updatedAt = json['updated_at']?? '';
    notificationTime = json['notification_time']?? '';
    encryptId = json['encrypt_id']?? '';
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['lead_id'] = leadId;
    _data['owner_id'] = ownerId;
    _data['consumer_id'] = consumerId;
    _data['owner_type'] = ownerType;
    _data['action'] = action;
    _data['link'] = link;
    _data['read_unread'] = readUnread;
    _data['title'] = title;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['notification_time'] = notificationTime;
    _data['encrypt_id'] = encryptId;
    return _data;
  }
}