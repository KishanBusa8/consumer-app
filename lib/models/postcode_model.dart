class PostCodeModel {
  PostCodeModel({
    required this.postcodes,
  });
  late final List<Postcodes> postcodes;
  PostCodeModel.fromJson(Map<String, dynamic> json){
    postcodes = List.from(json['postcodes']).map((e)=>Postcodes.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['postcodes'] = postcodes.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class Postcodes {
  Postcodes({
    required this.id,
    required this.postcode,
    required this.locality,
    required this.statecode,
    required this.region1,
  });
  late final int id;
  late final String postcode;
  late final String locality;
  late final String statecode;
  late final String region1;
  Postcodes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    postcode = json['postcode'];
    locality = json['locality'];
    statecode = json['statecode'];
    region1 = json['region1'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['postcode'] = postcode;
    _data['locality'] = locality;
    _data['statecode'] = statecode;
    _data['region1'] = region1;
    return _data;
  }
}