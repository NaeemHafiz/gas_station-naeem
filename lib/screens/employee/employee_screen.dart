import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/user_controller.dart';
import 'package:gas_station/models/user/user_model.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/my_behaviour.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

import 'employee_form.dart';

class EmployeeScreen extends StatelessWidget {
  CollectionReference ref;

  var userController = Get.put(UserController());

  var userSearchMobileTextController = TextEditingController();

  List<String> names = [
    "Naeem Hassan",
    "Umair Raza",
    "Nimra",
    "Ambar",
    "Ayesha"
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
      appBarTitle: 'Employees',
      bodyContent: GetBuilder<UserController>(
        initState: (child) {
          ref = FirebaseFirestore.instance.collection('employees');
        },
        init: userController,
        builder: (_) {
          return ScrollConfiguration(
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
                        title: 'Add New Employee',
                        onPressed: () {
                          WidgetProperties.goToNextPageWithReplacement(
                              context, EmployeeForm());
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
                                textInputType: TextInputType.text,
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
                      height: MediaQuery.of(context).size.height * .4,
                      margin: EdgeInsets.only(
                          top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
                      alignment: Alignment.center,
                      decoration: _listDecoration,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4.0),
                            child: Textview2(
                              title: "Employee List",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Flexible(
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: ref.snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return ListView.builder(
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // var id = snapshot.data.docs[index].id;
                                            // print(id);
                                            UserModel userModel =
                                                UserModel.fromMap(snapshot
                                                    .data.docs[index]
                                                    .data());

                                            return listWidget(
                                                context, userModel);
                                          },
                                        );
                                      }))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget listWidget(BuildContext buildContext, UserModel userModel) {
    return Container(
      //margin: EdgeInsets.all(10.0),
      child: TweenAnimationBuilder(
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
                          Icons.person,
                          size: 30.0,
                          color: AppColors.listColor,
                        ),
                        Textview2(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          title: userModel.firstName != null
                              ? userModel.firstName
                              : "James Bond",
                          color: AppColors.listColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
        tween: Tween<double>(begin: 0, end: 5),
        duration: Duration(milliseconds: 1000),
        curve: Curves.bounceInOut,
        builder: (BuildContext context, double _val, Widget child) {
          return Padding(
            padding: EdgeInsets.only(top: _val),
            child: child,
          );
        },
      ),
    );
  }
}
