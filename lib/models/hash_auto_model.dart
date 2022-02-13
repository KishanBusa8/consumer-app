class HashautoListingModel {
  HashautoListingModel({
    required this.status,
    required this.hashautoList,
  });
  late final int status;
  late final List<HashautoList> hashautoList;
  HashautoListingModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    hashautoList = List.from(json['hashauto_list']).map((e)=>HashautoList.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['hashauto_list'] = hashautoList.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class HashautoList {
  HashautoList({
    required this.id,
    required this.referenceId,
    required this.leadId,
    required this.agentId,
    required this.agentName,
    required this.managerId,
    required this.managerName,
    required this.userType,
    required this.submittedBy,
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.postcodeS,
    required this.state,
    required this.suburb,
    required this.postcode,
    required this.postcodeId,
    required this.condition,
    required this.make,
    required this.model,
    this.bodyType,
    this.kilometers,
    this.years,
    required this.badge,
    required this.comments,
    required this.status,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
    required this.statusname,
    required this.mobilenew,
  });
  late final int id;
  late final String referenceId;
  late final int leadId;
  late final String agentId;
  late final String agentName;
  late final String managerId;
  late final String managerName;
  late final String userType;
  late final String submittedBy;
  late final String type;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final String postcodeS;
  late final String state;
  late final String suburb;
  late final int postcode;
  late final int postcodeId;
  late final String condition;
  late final String make;
  late final String model;
  late final String? bodyType;
  late final String? kilometers;
  late final String? years;
  late final String badge;
  late final String comments;
  late final int status;
  late final String uniqueId;
  late final String createdAt;
  late final String updatedAt;
  late final String statusname;
  late final String mobilenew;
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
    bodyType = null;
    kilometers = null;
    years = null;
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