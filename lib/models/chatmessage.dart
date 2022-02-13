

class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatMessageModel {
  ChatMessageModel({
    required this.image,
    required this.messageType,
    required this.message,
  });
  late final dynamic image;
  late final String messageType;
  late final String message;
  
  ChatMessageModel.fromJson(Map<String, dynamic> json){
    image = json['image'];
    messageType = json['messageType'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['messageType'] = messageType;
    _data['message'] = message;
    return _data;
  }
}