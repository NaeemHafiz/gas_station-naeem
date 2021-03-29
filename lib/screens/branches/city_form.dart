import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput3.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/controllers/city_controller.dart';
import 'package:gas_station/db/db_service.dart';
import 'package:gas_station/models/city_model.dart';
import 'package:gas_station/utils/colors.dart';
import 'package:gas_station/utils/widgetproperties.dart';
import 'package:get/get.dart';

class CityForm extends StatelessWidget {
  var cityModel = CityModel();
  var cityController = Get.put(CityController());

  var cityTextController = TextEditingController();
  CollectionReference ref;


  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  var ctNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
        appBarTitle: "Branch City",
        bodyContent: GetBuilder<CityController>(
          initState: (child) {
            ref = FirebaseFirestore.instance.collection('cities');
          },
          init: cityController,
          builder: (_) {
            return Column(
              children: [
                Form(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                    child: FormInput3(
                      textInputType: TextInputType.text,
                      errorText: cityController.validityCityName.message,
                      hint: "Enter City",
                      hintColor: AppColors.commoneadingtextColor,
                      onSaved: (String value) {
                        cityController.checkCityName(value);
                        cityController.updateCityBuilder();
                      },
                      formatter: FilteringTextInputFormatter.allow(
                        RegExp("[A-Z a-z _ . @ 0-9]"),
                      ),
                      obsecureText: false,
                      maxLength: 50,
                      myController: cityTextController,
                      focusNode: ctNode,
                    ),
                  ),
                ),
                HeroButton(
                  width: 130.0,
                  height: 30.0,
                  radius: 6.0,
                  gradient: AppColors.primaryColor,
                  title: 'Add City',
                  onPressed: () {
                    addCity(context);
                    // WidgetProperties.goToNextPageWithReplacement(
                    //     context, CityForm());
                  },
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
                    alignment: Alignment.center,
                    decoration: _listDecoration,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
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
                              height: MediaQuery.of(context).size.height / 3,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: ref.snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // var id = snapshot.data.docs[index].id;
                                        // print(id);
                                        CityModel cityModel = CityModel.fromMap(
                                            snapshot.data.docs[index].data());

                                        return listWidget(context, cityModel);
                                      },
                                    );
                                  }))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }

  Widget listWidget(BuildContext buildContext, CityModel cityModel) {
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
                        title: cityModel.name != null
                            ? cityModel.name
                            : "New York",
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

  // ignore: always_declare_return_types
  Future<void> addCity(BuildContext buildContext) {
    cityModel.name = cityTextController.text;

    if (cityController.checkCityNameValidation(cityModel)) {
      FireStoreService().addCity(cityModel, "cities");

      WidgetProperties.showToast(
          "Branch City Added Successfully", Colors.white, Colors.green);

      cityTextController.text = "";
    } else {
      cityController.updateCityBuilder();
    }
  }
}
