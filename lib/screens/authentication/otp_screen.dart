import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_station/common/common_image.dart';
import 'package:gas_station/common/constants.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput3.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/user_controller.dart';
import 'package:gas_station/db/db_service.dart';
import 'package:gas_station/db/db_values.dart';
import 'package:gas_station/screens/dashboard/admin_dashboard.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/my_behaviour.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_station/models/user/user_model.dart';

class OtpScreen extends StatelessWidget {
  var userController = Get.find<UserController>();
  var userOtpCodeController = TextEditingController();
  SharedPreferences prefs;

  var otpNode = FocusNode();
  var userModel = UserModel();

  var _selectedSubjectDecoration = BoxDecoration(
      color: AppColors.dropdownBackgroundColor,
      border: Border.all(width: 0.5, color: Colors.black),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Textview2(
          title: 'OTP Verification',
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(
        initState: (child) async {
          prefs = await SharedPreferences.getInstance();
        },
        builder: (_) {
          return Form(
            autovalidateMode: AutovalidateMode.disabled,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CommonImage(
                        imageUrl: Constants.OTP_ICON,
                        imageWidth: WidgetProperties.screenWidth(context) * .5,
                        imageHeight:
                            WidgetProperties.screenHeight(context) * .25,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Textview2(
                                title: "Enter the Code sent to",
                                fontSize: 15.0,
                                color: AppColors.enterCodeColor,
                                fontWeight: FontWeight.bold,
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Textview2(
                                  title: userController.phoneNumber != null
                                      ? userController.phoneNumber
                                      : "+966 00001111",
                                  fontSize: 15.0,
                                  color: AppColors.mobileNumberlineColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: FormInput3(
                          textInputType: TextInputType.number,
                          errorText: userController.validityOtpCode.message,
                          hintColor: AppColors.commoneadingtextColor,
                          onSaved: (String value) {
                            userController.checkOtpCode(value);
                            userController.updateUserBuilder();
                          },
                          formatter: FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                          obsecureText: false,
                          maxLength: 50,
                          myController: userOtpCodeController,
                          focusNode: otpNode,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: HeroButton(
                          width: WidgetProperties.screenWidth(context),
                          height: 50.0,
                          radius: 27.0,
                          gradient: AppColors.primaryColor,
                          title: 'Verify',
                          onPressed: () {
                            checkOtpCode(context);
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Textview2(
                                title: "Didn't receive the code?",
                                fontSize: 15.0,
                                color: AppColors.enterCodeColor,
                                fontWeight: FontWeight.bold,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Hello");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Textview2(
                                    title: "RESEND",
                                    fontSize: 15.0,
                                    color: AppColors.mobileNumberlineColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> checkOtpCode(BuildContext buildContext) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    userModel.otpCode = userOtpCodeController.text;
    if (userController.checkOtpCodeValidation(userModel)) {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: userController.verificationId,
          smsCode: userOtpCodeController.text.trim());
      UserCredential userCredential =
          await _auth.signInWithCredential(authCredential).then((value) {
        User user = value.user;
        if (user != null) {
          userModel.phone = userController.phoneNumber;
          FireStoreService().addUserPhoneAuthentication(userModel, "users");
          // DBValues.instance.setUserValue(true);
          WidgetProperties.goToNextPageWithReplacement(
              buildContext, AdminDashboard());
          prefs.setBool('boolValue', true);
        } else {
          WidgetProperties.showToast(
              "There is an error", Colors.white, Colors.red);
        }
      }).catchError((error) {
        WidgetProperties.showToast(
            "Please Enter Valid OTP", Colors.white, Colors.red);
      });
    } else {
      userController.updateUserBuilder();
    }
  }
}
