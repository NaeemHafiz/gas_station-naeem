import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/app_logo.dart';
import 'package:gas_station/common/common_card.dart';
import 'package:gas_station/common/common_drawer.dart';
import 'package:gas_station/common/common_image.dart';
import 'package:gas_station/common/constants.dart';
import 'package:gas_station/screens/branches/branch_screen.dart';
import 'package:gas_station/screens/employee/employee_screen.dart';
import 'package:gas_station/screens/managers/manager_screen.dart';
import 'package:gas_station/screens/notifications/notification_screen.dart';
import 'package:gas_station/utils/my_behaviour.dart';
import 'package:gas_station/utils/widgetproperties.dart';

class CommonScreen extends StatelessWidget {
  final Widget bodyContent;
  final String appBarTitle;

  const CommonScreen({this.bodyContent,this.appBarTitle});
  @override
  Widget build(BuildContext context) {
    return CommonDrawer(
      bottomOverflow: true,
      title: appBarTitle,
      widget: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .31,
                  width: MediaQuery.of(context).size.width,
                  child: CommonImage(
                    imageUrl: Constants.BENZOL_1_IMAGE,
                    imageWidth: MediaQuery.of(context).size.width,
                    imageBoxFit: BoxFit.fill,
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * .56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.2,
                          child: Container(
                              child: AppLogo(
                            width: WidgetProperties.screenWidth(context) * .6,
                            height: WidgetProperties.screenWidth(context) * .6,
                          )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child:Container(
                            height: MediaQuery.of(context).size.height * .56,
                            child: bodyContent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
