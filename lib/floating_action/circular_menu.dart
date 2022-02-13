import 'dart:math';

import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
class CircularFloationgMenu extends StatefulWidget {
  const CircularFloationgMenu({ Key? key }) : super(key: key);

  @override
  _CircularFloationgMenuState createState() => _CircularFloationgMenuState();
}

class _CircularFloationgMenuState extends State<CircularMenu> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
    AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      // menu alignment
      alignment: Alignment.bottomCenter,
      // menu radius
      radius: 100,
      // widget in the background holds actual page content
      
      // global key to control the animation anywhere in the code.
      // key: // GlobalKey<CircularMenuState>(),
      // animation duration

      animationDuration: Duration(milliseconds: 500),
    
      curve: Curves.bounceOut,
      // animation curve in reverse
      reverseCurve: Curves.fastOutSlowIn,
	    // first item angle
      startingAngleInRadian : 0 ,
    	// last item angle
      endingAngleInRadian : pi,
      // toggle button callback
      toggleButtonOnPressed: () {
        //callback
      },
      // toggle button appearance properties
      toggleButtonColor: Colors.pink,
      toggleButtonBoxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
              ),
            ], 
      toggleButtonIconColor: Colors.white,
      toggleButtonMargin: 10.0,
      toggleButtonPadding: 10.0,
      toggleButtonSize: 40.0,
      items: [
        CircularMenuItem(
          // menu item callback
          onTap: () {
            // callback
          },
          // menu item appearance properties
          icon: Icons.home,
          color: Colors.blue,
         
          iconColor: Colors.white,
          iconSize: 30.0,
          margin: 10.0,
          padding: 10.0,
          // when 'animatedIcon' is passed,above 'icon' will be ignored
           animatedIcon: AnimatedIcon(icon: AnimatedIcons.add_event, progress: CurvedAnimation(parent: controller, curve: Curves.easeIn)),
    ),
        CircularMenuItem(
            icon: Icons.search,
            onTap: () {
              //callback
            }),
        CircularMenuItem(
            icon: Icons.settings,
            onTap: () {
              //callback
            }),
        CircularMenuItem(
            icon: Icons.star,
            onTap: () {
              //callback
            }),
        CircularMenuItem(
            icon: Icons.pages,
            onTap: () {
              //callback
            }),
      ]);
  }
}


class SpinCircleBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  SpinCircleBottomBarHolder(
        
          bottomNavigationBar: SCBottomBarDetails(

              circleColors: [Colors.white, Colors.orange, Colors.redAccent],
              iconTheme: IconThemeData(color: Colors.black45),
              activeIconTheme: IconThemeData(color: Colors.orange),
              backgroundColor: Colors.white,
              titleStyle: TextStyle(color: Colors.black45,fontSize: 12),
              activeTitleStyle: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),
              actionButtonDetails: SCActionButtonDetails(
                  color: Colors.redAccent,
                  icon: Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  ),
                  elevation: 2),
              elevation: 2.0,
              items: [
                // Suggested count : 4
                SCBottomBarItem(icon: Icons.verified_user, title: "User", onPressed: () {}),
                SCBottomBarItem(icon: Icons.supervised_user_circle, title: "Details", onPressed: () {}),
                SCBottomBarItem(icon: Icons.notifications, title: "Notifications", onPressed: () {}),
                SCBottomBarItem(icon: Icons.details, title: "New Data", onPressed: () {}),
              ],
              circleItems: [
                //Suggested Count: 3
                SCItem(icon: Icon(Icons.add), onPressed: () {}),
                SCItem(icon: Icon(Icons.print), onPressed: () {}),
                SCItem(icon: Icon(Icons.map), onPressed: () {}),
              ],
              bnbHeight: 80 // Suggested Height 80
          ),
          child: Container(
            color: Colors.orangeAccent.withAlpha(55),
            child: Center(child: Text("Isn't this Awesome!"),),
          ),
        ),
    
    );
  }
}