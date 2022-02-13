class LodgedEnquiryModel {
  LodgedEnquiryModel({
    required this.loan,
    required this.brokerDetail,
    required this.consumerType,
  });
  late final Loan loan;
  late final BrokerDetail brokerDetail;
  late final String consumerType;

  LodgedEnquiryModel.fromJson(Map<String, dynamic> json){
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
    required this.currentLender,
    required this.loanAmount,
    this.applicationNumber,
    this.secondInterestRate,
    required this.productName,
    required this.purchasePrice,
    this.repaymentYears,
    required this.leadType,
    this.productType,
    required this.loanType,
    required this.conditionalApprovalExpiryDate,
    required this.unconditionalApprovalExpiryDate,
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
    required this.closingLoanAmount,
    required this.closingRoi,
    this.actualSettlementDate,
    this.settlementDate,
    this.approvedDate,
    required this.estimatedApprovalDate,
    required this.lodgedDate,
    required this.brokerId,
    required this.previousRoi,
    required this.documents,
    required this.bankStatementRequest,
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
  late final String currentLender;
  late final String loanAmount;
  late final Null applicationNumber;
  late final Null secondInterestRate;
  late final String productName;
  late final String purchasePrice;
  late final Null repaymentYears;
  late final String leadType;
  late final Null productType;
  late final String loanType;
  late final String conditionalApprovalExpiryDate;
  late final String unconditionalApprovalExpiryDate;
  late final Null fixedYears;
  late final int leadBrokerUserID;
  late final String createdAt;
  late final String uniqueId;
  late final Null settlementType;
  late final Null repaymentType;
  late final String closingLender;
  late final Null closingReason;
  late final Null interestType;
  late final int blid;
  late final String closingStatus;
  late final Null approvedType;
  late final String closingLoanAmount;
  late final String closingRoi;
  late final Null actualSettlementDate;
  late final Null settlementDate;
  late final Null approvedDate;
  late final String estimatedApprovalDate;
  late final String lodgedDate;
  late final int brokerId;
  late final String previousRoi;
  late final int documents;
  late final bool bankStatementRequest;
  late final bool leadDetailsMystroRequested;
  late final List<dynamic> mystroServicesList;
  late final String approvedLoanAmount;
  late final String settledDataByConsumer;
  late final String loantypeLabel;
  late final List<AllActivities> allActivities;

  Loan.fromJson(Map<String, dynamic> json){
    leadId = json['lead_id'];
    status = json['status'];
    email = json['email'];
    consumerId = json['consumer_id'];
    currentLender = json['current_lender'];
    loanAmount = json['loan_amount'];
    applicationNumber = null;
    secondInterestRate = null;
    productName = json['product_name'];
    purchasePrice = json['purchase_price'];
    repaymentYears = null;
    leadType = json['lead_type'];
    productType = null;
    loanType = json['loan_type'];
    conditionalApprovalExpiryDate = json['conditional_approval_expiry_date'];
    unconditionalApprovalExpiryDate = json['unconditional_approval_expiry_date'];
    fixedYears = null;
    leadBrokerUserID = json['lead_broker_userID'];
    createdAt = json['created_at'];
    uniqueId = json['unique_id'];
    settlementType = null;
    repaymentType = null;
    closingLender = json['closing_lender'];
    closingReason = null;
    interestType = null;
    blid = json['blid'];
    closingStatus = json['closing_status'];
    approvedType = null;
    closingLoanAmount = json['closing_loan_amount'];
    closingRoi = json['closing_roi'];
    actualSettlementDate = null;
    settlementDate = null;
    approvedDate = null;
    estimatedApprovalDate = json['estimated_approval_date'];
    lodgedDate = json['lodged_date'];
    brokerId = json['broker_id'];
    previousRoi = json['previous_roi'];
    documents = json['documents'];
    bankStatementRequest = json['bank_statement_request'];
    leadDetailsMystroRequested = json['lead_details_mystro_requested'];
    mystroServicesList = List.castFrom<dynamic, dynamic>(json['mystro_services_list']);
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
    _data['lead_details_mystro_requested'] = leadDetailsMystroRequested;
    _data['mystro_services_list'] = mystroServicesList;
    _data['approved_loan_amount'] = approvedLoanAmount;
    _data['settled_data_by_consumer'] = settledDataByConsumer;
    _data['loantypeLabel'] = loantypeLabel;
    _data['allActivities'] = allActivities.map((e)=>e.toJson()).toList();
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