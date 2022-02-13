import 'package:hashching/Utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceComponents {


    Future<SharedPreferences> initialPreferences() async {

  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences;
    }

 static  Future<String?> getUserToken() async {

  SharedPreferences preferences = await SharedPreferences.getInstance();

  String? userToken = preferences.getString(LocalConstants.userToken);

return userToken;

}


}

