import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_station/common/app_logo.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/user_controller.dart';
import 'package:gas_station/models/user/user_model.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/my_behaviour.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

import 'otp_screen.dart';

class SignInScreen extends StatelessWidget {
  var userController = Get.put(UserController());
  var userMobileNumberController = TextEditingController();

  var userModel = UserModel();

  var mnNode = FocusNode();

  var _selectedSubjectDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      border: Border.all(width: 1.0, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Textview2(
            title: "Sign in",
          ),
        ),
        backgroundColor: Colors.white,
        body: GetBuilder<UserController>(
          init: userController,
          initState: (child) {},
          builder: (_) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Hero(
                          tag: 'logo',
                          child: AppLogo(
                              width: WidgetProperties.screenWidth(context) * .5,
                              height: WidgetProperties.screenHeight(context) *
                                  .25)),
                      Form(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 95.0),
                              decoration: _selectedSubjectDecoration,
                              child: FormInput(
                                textInputType: TextInputType.number,
                                errorText:
                                    userController.validityPhoneNumber.message,
                                hint: 'Mobile Number',
                                hintColor: AppColors.commoneadingtextColor,
                                onSaved: (value) {
                                  userController.checkPhoneNumber(value);
                                  userController.updateUserBuilder();
                                },
                                formatter: FilteringTextInputFormatter.allow(
                                  RegExp("[0-9 +]"),
                                ),
                                obsecureText: false,
                                maxLength: 50,
                                myController: userMobileNumberController,
                                focusNode: mnNode,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25.0),
                              child: HeroButton(
                                width: WidgetProperties.screenWidth(context),
                                height: 50.0,
                                radius: 27.0,
                                gradient: AppColors.primaryColor,
                                title: 'Sign In',
                                onPressed: () {
                                  checkPhoneNumber(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Textview2(
                          title: "Forgot Password?",
                          fontWeight: FontWeight.w900,
                          fontSize: 15.0,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Textview2(
                          title: "Click Here",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Future<void> checkPhoneNumber(BuildContext buildContext) {
    userModel.phone = userMobileNumberController.text;
    userController.phoneNumber = userMobileNumberController.text;
    if (userController.checkPhoneNumberValidation(userModel)) {
      userController.loginUser(
          userMobileNumberController.text, buildContext, OtpScreen());
    } else {
      userController.updateUserBuilder();
    }
  }
}
