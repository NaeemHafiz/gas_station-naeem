import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/branch_controller.dart';
import 'package:gas_station/models/branch_model.dart';
import 'package:gas_station/screens/branches/branch_form.dart';
import 'package:gas_station/screens/branches/city_form.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/my_behaviour.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

class BranchScreen extends StatelessWidget {
  CollectionReference ref;

  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
        appBarTitle: 'Branches',
        bodyContent: GetBuilder<BranchController>(
          initState: (child) {
            ref = FirebaseFirestore.instance.collection('branches');
          },
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
                        margin:
                            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeroButton(
                              width: 130.0,
                              height: 30.0,
                              radius: 6.0,
                              gradient: AppColors.primaryColor,
                              title: 'Add City',
                              onPressed: () {
                                WidgetProperties.goToNextPageWithReplacement(
                                    context, CityForm());
                              },
                            ),
                            HeroButton(
                              width: 70.0,
                              height: 30.0,
                              radius: 6.0,
                              gradient: AppColors.primaryColor,
                              title: 'Add New Branch',
                              onPressed: () {
                                WidgetProperties.goToNextPageWithReplacement(
                                    context, BranchForm());
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
                        alignment: Alignment.center,
                        decoration: _listDecoration,
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  child: Textview2(
                                    title: "Branch List",
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: ref
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              // var id = snapshot.data.docs[index].id;
                                              // print(id);
                                              BranchModel branchModel =
                                                  BranchModel.fromMap(snapshot
                                                      .data.docs[index]
                                                      .data());

                                              return listWidget(
                                                  context, branchModel);
                                            },
                                          );
                                        })
                                )
                              ],
                            ),
                          ),
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

  Widget listWidget(BuildContext buildContext, BranchModel branchModel) {
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
                        title: branchModel.name != null
                            ? branchModel.name
                            : "Damam",
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
