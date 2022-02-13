class ConsumerDocumentListModel {
  ConsumerDocumentListModel({
    required this.documents,
  });
  late final List<Documents> documents;
  
  ConsumerDocumentListModel.fromJson(Map<String, dynamic> json){
    documents = List.from(json['documents']).map((e)=>Documents.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['documents'] = documents.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Documents {
  Documents({
    required this.id,
    required this.metaValue,
    required this.metaName,
    required this.updatedAt,
    required this.documentName,
    required this.documentUrl,
    required this.documentShared,
    required this.sharedbroker,
  });
  late final int id;
  late final String metaValue;
  late final String metaName;
  late final String updatedAt;
  late final String documentName;
  late final String documentUrl;
  late final bool documentShared;
  late final  sharedbroker;
  
  Documents.fromJson(Map<String, dynamic> json){
    id = json['id'];
    metaValue = json['meta_value'];
    metaName = json['meta_name'];
    updatedAt = json['updated_at'];
    documentName = json['document_name'];
    documentUrl = json['document_url'];
    documentShared = json['document_shared'];
    sharedbroker = json['sharedbroker'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['meta_value'] = metaValue;
    _data['meta_name'] = metaName;
    _data['updated_at'] = updatedAt;
    _data['document_name'] = documentName;
    _data['document_url'] = documentUrl;
    _data['document_shared'] = documentShared;
    _data['sharedbroker'] = sharedbroker;
    return _data;
  }
}