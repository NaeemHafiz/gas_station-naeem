import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/constants.dart';
import 'package:gas_station/common/custom_button.dart';

import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/screens/branches/branch_screen.dart';
import 'package:gas_station/screens/employee/employee_screen.dart';
import 'package:gas_station/screens/managers/manager_screen.dart';
import 'package:gas_station/screens/notifications/notification_screen.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/authentication/signin_screen.dart';
import 'common_image.dart';

class CommonDrawerManager extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  final Widget widget;
  final String title;
  final bool bottomOverflow;

  CommonDrawerManager({this.widget, this.title, this.bottomOverflow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: bottomOverflow,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          title,
          style: TextStyle(color: AppColors.textWhiteColor),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
          key: _drawerKey,
          child: Column(
            children: [
              CommonImage(
                imageUrl: Constants.BENZOL_3_IMAGE,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
                alignment: Alignment.centerLeft,
                child: Textview2(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  title: "Manager",
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                alignment: Alignment.centerLeft,
                child: Textview2(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  title: "Riyadh-Branch",
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Textview2(
                      title: 'Dashboard',
                      color: AppColors.listTileTitleColor,
                      fontSize: 15.0,
                    ),
                  ),
                  leading: Icon(Icons.home)),
              ListTile(
                onTap: () {
                  WidgetProperties.goToNextPageWithReplacement(
                      context, BranchScreen());
                },
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Textview2(
                    title: 'Employees',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.phone),
              ),
              ListTile(
                onTap: () {
                  WidgetProperties.goToNextPageWithReplacement(
                      context, EmployeeScreen());
                },
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Textview2(
                    title: 'Chat',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.person),
              ),
              ListTile(
                onTap: () {
                  WidgetProperties.goToNextPageWithReplacement(
                      context, ManagerScreen());
                },
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Textview2(
                    title: 'Notification',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.person),
              ),
              ListTile(
                onTap: () {
                  WidgetProperties.goToNextPageWithReplacement(
                      context, NotificationScreen());
                },
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Textview2(
                    title: 'Language',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.notification_important),
              ),
              ListTile(
                onTap: () {
                  showDialog(context);
                },
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Textview2(
                    title: 'Logout',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.logout),
              ),
            ],
          )),
      body: widget,
    );
  }

  Future<void> showDialog(BuildContext buildContext) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: buildContext,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            child: SizedBox.expand(
                child: Container(
              child: Column(
                children: [
                  Textview2(
                    title: Constants.LOGOUT_FROM_APP_TEXT,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: HeroButton(
                            height: 30.0,
                            width: 120,
                            radius: 32.0,
                            gradient: Color(0xff4cae4d),
                            title: "Yes",
                            onPressed: () {
                              logoutFromApplication(buildContext);
                            },
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.60,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: HeroButton(
                            height: 30.0,
                            width: 120,
                            radius: 32.0,
                            gradient: AppColors.formContinueButtomColor,
                            title: "No",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }

  Future<void> logoutFromApplication(BuildContext buildContext) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('boolValue');
    Navigator.of(buildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (Route<dynamic> route) => false);
  }
}
