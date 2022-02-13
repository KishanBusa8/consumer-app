class FetchLoanModel {
  FetchLoanModel({
    required this.loan,
    required this.brokerDetail,
    required this.consumerType,
  });
  late final Loan loan;
  late final BrokerDetail brokerDetail;
  late final String consumerType;
  FetchLoanModel.fromJson(Map<String, dynamic> json){
    loan = Loan.fromJson(json['loan']);
    brokerDetail = BrokerDetail.fromJson(json['broker_detail']);
    consumerType = json['consumer_type'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loan'] = loan.toJson();
    _data['broker_detail'] = brokerDetail.toJson();
    _data['consumer_type'] = consumerType;
    return _data;
  }
}
class Loan {
  Loan({
    required this.leadId,
    required this.status,
    required this.email,
    required this.consumerId,
    this.currentLender,
    required this.loanAmount,
    this.applicationNumber,
    this.secondInterestRate,
    this.productName,
    this.purchasePrice,
    this.repaymentYears,
    required this.leadType,
    required this.productType,
    required this.loanType,
    this.conditionalApprovalExpiryDate,
    this.unconditionalApprovalExpiryDate,
    this.fixedYears,
    required this.leadBrokerUserID,
    required this.createdAt,
    required this.uniqueId,
    this.settlementType,
    this.repaymentType,
    required this.closingLender,
    this.closingReason,
    this.interestType,
    required this.blid,
    required this.closingStatus,
    this.approvedType,
    this.closingLoanAmount,
    required this.closingRoi,
    this.actualSettlementDate,
    this.settlementDate,
    this.approvedDate,
    this.estimatedApprovalDate,
    this.lodgedDate,
    required this.brokerId,
    this.previousRoi,
    required this.documents,
    required this.bankStatementRequest,
    required this.bankStatementIframeLink,
    required this.leadDetailsMystroRequested,
    required this.mystroServicesList,
    required this.approvedLoanAmount,
    required this.settledDataByConsumer,
    required this.loantypeLabel,
    required this.allActivities,
  });
  late final int leadId;
  late final int status;
  late final String email;
  late final int consumerId;
  late final dynamic currentLender;
  late final String loanAmount;
  late final dynamic applicationNumber;
  late final dynamic secondInterestRate;
  late final dynamic productName;
  late final dynamic purchasePrice;
  late final dynamic repaymentYears;
  late final String leadType;
  late final String productType;
  late final String loanType;
  late final dynamic conditionalApprovalExpiryDate;
  late final dynamic unconditionalApprovalExpiryDate;
  late final dynamic fixedYears;
  late final int leadBrokerUserID;
  late final String createdAt;
  late final String uniqueId;
  late final dynamic settlementType;
  late final dynamic repaymentType;
  late final String closingLender;
  late final dynamic closingReason;
  late final dynamic interestType;
  late final int blid;
  late final String closingStatus;
  late final dynamic approvedType;
  late final dynamic closingLoanAmount;
  late final String closingRoi;
  late final dynamic actualSettlementDate;
  late final dynamic settlementDate;
  late final dynamic approvedDate;
  late final dynamic estimatedApprovalDate;
  late final dynamic lodgedDate;
  late final int brokerId;
  late final dynamic previousRoi;
  late final int documents;
  late final bool bankStatementRequest;
  late final String bankStatementIframeLink;
  late final bool leadDetailsMystroRequested;
  late final List<MystroServicesList> mystroServicesList;
  late final String approvedLoanAmount;
  late final String settledDataByConsumer;
  late final String loantypeLabel;
  late final List<AllActivities> allActivities;
  Loan.fromJson(Map<String, dynamic> json){
    leadId = json['lead_id'];
    status = json['status'];
    email = json['email'];
    consumerId = json['consumer_id'];
    currentLender = null ?? '';
    loanAmount = json['loan_amount'];
    applicationNumber = null ?? '';
    secondInterestRate = null ?? '';
    productName = null?? '';
    purchasePrice = null?? '';
    repaymentYears = null?? '';
    leadType = json['lead_type'];
    productType = json['product_type'];
    loanType = json['loan_type'];
    conditionalApprovalExpiryDate = null??'';
    unconditionalApprovalExpiryDate = null??'';
    fixedYears = null??'';
    leadBrokerUserID = json['lead_broker_userID'];
    createdAt = json['created_at'];
    uniqueId = json['unique_id'];
    settlementType = null ??'';
    repaymentType = null??'';
    closingLender = json['closing_lender'];
    closingReason = null??'';
    interestType = null??'';
    blid = json['blid'];
    closingStatus = json['closing_status'];
    approvedType = null??'';
    closingLoanAmount = null??'';
    closingRoi = json['closing_roi'];
    actualSettlementDate = null??'';
    settlementDate = null??'';
    approvedDate = null??'';
    estimatedApprovalDate = null??"";
    lodgedDate = null??'';
    brokerId = json['broker_id'];
    previousRoi = null??'';
    documents = json['documents'];
    bankStatementRequest = json['bank_statement_request'];
    bankStatementIframeLink = json['bank_statement_iframe_link'];
    leadDetailsMystroRequested = json['lead_details_mystro_requested'];
    mystroServicesList = List.from(json['mystro_services_list']).map((e)=>MystroServicesList.fromJson(e)).toList();
    approvedLoanAmount = json['approved_loan_amount'];
    settledDataByConsumer = json['settled_data_by_consumer'];
    loantypeLabel = json['loantypeLabel'];
    allActivities = List.from(json['allActivities']).map((e)=>AllActivities.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lead_id'] = leadId;
    _data['status'] = status;
    _data['email'] = email;
    _data['consumer_id'] = consumerId;
    _data['current_lender'] = currentLender;
    _data['loan_amount'] = loanAmount;
    _data['application_number'] = applicationNumber;
    _data['second_interest_rate'] = secondInterestRate;
    _data['product_name'] = productName;
    _data['purchase_price'] = purchasePrice;
    _data['repayment_years'] = repaymentYears;
    _data['lead_type'] = leadType;
    _data['product_type'] = productType;
    _data['loan_type'] = loanType;
    _data['conditional_approval_expiry_date'] = conditionalApprovalExpiryDate;
    _data['unconditional_approval_expiry_date'] = unconditionalApprovalExpiryDate;
    _data['fixed_years'] = fixedYears;
    _data['lead_broker_userID'] = leadBrokerUserID;
    _data['created_at'] = createdAt;
    _data['unique_id'] = uniqueId;
    _data['settlement_type'] = settlementType;
    _data['repayment_type'] = repaymentType;
    _data['closing_lender'] = closingLender;
    _data['closing_reason'] = closingReason;
    _data['interest_type'] = interestType;
    _data['blid'] = blid;
    _data['closing_status'] = closingStatus;
    _data['approved_type'] = approvedType;
    _data['closing_loan_amount'] = closingLoanAmount;
    _data['closing_roi'] = closingRoi;
    _data['actual_settlement_date'] = actualSettlementDate;
    _data['settlement_date'] = settlementDate;
    _data['approved_date'] = approvedDate;
    _data['estimated_approval_date'] = estimatedApprovalDate;
    _data['lodged_date'] = lodgedDate;
    _data['broker_id'] = brokerId;
    _data['previous_roi'] = previousRoi;
    _data['documents'] = documents;
    _data['bank_statement_request'] = bankStatementRequest;
    _data['bank_statement_iframe_link'] = bankStatementIframeLink;
    _data['lead_details_mystro_requested'] = leadDetailsMystroRequested;
    _data['mystro_services_list'] = mystroServicesList.map((e)=>e.toJson()).toList();
    _data['approved_loan_amount'] = approvedLoanAmount;
    _data['settled_data_by_consumer'] = settledDataByConsumer;
    _data['loantypeLabel'] = loantypeLabel;
    _data['allActivities'] = allActivities.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class MystroServicesList {
  MystroServicesList({
    required this.title,
    required this.id,
    required this.partials,
    required this.iframeLink,
  });
  late final String title;
  late final String id;
  late final List<dynamic> partials;
  late final String iframeLink;
  MystroServicesList.fromJson(Map<String, dynamic> json){
    title = json['title'];
    id = json['id'];
    partials = List.castFrom<dynamic, dynamic>(json['partials']);
    iframeLink = json['iframe_link'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['id'] = id;
    _data['partials'] = partials;
    _data['iframe_link'] = iframeLink;
    return _data;
  }
}
class AllActivities {
  AllActivities({
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.timestamp,
  });
  late final String type;
  late final String title;
  late final String description;
  late final String createdAt;
  late final String timestamp;
  AllActivities.fromJson(Map<String, dynamic> json){
    type = json['type'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    timestamp = json['timestamp'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['title'] = title;
    _data['description'] = description;
    _data['created_at'] = createdAt;
    _data['timestamp'] = timestamp;
    return _data;
  }
}
class BrokerDetail {
  BrokerDetail({
    required this.id,
    required this.name,
    required this.mobile,
    required this.profilePic,
    required this.onlineStatus,
    required this.mobilenew,
  });
  late final int id;
  late final String name;
  late final String mobile;
  late final String profilePic;
  late final bool onlineStatus;
  late final String mobilenew;
  BrokerDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    profilePic = json['profile_pic'];
    onlineStatus = json['online_status'];
    mobilenew = json['mobilenew'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['mobile'] = mobile;
    _data['profile_pic'] = profilePic;
    _data['online_status'] = onlineStatus;
    _data['mobilenew'] = mobilenew;
    return _data;
  }
}