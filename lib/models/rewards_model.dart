class RewardsModel {
  RewardsModel({
    required this.rewards,
    required this.surveyPoints,
  });
  late final Rewards rewards;
  late final dynamic  surveyPoints;
  
  RewardsModel.fromJson(Map<String, dynamic> json){
    rewards = Rewards.fromJson(json['rewards']);
    surveyPoints = json['survey_points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rewards'] = rewards.toJson();
    _data['survey_points'] = surveyPoints;
    return _data;
  }
}

class Rewards {
  Rewards({
    required this.rewardPoints,
    required this.rewardCredit,
  });
  late final int rewardPoints;
  late final List<RewardCredit> rewardCredit;
  
  Rewards.fromJson(Map<String, dynamic> json){
    rewardPoints = json['reward_points'];
    rewardCredit = List.from(json['reward_credit']).map((e)=>RewardCredit.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reward_points'] = rewardPoints;
    _data['reward_credit'] = rewardCredit.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class RewardCredit {
  RewardCredit({
    required this.id,
    required this.rewardAccountId,
    required this.action,
    required this.itemId,
    required this.transactionType,
    required this.points,
    required this.brokerId,
    required this.leadId,
    required this.status,
    //  this.surveyEntry,
    required this.createdAt,
    required this.updatedAt,
  });
  late final  id;
  late final  rewardAccountId;
  late final String action;
  late final  itemId;
  late final String transactionType;
  late final  points;
  late final  brokerId;
  late final  leadId;
  late final  status;
  // late final Null surveyEntry;
  late final String createdAt;
  late final String updatedAt;
  
  RewardCredit.fromJson(Map<String, dynamic> json){
    id = json['id'];
    rewardAccountId = json['reward_account_id'];
    action = json['action'];
    itemId = json['item_id'];
    transactionType = json['transaction_type'];
    points = json['points'];
    brokerId = json['broker_id'];
    leadId = json['lead_id'];
    status = json['status'];
   
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reward_account_id'] = rewardAccountId;
    _data['action'] = action;
    _data['item_id'] = itemId;
    _data['transaction_type'] = transactionType;
    _data['points'] = points;
    _data['broker_id'] = brokerId;
    _data['lead_id'] = leadId;
    _data['status'] = status;
    // _data['survey_entry'] = surveyEntry;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}