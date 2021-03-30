import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput3.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/user_controller.dart';
import 'package:gas_station/db/db_service.dart';
import 'package:gas_station/models/branch_model.dart';
import 'package:gas_station/models/user/user_model.dart';
import 'package:gas_station/screens/dashboard/admin_dashboard.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

class EmployeeForm extends StatelessWidget {
  List<String> _locations = ["Riyadh Branch", "Madinah Branch"];
  List<BranchModel> _branchModelList;
  String _selectedLocation = 'Select Branch';

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('branches');

  var userModel = UserModel();

  var userController = Get.put(UserController());

  var fnNode = FocusNode();
  var lNode = FocusNode();
  var mnNode = FocusNode();
  var empNode = FocusNode();

  var employeeFirstNameController = TextEditingController();
  var employeeLastNameController = TextEditingController();
  var employeeMobileNumberController = TextEditingController();
  var employeeNumberController = TextEditingController();

  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
// borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      appBarTitle: 'New Employee',
      bodyContent: GetBuilder<UserController>(
        init: userController,
        initState: (child) {},
        builder: (_) {
          return Container(
            margin: EdgeInsets.only(
                top: 20.0, left: 15.0, right: 15.0, bottom: 10.0),
            alignment: Alignment.center,
            decoration: _listDecoration,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  child: Textview2(
                    title: "New Employee",
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
                                margin: EdgeInsets.only(top: 20.0),
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
                                  myController: employeeFirstNameController,
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
                                  myController: employeeLastNameController,
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
                                  myController: employeeMobileNumberController,
                                  focusNode: mnNode,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: FormInput3(
                                  textInputType: TextInputType.text,
                                  errorText: userController
                                      .validityEmployeeNumber.message,
                                  hint: "Employee Number",
                                  hintColor: AppColors.commoneadingtextColor,
                                  onSaved: (String value) {
                                    userController.checkEmployeeNumber(value);
                                    userController.updateUserBuilder();
                                  },
                                  formatter: FilteringTextInputFormatter.allow(
                                    RegExp("[A-Z a-z _ . @ 0-9]"),
                                  ),
                                  obsecureText: false,
                                  maxLength: 50,
                                  myController: employeeNumberController,
                                  focusNode: empNode,
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 10.0),
                              //   child: DropdownButton<String>(
                              //       isExpanded: true,
                              //       items: _locations.map((String val) {
                              //         return DropdownMenuItem<String>(
                              //           value: val,
                              //           child: Text(val),
                              //         );
                              //       }).toList(),
                              //       hint: Text("Select Branch"),
                              //       onChanged: (newVal) {
                              //         // userController.upDateBranch(newVal);
                              //         _selectedLocation = newVal;
                              //       }),
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: HeroButton(
                                  width: 140.0,
                                  height: 50.0,
                                  radius: 6.0,
                                  gradient: AppColors.primaryColor,
                                  title: 'Add  Employee',
                                  onPressed: () {
                                    registerEmployee(context);
                                    // WidgetProperties.pop(context);
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
            ),
          );
        },
      ),
    );
  }

  Future<void> registerEmployee(BuildContext buildContext) {
    userModel.firstName = employeeFirstNameController.text;
    userModel.lastName = employeeLastNameController.text;
    userModel.phone = employeeMobileNumberController.text;
    userModel.employeeNumber = employeeNumberController.text;

// ignore: deprecated_member_use
//     if (!userController.selectedBranch.isNullOrBlank)
//       userModel.branchId = userController.selectedBranch.id ?? 0;
//     if (userModel.branchId.isNullOrBlank) {
//       Fluttertoast.showToast(
//         msg: "Please Enter Branch Name",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }

    if (userController.checkEmployeeFormValidation(userModel)) {
      // userController.addUser(userModel, buildContext, "employees");
      FireStoreService().addUser(userModel, "employees");
      Fluttertoast.showToast(
        msg: "You have Successfully Registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      employeeFirstNameController.text="";
      employeeLastNameController.text="";
      employeeMobileNumberController.text="";
      employeeNumberController.text="";
      WidgetProperties.goToNextPage(buildContext, AdminDashboard());

// WidgetProperties.goToNextPageWithReplacement(buildContext, OtpScreen());
    } else {
      userController.updateUserBuilder();
    }
  }
}
