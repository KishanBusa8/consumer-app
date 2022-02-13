class HashConvenyancingListModel {
  HashConvenyancingListModel({
    required this.hashautoList,
  });
  late final List hashautoList;
  
  HashConvenyancingListModel.fromJson(Map<String, dynamic> json){
    hashautoList = List.from(json['hashauto_list']).map((e)=>HashautoList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hashauto_list'] = hashautoList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class HashautoList {
  HashautoList({
     this.id,
     this.referenceId,
     this.leadId,
     this.agentId,
     this.agentName,
     this.managerId,
     this.managerName,
     this.userType,
     this.submittedBy,
     this.type,
     this.firstName,
     this.lastName,
     this.email,
     this.phone,
     this.postcodeS,
     this.state,
     this.suburb,
     this.postcode,
     this.postcodeId,
     this.condition,
     this.make,
     this.model,
     this.bodyType,
     this.kilometers,
     this.years,
     this.badge,
     this.comments,
     this.status,
     this.uniqueId,
     this.createdAt,
     this.updatedAt,
     this.statusname,
     this.mobilenew,
  });
  late final  id;
  late final  referenceId;
  late final  leadId;
  late final  agentId;
  late final  agentName;
  late final  managerId;
  late final  managerName;
  late final  userType;
  late final  submittedBy;
  late final  type;
  late final  firstName;
  late final  lastName;
  late final  email;
  late final  phone;
  late final  postcodeS;
  late final  state;
  late final  suburb;
  late final  postcode;
  late final  postcodeId;
  late final  condition;
  late final  make;
  late final  model;
  late final  bodyType;
  late final  kilometers;
  late final  years;
  late final  badge;
  late final  comments;
  late final  status;
  late final  uniqueId;
  late final  createdAt;
  late final  updatedAt;
  late final  statusname;
  late final  mobilenew;
  
  HashautoList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    referenceId = json['reference_id'];
    leadId = json['lead_id'];
    agentId = json['agent_id'];
    agentName = json['agent_name'];
    managerId = json['manager_id'];
    managerName = json['manager_name'];
    userType = json['user_type'];
    submittedBy = json['submitted_by'];
    type = json['type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    postcodeS = json['postcode_s'];
    state = json['state'];
    suburb = json['suburb'];
    postcode = json['postcode'];
    postcodeId = json['postcode_id'];
    condition = json['condition'];
    make = json['make'];
    model = json['model'];
    bodyType = json['body_type'];
    kilometers = json['kilometers'];
    years = json['years'];
    badge = json['badge'];
    comments = json['comments'];
    status = json['status'];
    uniqueId = json['unique_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statusname = json['statusname'];
    mobilenew = json['mobilenew'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reference_id'] = referenceId;
    _data['lead_id'] = leadId;
    _data['agent_id'] = agentId;
    _data['agent_name'] = agentName;
    _data['manager_id'] = managerId;
    _data['manager_name'] = managerName;
    _data['user_type'] = userType;
    _data['submitted_by'] = submittedBy;
    _data['type'] = type;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['postcode_s'] = postcodeS;
    _data['state'] = state;
    _data['suburb'] = suburb;
    _data['postcode'] = postcode;
    _data['postcode_id'] = postcodeId;
    _data['condition'] = condition;
    _data['make'] = make;
    _data['model'] = model;
    _data['body_type'] = bodyType;
    _data['kilometers'] = kilometers;
    _data['years'] = years;
    _data['badge'] = badge;
    _data['comments'] = comments;
    _data['status'] = status;
    _data['unique_id'] = uniqueId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['statusname'] = statusname;
    _data['mobilenew'] = mobilenew;
    return _data;
  }
}

class HashConveyacingRawList {
  HashConveyacingRawList({
    required this.hashconveyacingList,
  });
  late final List<dynamic> hashconveyacingList;
  
  HashConveyacingRawList.fromJson(Map<String, dynamic> json){
    hashconveyacingList = List.castFrom<dynamic, dynamic>(json['hashconveyacing_list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hashconveyacing_list'] = hashconveyacingList;
    return _data;
  }
}