import 'package:flutter/material.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';

class CommonCard extends StatelessWidget {
  final Widget nextScreen;
  final IconData icon;
  final String title;
  final String count;

  var _decoration = BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        15.0,
      ),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  CommonCard({this.nextScreen, this.icon, this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetProperties.goToNextPage(context, nextScreen);
      },
      child: Container(
        width: WidgetProperties.screenWidth(context) * .4,
        height: WidgetProperties.screenHeight(context) * .22,
        decoration: _decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 40.0,
              color: AppColors.primaryColor,
            ),
            Textview2(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              title: "Total",
              color: AppColors.primaryColor,
            ),
            Textview2(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              title: title,
              color: AppColors.primaryColor,
            ),
            Textview2(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              title: count,
              color: AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
