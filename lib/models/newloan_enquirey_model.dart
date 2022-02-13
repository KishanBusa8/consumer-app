class NewLoanEnquireyModel {
  NewLoanEnquireyModel({
    required this.loan,
 
    required this.consumerType,
  });
  late final Loan loan;
 
  late final String consumerType;
  
  NewLoanEnquireyModel.fromJson(Map<String, dynamic> json){
    loan = Loan.fromJson(json['loan']);
  
    consumerType = json['consumer_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loan'] = loan.toJson();
  
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
     this.loanType,
     this.conditionalApprovalExpiryDate,
     this.unconditionalApprovalExpiryDate,
     this.fixedYears,
     this.leadBrokerUserID,
    required this.createdAt,
    required this.uniqueId,
     this.settlementType,
     this.repaymentType,
     this.closingLender,
     this.closingReason,
     this.interestType,
     this.blid,
     this.closingStatus,
     this.approvedType,
     this.closingLoanAmount,
     this.closingRoi,
     this.actualSettlementDate,
     this.settlementDate,
     this.approvedDate,
     this.estimatedApprovalDate,
     this.lodgedDate,
     this.brokerId,
     this.previousRoi,
    required this.documents,
    required this.bankStatement,
    required this.leadDetailsMystroRequested,
    required this.approvedLoanAmount,
    required this.settledDataByConsumer,
    required this.loantypeLabel,
    required this.allActivities,
  });
  late final int leadId;
  late final int status;
  late final String email;
  late final int consumerId;
  late final Null currentLender;
  late final String loanAmount;
  late final Null applicationNumber;
  late final Null secondInterestRate;
  late final Null productName;
  late final Null purchasePrice;
  late final Null repaymentYears;
  late final String leadType;
  late final String productType;
  late final Null loanType;
  late final Null conditionalApprovalExpiryDate;
  late final Null unconditionalApprovalExpiryDate;
  late final Null fixedYears;
  late final Null leadBrokerUserID;
  late final String createdAt;
  late final String uniqueId;
  late final Null settlementType;
  late final Null repaymentType;
  late final Null closingLender;
  late final Null closingReason;
  late final Null interestType;
  late final Null blid;
  late final Null closingStatus;
  late final Null approvedType;
  late final Null closingLoanAmount;
  late final Null closingRoi;
  late final Null actualSettlementDate;
  late final Null settlementDate;
  late final Null approvedDate;
  late final Null estimatedApprovalDate;
  late final Null lodgedDate;
  late final Null brokerId;
  late final Null previousRoi;
  late final int documents;
  late final String bankStatement;
  late final bool leadDetailsMystroRequested;
  late final String approvedLoanAmount;
  late final String settledDataByConsumer;
  late final String loantypeLabel;
  late final String allActivities;
  
  Loan.fromJson(Map<String, dynamic> json){
    leadId = json['lead_id'];
    status = json['status'];
    email = json['email'];
    consumerId = json['consumer_id'];
    currentLender = null;
    loanAmount = json['loan_amount'];
    applicationNumber = null;
    secondInterestRate = null;
    productName = null;
    purchasePrice = null;
    repaymentYears = null;
    leadType = json['lead_type'];
    productType = json['product_type'];
    loanType = null;
    conditionalApprovalExpiryDate = null;
    unconditionalApprovalExpiryDate = null;
    fixedYears = null;
    leadBrokerUserID = null;
    createdAt = json['created_at'];
    uniqueId = json['unique_id'];
    settlementType = null;
    repaymentType = null;
    closingLender = null;
    closingReason = null;
    interestType = null;
    blid = null;
    closingStatus = null;
    approvedType = null;
    closingLoanAmount = null;
    closingRoi = null;
    actualSettlementDate = null;
    settlementDate = null;
    approvedDate = null;
    estimatedApprovalDate = null;
    lodgedDate = null;
    brokerId = null;
    previousRoi = null;
    documents = json['documents'];
    bankStatement = json['bank_statement'];
    leadDetailsMystroRequested = json['lead_details_mystro_requested'];
    approvedLoanAmount = json['approved_loan_amount'];
    settledDataByConsumer = json['settled_data_by_consumer'];
    loantypeLabel = json['loantypeLabel'];
    allActivities = json['allActivities'];
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
    _data['bank_statement'] = bankStatement;
    _data['lead_details_mystro_requested'] = leadDetailsMystroRequested;
    _data['approved_loan_amount'] = approvedLoanAmount;
    _data['settled_data_by_consumer'] = settledDataByConsumer;
    _data['loantypeLabel'] = loantypeLabel;
    _data['allActivities'] = allActivities;
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
  late final  id;
  late final  name;
  late final  mobile;
  late final  profilePic;
  late final  onlineStatus;
  late final  mobilenew;
  
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