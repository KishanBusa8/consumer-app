class ConsumerSettingModel{
  late  bool guides_tips;
  late  bool email_marketing;
  late  bool sms_marketing;
  late  bool necessary_messages;
  late  bool dark_theme;


  ConsumerSettingModel(
      {required this.guides_tips,
        required this.email_marketing,
        required  this.sms_marketing,
        required  this.necessary_messages,
        required  this.dark_theme,
      });

  ConsumerSettingModel.fromJson(Map<String, dynamic> json) {
    guides_tips = json['guides_tips'];
    email_marketing = json['email_marketing'];
    sms_marketing = json['sms_marketing'];
    necessary_messages = json['necessary_messages'];
    dark_theme = json['dark_theme'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guides_tips'] = this.guides_tips;
    data['dark_theme'] = this.dark_theme;
    data['email_marketing'] = this.email_marketing;
    data['necessary_messages'] = this.necessary_messages;
    data['sms_marketing'] = this.sms_marketing;
    return data;
  }
}
