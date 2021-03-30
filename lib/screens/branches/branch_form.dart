import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput3.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/branch_controller.dart';
import 'package:gas_station/db/db_service.dart';
import 'package:gas_station/models/branch_model.dart';
import 'package:gas_station/screens/dashboard/admin_dashboard.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

class BranchForm extends StatelessWidget {
  var branchController = Get.find<BranchController>();

  var branchNameController = TextEditingController();
  var branchAddressController = TextEditingController();

  List<String> names = [
    "Riyadh- Branch",
    "Madina- Branch",
  ];

  var branchModel = BranchModel();

  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  var ctNode1 = FocusNode();
  var ctNode2= FocusNode();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      appBarTitle: "New Branch",
      bodyContent: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
        decoration: _listDecoration,
        child: GetBuilder<BranchController>(
          initState: (child) {},
          builder: (_) {
            return Form(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    FormInput3(
                      textInputType: TextInputType.text,
                      errorText: branchController.validityBranchName.message,
                      hint: "Branch Name",
                      hintColor: AppColors.commoneadingtextColor,
                      onSaved: (String value) {
                        branchController.checkBranchName(value);
                        branchController.updateBranchBuilder();
                      },
                      formatter: FilteringTextInputFormatter.allow(
                        RegExp("[A-Z a-z _ . @ 0-9]"),
                      ),
                      obsecureText: false,
                      maxLength: 50,
                      myController: branchNameController,
                      focusNode: ctNode1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      child: FormInput3(
                        textInputType: TextInputType.text,
                        errorText:
                            branchController.validityBranchAddress.message,
                        hint: "Branch Location",
                        hintColor: AppColors.commoneadingtextColor,
                        onSaved: (String value) {
                          branchController.checkBranchAddress(value);
                          branchController.updateBranchBuilder();
                        },
                        formatter: FilteringTextInputFormatter.allow(
                          RegExp("[A-Z a-z _ . @ 0-9]"),
                        ),
                        obsecureText: false,
                        maxLength: 50,
                        myController: branchAddressController,
                        focusNode: ctNode2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 35.0),
                      child: HeroButton(
                        width: 170.0,
                        height: 45.0,
                        radius: 6.0,
                        gradient: AppColors.primaryColor,
                        title: 'Add Branch',
                        onPressed: () {
                          addBranch(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
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
                        Icons.home,
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

  Future<void> addBranch(BuildContext buildContext) {
    branchModel.name = branchNameController.text;
    branchModel.branchAddress = branchAddressController.text;

    if (branchController.checkBranchValidation(branchModel)) {
      FireStoreService().addBranch(branchModel, "branches");

      WidgetProperties.showToast(
          "Branch Added Successfully", Colors.white, Colors.green);

      branchNameController.text = "";
      branchAddressController.text = "";

      WidgetProperties.goToNextPage(buildContext, AdminDashboard());
// WidgetProperties.goToNextPageWithReplacement(
// buildContext, OtpScreen());
// WidgetProperties.goToNextPageWithReplacement(
// buildContext, OtpScreen());
    } else {
      branchController.updateBranchBuilder();
    }
  }
}
