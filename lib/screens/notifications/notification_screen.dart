import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_station/common/common_drawer.dart';
import 'package:gas_station/common/common_image.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/constants.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/screens/notifications/notification_form.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/my_behaviour.dart';
import 'package:gas_station/utils/widgetproperties.dart';

class NotificationScreen extends StatelessWidget {
  var userSearchMobileTextController = TextEditingController();

  List<String> names = [
    "Gas Refill Notification",
    "Gas Pump Problem",
    "Electric Problem",
    "Other Notification"
  ];

  var searchNode = FocusNode();

  var _textFormFieldDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      appBarTitle: 'Notifications',
      bodyContent: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: HeroButton(
                    width: 140.0,
                    height: 30.0,
                    radius: 6.0,
                    gradient: AppColors.primaryColor,
                    title: 'Create New Notiifcation',
                    onPressed: () {
                      WidgetProperties.goToNextPageWithReplacement(
                          context, NotificationForm());
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          decoration: _textFormFieldDecoration,
                          child: FormInput(
                            icon: Icons.search,
                            textInputType: TextInputType.number,
                            // errorText:
                            // userController.validityPhoneNumber.message,
                            hint: 'Search...',
                            hintColor: AppColors.commoneadingtextColor,
                            onSaved: (String value) {
                              // userController.checkPhoneNumber(value);
                              // userController.updateUserBuilder();
                            },
                            formatter: FilteringTextInputFormatter.allow(
                              RegExp("[A-Z a-z _ . @ 0-9]"),
                            ),
                            obsecureText: false,
                            maxLength: 50,
                            //myController: userMobileNumberController,
                            //focusNode: ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 270.0,
                  margin: EdgeInsets.only(
                      top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
                  alignment: Alignment.center,
                  decoration: _listDecoration,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        child: Textview2(
                          title: "Notification List",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: names.length,
                            shrinkWrap: false,
                            itemBuilder: (context, index) {
                              return listWidget(context, index);
                            },
                          ),
                        ),
                      )
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

  Widget listWidget(BuildContext buildContext, int index) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 30.0,
                        color: AppColors.listColor,
                      ),
                      Textview2(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        title: names[index],
                        color: AppColors.listColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
