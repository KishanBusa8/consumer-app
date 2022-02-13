import 'package:flutter/material.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/pages/Info_page/intro_screen.dart';
import 'package:hashching/pages/authentication/login_page/loginscreen.dart';
import 'package:hashching/provider/state_management.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateProvider extends StatefulWidget {
  const StateProvider({Key? key}) : super(key: key);

  @override
  _StateProviderState createState() => _StateProviderState();
}

class _StateProviderState extends State<StateProvider> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool(LocalConstants.appPreviouslyRunKey) ?? false);
    bool loggedIn = (prefs.getBool(LocalConstants.loggedIn) ?? false);

    if (_seen) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => StateManagementProvider()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } else {
     // await ApiServices.updatedConsumerProfile(firstName: "Alex",lastName: "Ul",mobile:"470276369" ,email: "tomcris49@gmail.com",profilePic: "20211207091506.original.png",profilePicLink: "https:\/\/s3-ap-southeast-2.amazonaws.com\/hashching\/uploads\/cropper_images\/20211207091506.original.png");
      await prefs.setBool(LocalConstants.appPreviouslyRunKey, true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();

    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      body: Center(
        child: CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(MasterStyle.thedaryColor),
        ),
      ),
    );
  }
}
