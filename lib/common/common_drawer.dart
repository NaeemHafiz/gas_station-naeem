import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/common_image.dart';
import 'package:gas_station/common/constants.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/screens/branches/branch_screen.dart';
import 'package:gas_station/screens/employee/employee_screen.dart';
import 'package:gas_station/screens/managers/manager_screen.dart';
import 'package:gas_station/screens/notifications/notification_screen.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';

class CommonDrawer extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  final Widget widget;
  final String title;
  final bool bottomOverflow;

  CommonDrawer({this.widget, this.title, this.bottomOverflow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: bottomOverflow,
      appBar: AppBar(
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                  title: "Admin",
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
                    title: 'Branches',
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
                    title: 'Employees',
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
                    title: 'Managers',
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
                    title: 'Notifications',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.notification_important),
              ),
              ListTile(
                onTap: () {},
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Textview2(
                    title: 'Languages',
                    color: AppColors.listTileTitleColor,
                    fontSize: 15.0,
                  ),
                ),
                leading: Icon(Icons.language),
              ),
              ListTile(
                onTap: () {},
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
}
