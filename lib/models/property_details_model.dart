class PropertyDetailsModel {
  PropertyDetailsModel({
    required this.success,
    required this.core,
    required this.images,
    required this.checkPdf,
  });
  late final bool success;
  late final Core core;
  late final Images images;
  late final String checkPdf;
  
  PropertyDetailsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    core = Core.fromJson(json['core']);
    images = Images.fromJson(json['images']);
    checkPdf = json['checkPdf'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['core'] = core.toJson();
    _data['images'] = images.toJson();
    _data['checkPdf'] = checkPdf;
    return _data;
  }
}

class Core {
  Core({
    required this.isActiveProperty,
    required this.propertyType,
    required this.propertySubType,
    required this.beds,
    required this.baths,
    required this.carSpaces,
    required this.lockUpGarages,
    required this.landArea,
    required this.isCalculatedLandArea,
    required this.landAreaSource,
  });
  late final bool isActiveProperty;
  late final String propertyType;
  late final String propertySubType;
  late final int beds;
  late final int baths;
  late final int carSpaces;
  late final int lockUpGarages;
  late final int landArea;
  late final bool isCalculatedLandArea;
  late final String landAreaSource;
  
  Core.fromJson(Map<String, dynamic> json){
    isActiveProperty = json['isActiveProperty'];
    propertyType = json['propertyType'];
    propertySubType = json['propertySubType'];
    beds = json['beds'];
    baths = json['baths'];
    carSpaces = json['carSpaces'];
    lockUpGarages = json['lockUpGarages'];
    landArea = json['landArea'];
    isCalculatedLandArea = json['isCalculatedLandArea'];
    landAreaSource = json['landAreaSource'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isActiveProperty'] = isActiveProperty;
    _data['propertyType'] = propertyType;
    _data['propertySubType'] = propertySubType;
    _data['beds'] = beds;
    _data['baths'] = baths;
    _data['carSpaces'] = carSpaces;
    _data['lockUpGarages'] = lockUpGarages;
    _data['landArea'] = landArea;
    _data['isCalculatedLandArea'] = isCalculatedLandArea;
    _data['landAreaSource'] = landAreaSource;
    return _data;
  }
}

class Images {
  Images({
    // required this.defaultImage,
    required this.secondaryImageList,
    required this.floorPlanImageList,
  });
  // late final List<dynamic> defaultImage;
  late final List<dynamic> secondaryImageList;
  late final List<dynamic> floorPlanImageList;
  
