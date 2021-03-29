import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/app_logo.dart';
import 'package:gas_station/controllers/branch_controller.dart';
import 'package:gas_station/screens/dashboard/dashboard.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/signin_screen.dart';

void main() => runApp(MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 10, end: 210).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status != AnimationStatus.completed) {
          controller.forward();
        }
      });

    controller.forward();
    getBoolValuesSF();
    Get.put(BranchController());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Hero(
              tag: 'logo',
              child: AppLogo(width: animation.value, height: animation.value)),
        ),
      ),
    );
  }

  Future<void> getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('boolValue');
    Timer(Duration(seconds: 4), () {
      if (boolValue == true)
        WidgetProperties.goToNextPageWithReplacement(context, Dashboard());
      else {
        WidgetProperties.goToNextPageWithReplacement(context, SignInScreen());
      }
    });
  }
}
