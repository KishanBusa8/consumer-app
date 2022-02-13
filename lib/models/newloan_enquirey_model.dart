class NewLoanEnquiryModel {
  NewLoanEnquiryModel({
    required this.loan,
    required this.brokerDetail,
    required this.consumerType,
  });
  late final Loan loan;
  late final String brokerDetail;
  late final String consumerType;

  NewLoanEnquiryModel.fromJson(Map<String, dynamic> json){
    loan = Loan.fromJson(json['loan']);
    brokerDetail = json['broker_detail'];
    consumerType = json['consumer_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loan'] = loan.toJson();
    _data['broker_detail'] = brokerDetail;
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
    this.productName,
    this.purchasePrice,
    this.repaymentYears,
    required this.leadType,
    required this.productType,
    required this.loanType,
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
    required this.bankStatementRequest,
    required this.leadDetailsMystroRequested,
    required this.mystroServicesList,
    required this.approvedLoanAmount,
    required this.settledDataByConsumer,
    required this.loantypeLabel,
    required this.allActivities,
  });
  late final dynamic leadId;
  late final dynamic status;
  late final dynamic email;
  late final dynamic consumerId;
  late final dynamic currentLender;
  late final dynamic loanAmount;
  late final dynamic applicationNumber;
  late final dynamic secondInterestRate;
  late final dynamic productName;
  late final dynamic purchasePrice;
  late final dynamic repaymentYears;
  late final dynamic leadType;
  late final dynamic productType;
  late final dynamic loanType;
  late final dynamic conditionalApprovalExpiryDate;
  late final dynamic unconditionalApprovalExpiryDate;
  late final dynamic fixedYears;
  late final dynamic leadBrokerUserID;
  late final dynamic createdAt;
  late final dynamic uniqueId;
  late final dynamic settlementType;
  late final dynamic repaymentType;
  late final dynamic closingLender;
  late final dynamic closingReason;
  late final dynamic interestType;
  late final dynamic blid;
  late final dynamic closingStatus;
  late final dynamic approvedType;
  late final dynamic closingLoanAmount;
  late final dynamic closingRoi;
  late final dynamic actualSettlementDate;
  late final dynamic settlementDate;
  late final dynamic approvedDate;
  late final dynamic estimatedApprovalDate;
  late final dynamic lodgedDate;
  late final dynamic brokerId;
  late final dynamic previousRoi;
  late final dynamic documents;
  late final dynamic bankStatementRequest;
  late final dynamic leadDetailsMystroRequested;
  late final List<dynamic> mystroServicesList;
  late final dynamic approvedLoanAmount;
  late final dynamic settledDataByConsumer;
  late final dynamic loantypeLabel;
  late final dynamic allActivities;

  Loan.fromJson(Map<String, dynamic> json){
    leadId = json['lead_id']??'';
    status = json['status']??'';
    email = json['email']??'';
    consumerId = json['consumer_id']??'';
    currentLender = json['current_lender']??'';
    loanAmount = json['loan_amount']??'';
    applicationNumber = json['application_number']??'';
    secondInterestRate = json['second_interest_rate']??'';
    productName = json['product_name']??'';
    purchasePrice = json['purchase_price']??'';
    repaymentYears = json['repayment_years']??'';
    leadType = json['lead_type']??'';
    productType = json['product_type']??'';
    loanType = json['loan_type']??'';
    conditionalApprovalExpiryDate = json['conditional_approval_expiry_date']??'';
    unconditionalApprovalExpiryDate = json['unconditional_approval_expiry_date']??'';
    fixedYears = json['fixed_years']??'';
    leadBrokerUserID = json['lead_broker_userID']??'';
    createdAt = json['created_at']??'';
    uniqueId = json['unique_id']??'';
    settlementType = json['settlement_type']??'';
    repaymentType = json['repayment_type']??'';
    closingLender = json['closing_lender']??'';
    closingReason = json['closing_reason']??'';
    interestType = json['interest_type']??'';
    blid = json['blid']??'';
    closingStatus = json['closing_status']??'';
    approvedType = json['approved_type']??'';
    closingLoanAmount = json['closing_loan_amount']??'';
    closingRoi = json['closing_roi']??'';
    actualSettlementDate = json['actual_settlement_date']??'';
    settlementDate = json['settlement_date']??'';
    approvedDate = json['approved_date']??'';
    estimatedApprovalDate = json['estimated_approval_date']??'';
    lodgedDate = json['lodged_date']??'';
    brokerId = json['broker_id']??'';
    previousRoi = json['previous_roi']??'';
    documents = json['documents']??'';
    bankStatementRequest = json['bank_statement_request']??'';
    leadDetailsMystroRequested = json['lead_details_mystro_requested']??'';
    mystroServicesList = List.castFrom<dynamic, dynamic>(json['mystro_services_list']);
    approvedLoanAmount = json['approved_loan_amount']??'';
    settledDataByConsumer = json['settled_data_by_consumer']??'';
    loantypeLabel = json['loantypeLabel']??'';
    allActivities = json['allActivities']??'';
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
    _data['allActivities'] = allActivities;
    return _data;
  }
}