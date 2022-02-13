class MyPropertySuggestionsModel {
  MyPropertySuggestionsModel({
    required this.success,
    required this.suggestions,
  });
  late final bool success;
  late final List<Suggestions> suggestions;
  
  MyPropertySuggestionsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    suggestions = List.from(json['suggestions']).map((e)=>Suggestions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['suggestions'] = suggestions.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class AutoGenerate {
  AutoGenerate({
    required this.councilAreaId,
    required this.countryId,
    required this.isActiveProperty,
    required this.isBodyCorporate,
    required this.isUnit,
    required this.localityId,
    required this.postcodeId,
    required this.propertyId,
    required this.stateId,
    required this.streetId,
    required this.suggestion,
    required this.suggestionType,
  });
  late final int councilAreaId;
  late final int countryId;
  late final bool isActiveProperty;
  late final bool isBodyCorporate;
  late final bool isUnit;
  late final int localityId;
  late final int postcodeId;
  late final int propertyId;
  late final int stateId;
  late final int streetId;
  late final String suggestion;
  late final String suggestionType;
  
  AutoGenerate.fromJson(Map<String, dynamic> json){
    councilAreaId = json['councilAreaId'];
    countryId = json['countryId'];
    isActiveProperty = json['isActiveProperty'];
    isBodyCorporate = json['isBodyCorporate'];
    isUnit = json['isUnit'];
    localityId = json['localityId'];
    postcodeId = json['postcodeId'];
    propertyId = json['propertyId'];
    stateId = json['stateId'];
    streetId = json['streetId'];
    suggestion = json['suggestion'];
    suggestionType = json['suggestionType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['councilAreaId'] = councilAreaId;
    _data['countryId'] = countryId;
    _data['isActiveProperty'] = isActiveProperty;
    _data['isBodyCorporate'] = isBodyCorporate;
    _data['isUnit'] = isUnit;
    _data['localityId'] = localityId;
    _data['postcodeId'] = postcodeId;
    _data['propertyId'] = propertyId;
    _data['stateId'] = stateId;
    _data['streetId'] = streetId;
    _data['suggestion'] = suggestion;
    _data['suggestionType'] = suggestionType;
    return _data;
  }
}

class Suggestions { 
  Suggestions({
    required this.councilAreaId,
    required this.countryId,
    required this.isActiveProperty,
    required this.isBodyCorporate,
    required this.isUnit,
    required this.postcodeId,
    required this.stateId,
    required this.suggestion,
    required this.suggestionType,
  });
  late final int councilAreaId;
  late final int countryId;
  late final bool isActiveProperty;
  late final bool isBodyCorporate;
  late final bool isUnit;
  late final int postcodeId;
  late final int stateId;
  late final String suggestion;
  late final String suggestionType;
  
  Suggestions.fromJson(Map<String, dynamic> json){
    councilAreaId = json['councilAreaId'];
    countryId = json['countryId'];
    isActiveProperty = json['isActiveProperty'];
    isBodyCorporate = json['isBodyCorporate'];
    isUnit = json['isUnit'];
    postcodeId = json['postcodeId'];
    stateId = json['stateId'];
    suggestion = json['suggestion'];
    suggestionType = json['suggestionType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['councilAreaId'] = councilAreaId;
    _data['countryId'] = countryId;
    _data['isActiveProperty'] = isActiveProperty;
    _data['isBodyCorporate'] = isBodyCorporate;
    _data['isUnit'] = isUnit;
    _data['postcodeId'] = postcodeId;
    _data['stateId'] = stateId;
    _data['suggestion'] = suggestion;
    _data['suggestionType'] = suggestionType;
    return _data;
  }
}






class PropertySuggestionModel {
  PropertySuggestionModel({
    required this.success,
    required this.suggestions,
  });
  late final bool success;
  late final List<MySuggestions> suggestions;
  
  PropertySuggestionModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    suggestions = List.from(json['suggestions']).map((e)=>MySuggestions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['suggestions'] = suggestions.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class MySuggestions {
  MySuggestions({
    required this.councilAreaId,
    required this.countryId,
    required this.isActiveProperty,
    required this.isBodyCorporate,
    required this.isUnit,
    required this.localityId,
    required this.postcodeId,
    required this.propertyId,
    required this.stateId,
    required this.streetId,
    required this.suggestion,
    required this.suggestionType,
  });
  late final int councilAreaId;
  late final int countryId;
  late final bool isActiveProperty;
  late final bool isBodyCorporate;
  late final bool isUnit;
  late final int localityId;
  late final int postcodeId;
  late final int propertyId;
  late final int stateId;
  late final int streetId;
  late final String suggestion;
  late final String suggestionType;
  
  MySuggestions.fromJson(Map<String, dynamic> json){
    councilAreaId = json['councilAreaId'];
    countryId = json['countryId'];
    isActiveProperty = json['isActiveProperty'];
    isBodyCorporate = json['isBodyCorporate'];
    isUnit = json['isUnit'];
    localityId = json['localityId'];  
    postcodeId = json['postcodeId'];
    propertyId = json['propertyId'] ;
    stateId = json['stateId'];
    streetId = json['streetId'];
    suggestion = json['suggestion'];
    suggestionType = json['suggestionType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['councilAreaId'] = councilAreaId;
    _data['countryId'] = countryId;
    _data['isActiveProperty'] = isActiveProperty;
    _data['isBodyCorporate'] = isBodyCorporate;
    _data['isUnit'] = isUnit;
    _data['localityId'] = localityId;
    _data['postcodeId'] = postcodeId;
    _data['propertyId'] = propertyId ;
    _data['stateId'] = stateId;
    _data['streetId'] = streetId;
    _data['suggestion'] = suggestion;
    _data['suggestionType'] = suggestionType;
    return _data;
  }
}