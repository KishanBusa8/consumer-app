class AddHomeLoanModel {
  AddHomeLoanModel({
    required this.productType,
    required this.loanType,
    required this.ownerOrInvestmentProperty,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.estimatedPropertyValue,
    required this.loanAmount,
    required this.postcodeS,
    required this.postcodeId,
    required this.suburb,
    required this.state,
    required this.employmentStatus,
    required this.contactTime,
    required this.contactDay,
    required this.termsAndConditions,
    required this.postcode,
    required this.timezoneoffset,
  });
  late final String productType;
  late final String loanType;
  late final String ownerOrInvestmentProperty;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final int mobile;
  late final int estimatedPropertyValue;
  late final int loanAmount;
  late final String postcodeS;
  late final int postcodeId;
  late final String suburb;
  late final String state;
  late final String employmentStatus;
  late final String contactTime;
  late final String contactDay;
  late final int termsAndConditions;
  late final int postcode;
  late final int timezoneoffset;

  AddHomeLoanModel.fromJson(Map<String, dynamic> json) {
    productType = json['product_type'];
    loanType = json['loan_type'];
    ownerOrInvestmentProperty = json['owner_or_investment_property'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['convert_mobile'];
    estimatedPropertyValue = json['estimated_property_value'];
    loanAmount = json['loan_amount'];
    postcodeS = json['postcode_s'];
    postcodeId = json['postcode_id'];
    suburb = json['suburb'];
    state = json['state'];
    employmentStatus = json['employment_status'];
    contactTime = json['contact_time'];
    contactDay = json['contact_day'];
    termsAndConditions = json['terms_and_conditions'];
    postcode = json['postcode'];
    timezoneoffset = json['timezoneoffset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_type'] = productType;
    _data['loan_type'] = loanType;
    _data['owner_or_investment_property'] = ownerOrInvestmentProperty;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['estimated_property_value'] = estimatedPropertyValue;
    _data['loan_amount'] = loanAmount;
    _data['postcode_s'] = postcodeS;
    _data['postcode_id'] = postcodeId;
    _data['suburb'] = suburb;
    _data['state'] = state;
    _data['employment_status'] = employmentStatus;
    _data['contact_time'] = contactTime;
    _data['contact_day'] = contactDay;
    _data['terms_and_conditions'] = termsAndConditions;
    _data['postcode'] = postcode;
    _data['timezoneoffset'] = timezoneoffset;
    return _data;
  }
}
