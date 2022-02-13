class CarMakeModelList {
  CarMakeModelList({
    required this.status,
    required this.response,
  });
  late final int status;
  late final List<Response> response;
  
  CarMakeModelList.fromJson(Map<String, dynamic> json){
    status = json['status'];
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response'] = response.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Response {
  Response({
    required this.modelId,
    required this.model,
    required this.makeId,
    required this.status,
  });
  late final  modelId;
  late final  model;
  late final  makeId;
  late final  status;
  
  Response.fromJson(Map<String, dynamic> json){
    modelId = json['model_id'];
    model = json['model'];
    makeId = json['make_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['model_id'] = modelId;
    _data['model'] = model;
    _data['make_id'] = makeId;
    _data['status'] = status;
    return _data;
  }
}