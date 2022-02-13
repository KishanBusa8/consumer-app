class HashConnectListModel {
  HashConnectListModel({
    required this.status,
    required this.hashconnectList,
  });
  late final int status;
  late final List<HashconnectList> hashconnectList;
  HashConnectListModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    hashconnectList = List.from(json['hashconnect_list']).map((e)=>HashconnectList.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['hashconnect_list'] = hashconnectList.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class HashconnectList {
  HashconnectList({
    required this.id,
    required this.referenceId,
    required this.leadId,
    required this.agentId,
    required this.agentName,
    required this.userType,
    this.uniqueId,
    required this.submittedBy,
    required this.managerId,
    required this.managerName,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.moveIndate,
    required this.address,
    required this.streetNumber,
    required this.streetName,
    required this.streetType,
    required this.suburb,
    this.postcodeId,
    required this.postcode,
    required this.postcodeS,
    required this.state,
    required this.message,
    required this.termsAndConditions,
    required this.status,
    this.blReferrerId,
    this.facilities,
    required this.createdAt,
    required this.updatedAt,
    required this.statusname,
  });
  late final int id;
  late final String referenceId;
  late final int leadId;
  late final String agentId;
  late final String agentName;
  late final String userType;
  late final String? uniqueId;
  late final String submittedBy;
  late final String managerId;
  late final String managerName;
  late final String title;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final String dateOfBirth;
  late final String moveIndate;
  late final String address;
  late final String streetNumber;
  late final String streetName;
  late final String streetType;
  late final String suburb;
  late final int? postcodeId;
  late final int postcode;
  late final String postcodeS;
  late final String state;
  late final String message;
  late final int termsAndConditions;
  late final int status;
  late final Null blReferrerId;
  late final Null facilities;
  late final String createdAt;
  late final String updatedAt;
  late final String statusname;
  HashconnectList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    referenceId = json['reference_id'];
    leadId = json['lead_id'];
    agentId = json['agent_id'];
    agentName = json['agent_name'];
    userType = json['user_type'];
    uniqueId = json['unique_id'] ??'';
    submittedBy = json['submitted_by'];
    managerId = json['manager_id'];
    managerName = json['manager_name'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    moveIndate = json['move_indate'];
    address = json['address'];
    streetNumber = json['street_number'];
    streetName = json['street_name'];
    streetType = json['street_type'];
    suburb = json['suburb'];
    postcodeId = null;
    postcode = json['postcode'];
    postcodeS = json['postcode_s'];
    state = json['state'];
    message = json['message'];
    termsAndConditions = json['terms_and_conditions'];
    status = json['status'];
    blReferrerId = null;
    facilities = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statusname = json['statusname'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reference_id'] = referenceId;
    _data['lead_id'] = leadId;
    _data['agent_id'] = agentId;
    _data['agent_name'] = agentName;
    _data['user_type'] = userType;
    _data['unique_id'] = uniqueId;
    _data['submitted_by'] = submittedBy;
    _data['manager_id'] = managerId;
    _data['manager_name'] = managerName;
    _data['title'] = title;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['date_of_birth'] = dateOfBirth;
    _data['move_indate'] = moveIndate;
    _data['address'] = address;
    _data['street_number'] = streetNumber;
    _data['street_name'] = streetName;
    _data['street_type'] = streetType;
    _data['suburb'] = suburb;
    _data['postcode_id'] = postcodeId;
    _data['postcode'] = postcode;
    _data['postcode_s'] = postcodeS;
    _data['state'] = state;
    _data['message'] = message;
    _data['terms_and_conditions'] = termsAndConditions;
    _data['status'] = status;
    _data['bl_referrer_id'] = blReferrerId;
    _data['facilities'] = facilities;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['statusname'] = statusname;
    return _data;
  }
}