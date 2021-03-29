import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gas_station/common/common_image.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/constants.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput3.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/user_controller.dart';
import 'package:gas_station/db/db_service.dart';
import 'package:gas_station/models/user/user_model.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

class ManagerForm extends StatelessWidget {
  List<String> _locations = ["Riyadh Branch", "Madinah Branch"];
  String _selectedLocation = 'Select Branch';
  var userController = UserController();

  var userModel = UserModel();

  var fnNode = FocusNode();
  var lNode = FocusNode();
  var mnNode = FocusNode();
  var mNode = FocusNode();

  var managerFirstNameController = TextEditingController();
  var managerLastNameController = TextEditingController();
  var managerMobileNumberController = TextEditingController();
  var managerNumberController = TextEditingController();

  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      // borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      appBarTitle: 'New Manager',
      bodyContent: Container(
        margin:
            EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 10.0),
        alignment: Alignment.center,
        decoration: _listDecoration,
        child: GetBuilder<UserController>(
          init: userController,
          initState: (child) {},
          builder: (_) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  child: Textview2(
                    title: "New Manager",
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Flexible(
                  child: Container(
                    // height: MediaQuery.of(context).size.height / 3,
                    child: Form(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: FormInput3(
                                  textInputType: TextInputType.text,
                                  errorText:
                                      userController.validityFirstName.message,
                                  hint: "First Name",
                                  hintColor: AppColors.commoneadingtextColor,
                                  onSaved: (String value) {
                                    userController.checkFirstName(value);
                                    userController.updateUserBuilder();
                                  },
                                  formatter: FilteringTextInputFormatter.allow(
                                    RegExp("[A-Z a-z _ . @ 0-9]"),
                                  ),
                                  obsecureText: false,
                                  maxLength: 50,
                                  myController: managerFirstNameController,
                                  focusNode: fnNode,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: FormInput3(
                                  textInputType: TextInputType.text,
                                  errorText:
                                      userController.validityLastName.message,
                                  hint: "Last Name",
                                  hintColor: AppColors.commoneadingtextColor,
                                  onSaved: (String value) {
                                    userController.checkLastName(value);
                                    userController.updateUserBuilder();
                                  },
                                  formatter: FilteringTextInputFormatter.allow(
                                    RegExp("[A-Z a-z _ . @ 0-9]"),
                                  ),
                                  obsecureText: false,
                                  maxLength: 50,
                                  myController: managerLastNameController,
                                  focusNode: lNode,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: FormInput3(
                                  textInputType: TextInputType.number,
                                  errorText: userController
                                      .validityPhoneNumber.message,
                                  hint: "Mobile Number",
                                  hintColor: AppColors.commoneadingtextColor,
                                  onSaved: (String value) {
                                    userController.checkPhoneNumber(value);
                                    userController.updateUserBuilder();
                                  },
                                  formatter: FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"),
                                  ),
                                  obsecureText: false,
                                  maxLength: 50,
                                  myController: managerMobileNumberController,
                                  focusNode: mnNode,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: FormInput3(
                                  textInputType: TextInputType.text,
                                  errorText: userController
                                      .validityManagerNumber.message,
                                  hint: "Manager Number",
                                  hintColor: AppColors.commoneadingtextColor,
                                  onSaved: (String value) {
                                    userController.checkManagerNumber(value);
                                    userController.updateUserBuilder();
                                  },
                                  formatter: FilteringTextInputFormatter.allow(
                                    RegExp("[A-Z a-z _ . @ 0-9]"),
                                  ),
                                  obsecureText: false,
                                  maxLength: 50,
                                  myController: managerNumberController,
                                  focusNode: mNode,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: _locations.map((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    hint: Text("Select Branch"),
                                    onChanged: (newVal) {
                                      // userController.upDateBranch(newVal);
                                      _selectedLocation = newVal;
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: HeroButton(
                                  width: 140.0,
                                  height: 50.0,
                                  radius: 6.0,
                                  gradient: AppColors.primaryColor,
                                  title: 'Add  Manager',
                                  onPressed: () {
                                    WidgetProperties.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

 Future<void> registerManager(BuildContext buildContext) {
    userModel.firstName = managerFirstNameController.text;
    userModel.lastName = managerLastNameController.text;
    userModel.phone = managerMobileNumberController.text;
    userModel.managerNumber = managerNumberController.text;
    //
    // if (!userController.selectedBranch.isNullOrBlank)
    //   userModel.branchId = userController.selectedBranch.id ?? 0;
    // if (userModel.branchId.isNullOrBlank) {
    //   Fluttertoast.showToast(
    //     msg: "Please Enter Branch Name",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //   );
    // }

    if (userController.checkManagerFormValidation(userModel)) {
      // userController.addUser(userModel, buildContext, "managers");
      FireStoreService().addUser(userModel, "managers");
      WidgetProperties.showToast(
          "You have  Successfully Registered", Colors.white, Colors.green);
// WidgetProperties.goToNextPageWithReplacement(buildContext, OtpScreen());
    } else {
      userController.updateUserBuilder();
    }
  }
}
