// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/shared_preference.dart';
import 'package:hashching/models/all_loans_model.dart';
import 'package:hashching/models/brokers_details_model.dart';
import 'package:hashching/models/carmake_model_list.dart';
import 'package:hashching/models/carmakemodel.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_brokers_list_model.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/consumer_documet_list_model.dart';
import 'package:hashching/models/hash_auto_model.dart';
import 'package:hashching/models/hash_connect_model.dart';
import 'package:hashching/models/hash_convenyancing_model.dart';
import 'package:hashching/models/loan_enquirey_model.dart';
import 'package:hashching/models/newloan_enquirey_model.dart';
import 'package:hashching/models/postcode_model.dart';
import 'package:hashching/models/property_details_model.dart';
import 'package:hashching/models/property_suggestions_model.dart';
import 'package:hashching/models/rewards_model.dart';
import 'package:hashching/models/updated_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<ConsumerAccountModel?> fetchConsumerAccountData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? userToken = preferences.getString(LocalConstants.userToken);
    LocalStorage.UserToken = await userToken!;
    print('userToken $userToken');
    var url = Uri.parse(LocalConstants.ConsumerAccountUrl);
    final response = await http.post(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    }, body: {});
    print("response.ConsumerAccount :${response.statusCode}");
    print("respone ${response.body}");
    if (response.statusCode == 200) {
      // print("respone ${response.body}");
      return ConsumerAccountModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
      // throw Exception('Failed to load consumer information');

    }
  }

  static Future<ConsumerDashboardModel?> fetchConsumerDashboard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? userToken = preferences.getString(LocalConstants.userToken);
    LocalStorage.UserToken = await userToken!;
    var url = Uri.parse(LocalConstants.ConsumerDeshboardUrl);
    final response = await http.post(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    }, body: {});
    print("response.statusCode :${response.statusCode}");
    print("**********consumerDashboard ########## ${response.body}");
    if (response.statusCode == 200) {
//print("respone ${response.body}");
      return ConsumerDashboardModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<ConsumerLoansModel?> fetchConsumerLoansList() async {
    String? userToken = LocalStorage.UserToken;

    var url = Uri.parse(LocalConstants.ConsumerAllLoansUrl);
    final response = await http.post(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    }, body: {});
    print("response.statusCode :${response.statusCode}");
    print("***** consumerLoansList${response.body}");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print("respone all lons ${response.body}");
      //  if(jsonResponse['allLoans']['exception']== null){
      //    return null;
      //  }
      return ConsumerLoansModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<ConsumerDetailsModel?> getConsumerSettings() async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.ConsumerSettingsUrl);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
    );
    print("response.statusCode :${response.statusCode}");
    print("respone : ${response.body}");
    if (response.statusCode == 200) {
      return ConsumerDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<UpdatedProfileModel?> updatedConsumerProfile({
    String? firstName,
    String? lastName,
    String? mobile,
    String? email,
    String? profilePic,
    String? profilePicLink,
  }) async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.updatedConsumerProfileUrl);
    final response = await http.post(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    }, body: {
      "first_name": firstName,
      "last_name": lastName,
      "mobile": mobile,
      "email": email,
      "profile_pic_link": profilePicLink,
      "profile_pic": profilePic,
    });
    print("response.statusCode :${response.statusCode}");
    print("respone !: ${response.body}");
    if (response.statusCode == 200) {
      return UpdatedProfileModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<ConsumerBrokersListModel?> getConsumerBrokersList() async {
    String? userToken = LocalStorage.UserToken;

    var url = Uri.parse(LocalConstants.ConsumerAllBrokersUrl);
    final response = await http.post(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    }, body: {});
    // print("response.statusCode :${response.statusCode}");
    // print("respone ${response.body}");
    if (response.statusCode == 200) {
      // print("respone all brokers ${response.body}");
      return ConsumerBrokersListModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<BrokersDetailsModel?> getBrokerProfileInfo({
    String? id,
  }) async {
    print("id  $id");

    String? userToken = LocalStorage.UserToken;
    var jsonData = jsonEncode({"id": id});
    var url = Uri.parse(LocalConstants.fetchBrokerDetailsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    print("***getBrokerProfileInfo.statusCode :${response.statusCode}");
    print("***getBrokerProfileInfo respone : ${response.body}");
    if (response.statusCode == 200) {
      return BrokersDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<RewardsModel?> getConsumerRewards() async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.getConsumerRewardsUrl);
    final response = await http.get(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    });
    if (response.statusCode == 200) {
      print("7777777777777777777777777777777777777");
      print(RewardsModel.fromJson(jsonDecode(response.body)));
      return RewardsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<ConsumerDocumentListModel?> getConsumerAllDocuments({
    String? id,
  }) async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.consumerAllDocumentsUrl);
    final response = await http.post(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    }, body: {});

    print("document Moel: ${response.body}");
    if (response.statusCode == 200) {
      return ConsumerDocumentListModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future deleteConsumerDocuments({
    required List<String> documentIds,
    status,
    userId,
  }) async {
    var jsonData = jsonEncode({"docmentids": documentIds});
    print('~~~~$documentIds');
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.deleteConsumerDocumentsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    print('~~~~ exit');
    print(response.body);
    print("delete.statusCode  : ${response.statusCode}");
    if (response.statusCode == 200) {
      print('success' + response.body);
      return response.body;
    } else {
      print('failure' + response.body);
      return null;
    }
  }

  static Future shareConsumerDocuments({
    required List<String> documentIds,
    required String userId,
    required String status,
  }) async {
    var jsonData = jsonEncode(
        {"documentid": documentIds, "user_id": userId, "status": status});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.shareConsumerDocumentsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future getPropertyCreditInformation() async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.getPropertyCreditUrl);
    final response = await http.get(url, headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<LoanEnquireyModel?> fetchLoanDetails({
    String? encryptId,
  }) async {
    var jsonData = jsonEncode({"encrypt_id": encryptId});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.fetchLoanDetailsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    print(response.statusCode);
    print('loanEnquireyModel**${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return LoanEnquireyModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<NewLoanEnquireyModel?> fetchNewLoanDetails({
    String? encryptId,
  }) async {
    var jsonData = jsonEncode({"encrypt_id": encryptId});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.fetchLoanDetailsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    print(response.statusCode);
    print('loanEnquireyModel**${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return NewLoanEnquireyModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future fetchAssignedLoanDetails({
    String? encryptId,
  }) async {
    var jsonData = jsonEncode({"encrypt_id": encryptId});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.fetchLoanDetailsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    print(response.statusCode);
    print('loanEnquireyModel**${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      return null;
    }
  }

  //Add Loan

  static Future addNewLoan(Object addNewLoanDetails) async {
    var jsonData = jsonEncode(addNewLoanDetails);

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.addNewLoanUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print('  "lead_id" Temp : ${response.body} ');
    if (response.statusCode == 200) {
      print('  "lead_id"  : ${response.body} ');
      return true;
    } else {
      return false;
    }
  }

  static Future addNewHashAuto(Object addNewHashAutoDetails) async {
    var jsonData = jsonEncode(addNewHashAutoDetails);

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.addNewHashAutoUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print(' HashAutoDetails : ${response.body} ');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future addNewHashConnect(Object addNewHashConnectDetails) async {
    var jsonData = jsonEncode(addNewHashConnectDetails);

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.addNewHashConvenyancingUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print(' HashAutoDetails : ${response.body} ');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future addNewHashConveny(Object addNewHashConvenyDetails) async {
    var jsonData = jsonEncode(addNewHashConvenyDetails);

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.addNewHashConnectUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print(' HashAutoDetails : ${response.body} ');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Map<String, String>>> getPostCodeSuggestions(
      String query) async {
    if (query.isEmpty || query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    } else {
      var url = Uri.parse(LocalConstants.postcodeSuggestionsUrl);
      var jsonData = jsonEncode({"postcode": query});

      String? userToken = LocalStorage
          .UserToken; // preferences.getString(LocalConstants.userToken);
      final response = await http.post(url,
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken'
          },
          body: jsonData);
      List<Postcodes> suggestions = [];
      if (response.statusCode == 200) {
        print('statusCode############: ${response.statusCode}.');
        print('statusCode############: ${response.body}.');
        var jsonDecodeSuggestions = jsonDecode(response.body);
        print("__________");
        print('${jsonDecodeSuggestions["postcodes"]}');

        if(jsonDecodeSuggestions["postcodes"] != null){
        if (jsonDecodeSuggestions["postcodes"].length != 0) {
          suggestions = List<Postcodes>.from(
              jsonDecodeSuggestions["postcodes"].map((model) {
           return     Postcodes.fromJson(model);
          }));
        } else {}

        print('Number of suggestion: ${suggestions.length}.');
      }} else {
        print('Request failed with status: ${response.statusCode}.');
      }
      if (suggestions.length == 0) {
        return Future.value([
          {
            "status": "false",
            "suggestions":
                "Post code not found. Make sure you are entering the post code in the correct format."
          }
        ]);
      }
      return Future.value(suggestions.map((e) => {
        "status": "true",
        'suggestions': "${e.postcode.toString()} ,${e.locality} ,${e.statecode}",

      }).toList());
          // .map((e) => {
          //       "status": "true",
          //       'suggestions': e.postcode.toString() +" ,"+e.locality,+" ,"+e.statecode,
          //
          //     })
          // .toList());
    }
  }

  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    if (query.isEmpty || query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    } else {
      var url = Uri.parse(LocalConstants.propertySuggestionsUrl);

      //
      var jsonData = jsonEncode({"popup_property": query});

      String? userToken = LocalStorage
          .UserToken; // preferences.getString(LocalConstants.userToken);
      final response = await http.post(url,
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken'
          },
          body: jsonData);
      List<MySuggestions> suggestions = [];
      if (response.statusCode == 200) {
        print('statusCode############: ${response.body}.');
        var jsonDecodeSuggestions = jsonDecode(response.body);
        if (jsonDecodeSuggestions["suggestions"].length != 0) {
          suggestions = List<MySuggestions>.from(
              jsonDecodeSuggestions["suggestions"].map((model) {
            print('object q  ${model["suggestion"]}');
            var databool = model.containsKey('propertyId');
            if (databool) {
              return MySuggestions.fromJson(model);
            } else {
              model["localityId"] = 0;
              model["propertyId"] = 0;
              model["streetId"] = 0;
              return MySuggestions.fromJson(model);
              // return MySuggestions.fromJson({
              //   "councilAreaId": model["councilAreaId"],
              //   "countryId": model["countryId"],
              //   "isActiveProperty": model["isActiveProperty"],
              //   "isBodyCorporate": model["isBodyCorporate"],
              //   "isUnit": model["isUnit"],
              //   "localityId": 0,
              //   "postcodeId": model["postcodeId"],
              //   "propertyId":0,
              //   "stateId": model["stateId"],
              //   "streetId": 0,
              //   "suggestion": model["suggestion"],
              //   "suggestionType": model["suggestionType"],
              // });
            }
          }));
        } else {}

        print('Number of suggestion: ${suggestions.length}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }

      // var property =
      //     MyPropertySuggestionsModel.fromJson(jsonDecode(response.body));
      if (suggestions.length == 0) {
        return Future.value([
          {
            "status": "false",
            "suggestions":
                "Property not found. Please check the address and try again. Make sure you are entering the address in the correct format."
          }
        ]);
      }
      return Future.value(suggestions
          .map((e) => {
                "status": "true",
                'suggestions': e.suggestion,
                'propertyId': e.propertyId.toString(),
              })
          .toList());
    }
  }

  static Future<List<Suggestions>> fetchPostCodeSuggestions(
      String query) async {
    if (query.isEmpty || query.length < 3) {
      print('Query needs to be at least 3 chars');

      return Future.value([]);
    } else {
      var url = Uri.parse(LocalConstants.propertySuggestionsUrl);

      var jsonData = jsonEncode({"popup_property": query});

      String? userToken = LocalStorage.UserToken;
      final response = await http.post(url,
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken'
          },
          body: jsonData);
      List<Suggestions> suggestions = [];
      if (response.statusCode == 200) {
        var jsonDecodeSuggestions = jsonDecode(response.body);
        print(
            "object ******************** ${jsonDecodeSuggestions["suggestions"]}");
        if (jsonDecodeSuggestions["suggestions"].length != 0) {
          var dataList = [];
          var responses =
              await jsonDecodeSuggestions["suggestions"].map((response) {
            dataList.add(response);
            return response;
          });

          suggestions = List<Suggestions>.from(
              jsonDecodeSuggestions["suggestions"]
                  .map((model) => Suggestions.fromJson(model)));
        } else {}

        print('Number of suggestion: ${suggestions.length}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      print({
        "statusCode of ############: ${jsonDecode(response.body)["suggestions"]}"
      });
      var property =
          MyPropertySuggestionsModel.fromJson(jsonDecode(response.body));
      if (suggestions.length == 0) {
        print(property.suggestions);
        return property.suggestions;
      }
      return property.suggestions;
    }
  }

  static Future<PropertyDetailsModel?> fetchPropertyDetails(
      String propertyId) async {
    print('object  $propertyId');
    var jsonData = jsonEncode({
      "propertyId": propertyId //"1208937"
    });

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.propertyDetailsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print(' propertySuggestions : ${response.body} ');
    if (response.statusCode == 200) {
      return PropertyDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future fetchMorePropertyDetails(
      String propertyId, String localId) async {
    var jsonData = jsonEncode({"propertyId": "1208937"});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.propertyDetailsUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print(' propertySuggestions : ${response.body} ');
    if (response.statusCode == 200) {
      return PropertyDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future getIFrameLink(String encrypt_id) async {
    var jsonData = jsonEncode({
      // "encrypt_id": "eNnl1Nq8IFx60fwYL6fuucdcBI83uC0OD5pgQob67yc="
      "id": "358d2de5-a173-4be5-81a3-509497c62819",
      "email": "toshiba44@test.com",
      "lead_id": 2816
    });

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.getDocumentIFrameLinkUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('  response.statusCode : ${response.statusCode} ');
    print(' propertySuggestions : ${response.body} ');
    if (response.statusCode == 200) {
      //  return PropertyDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future sendMessageToBroker(int lead_id, String message) async {
    print("lead  ^^^^^^^^^^^^$lead_id");
    var jsonData = jsonEncode({
      "lead_id": lead_id,
      "message": message
      //  "lead_id": 2814,
      //    "message": "Hi test"
    });

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.sendMessageToBroker);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('statusCode : ${response.statusCode} ');
    print(' sendMessageToBroker : ${response.body} ');
    if (response.statusCode == 200) {
    } else {
      return null;
    }
  }

  static Future getCarMakeList() async {
    var jsonData = jsonEncode({});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.getCarMakeList);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('statusCode : ${response.statusCode} ');
    print(' sendMessageToBroker : ${response.body} ');
    if (response.statusCode == 200) {
      return CarMakeModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future getCarMakeModelList(selectedCar) async {
    print("selectedCar $selectedCar");
    var jsonData = jsonEncode({"car_make": selectedCar});

    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.getCarMakeModelList);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);

    print('statusCode : ${response.statusCode} ');
    print(' car_make : ${response.body} ');
    if (response.statusCode == 200) {
      return CarMakeModelList.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future addConsumerDocumentFile(path) async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.addConsumerUploadDocumentUrl);
    var headers = <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static fetchHashConvenyancingList() async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.hashConvenyancingListenerUrl);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
    );
    print('response.statusCode : ${response.statusCode} ');
    print('fetchHashConvenyancingList : ${response.body} ');
    if (response.statusCode == 200) {
      print(' fetchHashConvenyancingList OK RESponse : ${response.body} ');
      return jsonDecode(response.body);
      // return HashConveyacingRawList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
      // return null;
    }
  }

  static Future<HashautoListingModel> fetchHashAutoList() async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.hashAutoListenerUrl);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
    );
    print('response.statusCode : ${response.statusCode} ');
    print('hash auto list : ${response.body} ');
    if (response.statusCode == 200) {
      print(' hash auto list : ${response.body} ');
    //  return jsonDecode(response.body);
       return HashautoListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
      // return null;
    }
  }
  static Future<HashConnectListModel> fetchHashConnectList() async {
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.hashConnectListenerUrl);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
    );
    print('response.statusCode : ${response.statusCode} ');
    print('hash connect list : ${response.body} ');
    if (response.statusCode == 200) {
      print(' hash connect list : ${response.body} ');
      //  return jsonDecode(response.body);
      return HashConnectListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
      // return null;
    }
  }


  static sendCode(request) async {
    var jsonData = jsonEncode({"mobile": 470276369});
    print("============>");
    print(jsonData);
    String? userToken = LocalStorage.UserToken;
    var url = Uri.parse(LocalConstants.otpSend2ConsumerUrl);
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: request);
    print('response.statusCode : ${response.statusCode} ');
    print('response body : ${response.body} ');
    if (response.statusCode == 200) {
      print(' status : ${response.body} ');
      // return jsonDecode(response.body);
      return jsonDecode(response.body);
      // return HashConveyacingRawList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
      // return null;
    }
  }

  static verifyMobileOtp({mobile, sms, uuid}) async {
    var jsonData = {"smscode": sms, "mobile": mobile, "uuid": uuid};
    print("button clicked");

    var jsonResponse = null;
    var url = Uri.parse(LocalConstants.verifyOtpUrl);
    String? userToken = LocalStorage.UserToken;
    var response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonData);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (jsonResponse != null) {
        if (jsonResponse["status"] == 'pass') {
          return jsonResponse;
        } else {
          return jsonResponse;
          print('failure');
        }
      }
    } else {
      print('"****** body: ${response.body}');
    }
  }
}
