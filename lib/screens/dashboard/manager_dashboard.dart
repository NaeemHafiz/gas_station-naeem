import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/common_card_manager.dart';
import 'package:gas_station/common/common_screen_manager.dart';
import 'package:gas_station/screens/employee/employee_screen.dart';


class ManagerDashboard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CommonScreenManager(
      appBarTitle: 'Manager Dashboard',
      bodyContent: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: CommonCardManager(
                nextScreen: EmployeeScreen(),
                icon: Icons.person,
                title: 'Employees',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: CommonCardManager(
                nextScreen: EmployeeScreen(),
                icon: Icons.chat,
                title: 'Chat',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: CommonCardManager(
                nextScreen: EmployeeScreen(),
                icon: Icons.notifications,
                title: 'Notification List',
              ),
            ),
          ],
        ),
      ),
    );
  }

}