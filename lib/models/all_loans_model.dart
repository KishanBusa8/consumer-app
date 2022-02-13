class ConsumerLoansModel {
  ConsumerLoansModel({
    required this.allLoans,
  });
  late final List<AllLoans> allLoans;

  ConsumerLoansModel.fromJson(Map<String, dynamic> json) {
    allLoans =
        List.from(json['allLoans']).map((e) => AllLoans.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['allLoans'] = allLoans.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AllLoans {
  AllLoans({
    required this.id,
    required this.leadType,
    required this.productType,
    required this.loanAmount,
    this.loanType,
    required this.status,
    this.leadBrokerUserID,
    required this.brokerLeadID,
    required this.createdAt,
    this.closingStatus,
    this.brokerId,
    required this.uniqueId,
    required this.encryptkey,
    required this.loantypeshow,
    required this.createdate,
    required this.statusname,
  });
  late final int id;
  late final String leadType;
  late final String productType;
  late final String loanAmount;
  late final String? loanType;
  late final int status;
  late final Null leadBrokerUserID;
  late final int brokerLeadID;
  late final String createdAt;
  late final Null closingStatus;
  late final Null brokerId;
  late final String uniqueId;
  late final String encryptkey;
  late final String loantypeshow;
  late final String createdate;
  late final String statusname;

  AllLoans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadType = json['lead_type'] ?? "null";
    productType = json['product_type'] ?? "null";
    loanAmount = json['loan_amount'] ?? "null";
    loanType = null;
    status = json['status'];
    leadBrokerUserID = null;
    brokerLeadID = json['broker_lead_ID'];
    createdAt = json['created_at'] ?? "null";
    closingStatus = null;
    brokerId = null;
    uniqueId = json['unique_id'] ?? "null";
    encryptkey = json['encryptkey'] ?? "null";
    loantypeshow = json['loantypeshow'] ?? "null";
    createdate = json['createdate'] ?? "null";
    statusname = json['statusname'] ?? "null";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['lead_type'] = leadType;
    _data['product_type'] = productType;
    _data['loan_amount'] = loanAmount;
    _data['loan_type'] = loanType;
    _data['status'] = status;
    _data['lead_broker_userID'] = leadBrokerUserID;
    _data['broker_lead_ID'] = brokerLeadID;
    _data['created_at'] = createdAt;
    _data['closing_status'] = closingStatus;
    _data['broker_id'] = brokerId;
    _data['unique_id'] = uniqueId;
    _data['encryptkey'] = encryptkey;
    _data['loantypeshow'] = loantypeshow;
    _data['createdate'] = createdate;
    _data['statusname'] = statusname;
    return _data;
  }
}
