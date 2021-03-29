import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/common_card.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/screens/branches/branch_screen.dart';
import 'package:gas_station/screens/employee/employee_screen.dart';
import 'package:gas_station/screens/managers/manager_screen.dart';
import 'package:gas_station/screens/notifications/notification_screen.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      appBarTitle: 'Admin Dashboard',
      bodyContent: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonCard(
                    nextScreen: EmployeeScreen(),
                    icon: Icons.person,
                    title: 'Employees',
                    count: '0',
                  ),
                  CommonCard(
                    nextScreen: ManagerScreen(),
                    icon: Icons.person,
                    title: 'Managers',
                    count: '0',
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonCard(
                    nextScreen: BranchScreen(),
                    icon: Icons.home,
                    title: 'Branches',
                    count: '0',
                  ),
                  CommonCard(
                    nextScreen: NotificationScreen(),
                    icon: Icons.notification_important,
                    title: 'Notifications',
                    count: '0',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