  Images.fromJson(Map<String, dynamic> json){
    // defaultImage = List.castFrom<dynamic, dynamic>(json['defaultImage']);
    secondaryImageList = List.castFrom<dynamic, dynamic>(json['secondaryImageList']);
    floorPlanImageList = List.castFrom<dynamic, dynamic>(json['floorPlanImageList']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['defaultImage'] = defaultImage;
    _data['secondaryImageList'] = secondaryImageList;
    _data['floorPlanImageList'] = floorPlanImageList;
    return _data;
  }
}


// class PropertyDetailsModel {
//   PropertyDetailsModel({
//     required this.success,
//     required this.core,
//     required this.images,
//     required this.checkPdf,
//   });
//   late final bool success;
//   late final Core core;
//   late final Images images;
//   late final String checkPdf;
  
//   PropertyDetailsModel.fromJson(Map<String, dynamic> json){
//     success = json['success'];
//     core = Core.fromJson(json['core']);
//     images = Images.fromJson(json['images']);
//     checkPdf = json['checkPdf'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['core'] = core.toJson();
//     _data['images'] = images.toJson();
//     _data['checkPdf'] = checkPdf;
//     return _data;
//   }
// }

// class Core {
//   Core({
//     required this.isActiveProperty,
//     required this.propertyType,
//     required this.propertySubType,
//     required this.beds,
//     required this.baths,
//     required this.carSpaces,
//     required this.lockUpGarages,
//     required this.landArea,
//     required this.isCalculatedLandArea,
//     required this.landAreaSource,
//   });
//   late final bool isActiveProperty;
//   late final String propertyType;
//   late final String propertySubType;
//   late final int beds;
//   late final int baths;
//   late final int carSpaces;
//   late final int lockUpGarages;
//   late final int landArea;
//   late final bool isCalculatedLandArea;
//   late final String landAreaSource;
  
//   Core.fromJson(Map<String, dynamic> json){
//     isActiveProperty = json['isActiveProperty'];
//     propertyType = json['propertyType'];
//     propertySubType = json['propertySubType'];
//     beds = json['beds'];
//     baths = json['baths'];
//     carSpaces = json['carSpaces'];
//     lockUpGarages = json['lockUpGarages'];
//     landArea = json['landArea'];
//     isCalculatedLandArea = json['isCalculatedLandArea'];
//     landAreaSource = json['landAreaSource'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['isActiveProperty'] = isActiveProperty;
//     _data['propertyType'] = propertyType;
//     _data['propertySubType'] = propertySubType;
//     _data['beds'] = beds;
//     _data['baths'] = baths;
//     _data['carSpaces'] = carSpaces;
//     _data['lockUpGarages'] = lockUpGarages;
//     _data['landArea'] = landArea;
//     _data['isCalculatedLandArea'] = isCalculatedLandArea;
//     _data['landAreaSource'] = landAreaSource;
//     return _data;
//   }
// }

// class Images {
//   Images({
//     required this.defaultImage,
//     required this.secondaryImageList,
//     required this.floorPlanImageList,
//     required this.isActiveProperty,
//   });
//   late final dynamic defaultImage;
//   late final List secondaryImageList;
//   late final List floorPlanImageList;
//   late final bool isActiveProperty;
  
//   Images.fromJson(Map<String, dynamic> json){
//     defaultImage =  List.castFrom<dynamic, dynamic>(json['defaultImage']);//DefaultImage.fromJson(json['defaultImage']);
//     secondaryImageList =  List.castFrom<dynamic, dynamic>(json['secondaryImageList']);// List.from(json['secondaryImageList']).map((e)=>SecondaryImageList.fromJson(e)).toList();
//     floorPlanImageList = List.castFrom<dynamic, dynamic>(json['floorPlanImageList']);
//     isActiveProperty = json['isActiveProperty'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['defaultImage'] = defaultImage.toJson();
//     _data['secondaryImageList'] = secondaryImageList.map((e)=>e.toJson()).toList();
//     _data['floorPlanImageList'] = floorPlanImageList;
//     _data['isActiveProperty'] = isActiveProperty;
//     return _data;
//   }
// }

// class DefaultImage {
//   DefaultImage({
//     required this.digitalAssetType,
//     required this.basePhotoUrl,
//     required this.largePhotoUrl,
//     required this.mediumPhotoUrl,
//     required this.thumbnailPhotoUrl,
//     required this.scanDate,
//   });
//   late final String digitalAssetType;
//   late final String basePhotoUrl;
//   late final String largePhotoUrl;
//   late final String mediumPhotoUrl;
//   late final String thumbnailPhotoUrl;
//   late final String scanDate;
  
//   DefaultImage.fromJson(Map<String, dynamic> json){
//     digitalAssetType = json['digitalAssetType'];
//     basePhotoUrl = json['basePhotoUrl'];
//     largePhotoUrl = json['largePhotoUrl'];
//     mediumPhotoUrl = json['mediumPhotoUrl'];
//     thumbnailPhotoUrl = json['thumbnailPhotoUrl'];
//     scanDate = json['scanDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['digitalAssetType'] = digitalAssetType;
//     _data['basePhotoUrl'] = basePhotoUrl;
//     _data['largePhotoUrl'] = largePhotoUrl;
//     _data['mediumPhotoUrl'] = mediumPhotoUrl;
//     _data['thumbnailPhotoUrl'] = thumbnailPhotoUrl;
//     _data['scanDate'] = scanDate;
//     return _data;
//   }
// }

// class SecondaryImageList {
//   SecondaryImageList({
//     required this.digitalAssetType,
//     required this.basePhotoUrl,
//     required this.largePhotoUrl,
//     required this.mediumPhotoUrl,
//     required this.thumbnailPhotoUrl,
//     required this.scanDate,
//   });
//   late final String digitalAssetType;
//   late final String basePhotoUrl;
//   late final String largePhotoUrl;
//   late final String mediumPhotoUrl;
//   late final String thumbnailPhotoUrl;
//   late final String scanDate;
  
//   SecondaryImageList.fromJson(Map<String, dynamic> json){
//     digitalAssetType = json['digitalAssetType'];
//     basePhotoUrl = json['basePhotoUrl'];
//     largePhotoUrl = json['largePhotoUrl'];
//     mediumPhotoUrl = json['mediumPhotoUrl'];
//     thumbnailPhotoUrl = json['thumbnailPhotoUrl'];
//     scanDate = json['scanDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['digitalAssetType'] = digitalAssetType;
//     _data['basePhotoUrl'] = basePhotoUrl;
//     _data['largePhotoUrl'] = largePhotoUrl;
//     _data['mediumPhotoUrl'] = mediumPhotoUrl;
//     _data['thumbnailPhotoUrl'] = thumbnailPhotoUrl;
//     _data['scanDate'] = scanDate;
//     return _data;
//   }
// }