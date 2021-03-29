import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_station/common/common_screen.dart';
import 'package:gas_station/common/custom_button.dart';
import 'package:gas_station/common/custominput3.dart';
import 'package:gas_station/common/text_view.dart';
import 'package:gas_station/utils/colors.dart';


class NotificationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationFormState();
  }
}

class _NotificationFormState extends State<NotificationForm>{
  List<String> _locations = ["Riyadh Branch","Madinah Branch"];
  String _selectedLocation = 'Select Branch';

  var fnNode = FocusNode();
  var lNode = FocusNode();
  var mnNode = FocusNode();
  var mNode = FocusNode();

  var userFirstNameController = TextEditingController();
  var userLastNameController = TextEditingController();
  var userMobileNumberController = TextEditingController();
  var userManagerNumberController = TextEditingController();

  var _listDecoration = BoxDecoration(
      color: AppColors.textWhiteColor,
      // borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.5, color: AppColors.primaryColor),
      shape: BoxShape.rectangle);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      appBarTitle: 'New Notification ',
      bodyContent: Container(
        margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0,bottom: 10.0),
        alignment: Alignment.center,
        decoration: _listDecoration,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 4.0),
              child:  Textview2(
                title:"New Notification",
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            Container(
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
                            errorText: "",
                            hint: "Notification Name",
                            hintColor: AppColors.commoneadingtextColor,
                            onSaved: (String value) {},
                            formatter: FilteringTextInputFormatter.allow(
                              RegExp("[A-Z a-z _ . @ 0-9]"),
                            ),
                            obsecureText: false,
                            maxLength: 50,
                            myController: userFirstNameController,
                            focusNode: fnNode,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton<String>(
                              isExpanded: true,
                              items: _locations.map((String val) {
                                return  DropdownMenuItem<String>(
                                  value: val,
                                  child:  Text(val),
                                );
                              }).toList(),
                              hint: Text("Select Branch"),
                              onChanged: (newVal) {
                                setState(() {
                                  _selectedLocation = newVal;
                                });
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          child: HeroButton(
                            width: 180.0,
                            height: 37.0,
                            radius: 6.0,
                            gradient: AppColors.primaryColor,
                            title: 'Add  Notification',
                            onPressed: () {
                              // WidgetProperties.goToNextPageWithReplacement(
                              //     context, EmployeeForm());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}