class CarMakeModel {
  CarMakeModel({
    required this.status,
    required this.response,
  });
  late final int status;
  late final List<Response> response;
  
  CarMakeModel.fromJson(Map<String, dynamic> json){
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
    required this.makeId,
    required this.make,

  });
  late final int makeId;
  late final String make;

  
  Response.fromJson(Map<String, dynamic> json){
    makeId = json['make_id'];
    make = json['make'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['make_id'] = makeId;
    _data['make'] = make;
    return _data;
  }
}