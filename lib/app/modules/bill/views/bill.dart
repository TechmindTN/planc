import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:home_services_provider/app/models/MaterialMod.dart' as M;
import 'package:get/get.dart';
import 'package:home_services_provider/app/Network/MaterialNetwork.dart';
import 'package:home_services_provider/app/global_widgets/map_select_widget.dart';
import 'package:home_services_provider/app/models/Bill.dart';
import 'package:home_services_provider/app/models/Branch.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services_provider/app/modules/bill/views/matview.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_services_controller.dart';

import '../../../global_widgets/text_field_widget.dart';
import '../../../models/MaterialMod.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/bill_controller.dart';

class BillView extends GetView<BillController> {
  final bool hideAppBar;

  MaterialMod material = MaterialMod();
  BillController billcontroller = Get.find<BillController>();
  final GlobalKey<FormState> _billForm = new GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  TextEditingController servicecontrol = TextEditingController();
  TextEditingController discountcontrol = TextEditingController();
  TextEditingController studycontrol = TextEditingController();
  TextEditingController workforcecontrol = TextEditingController();
  TextEditingController matnamecontrol = TextEditingController();
  TextEditingController matcountcontrol = TextEditingController();
  TextEditingController matpricecontrol = TextEditingController();
  TextEditingController matsupcontrol = TextEditingController();
  MaterialNetwork materialNetwork = MaterialNetwork();

  final EServicesController eServicesController =
      Get.find<EServicesController>();
  int nbr = 0;

  BillView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }
  bool ok = false;

  @override
  Widget build(BuildContext context) {
    // int con = 0;
    // eServicesController.chosencats.forEach((element) {
    //   if (element) con++;
    // });
// eServicesController.getAllCategories().then((value){
// eServicesController.categories.forEach((element){
//       // chosencats..add(false);
//       eServicesController.chosencats.add(false);
//     });
//      });

    // if (profileController.serviceProvider != null &&
    //     !profileController.serviceProvider.isBlank) {
    //   print("many cats " +
    //       Get.find<EServicesController>().categories.length.toString());
    //   int index = 0;
    //   Get.find<EServicesController>().categories.forEach((element) {
    //     bool a;

    //     profileController.serviceProvider.value.categories.forEach((value) {
    //       if (element.name == value.name) {
    //         eServicesController.chosencats[index] = true;
    //       }
    //     });
    //     index++;

    //     print("condition " + a.toString());
    //   });
    // }
    // print(controller.serviceProvider.value.categories.first.name);
    // namecontrol.text=controller.serviceProvider.value.name
    // eServicesController.getAllCategories();
    // print(controller.serviceProvider.value.name);
    // List<Widget> checks = [];
    // Get.put(EServicesController());
    // eServicesController.
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Bill".tr,
                  style: context.textTheme.headline6,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios,
                      color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
              ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Get.theme.focusColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    billcontroller.mat.forEach((element) async {
                      Map<String, dynamic> matdata = {
                        'name': element.name,
                        'supplier': element.supplier,
                        'price': element.price,
                      };
                      materialNetwork.addMaterial(matdata).then((value) {
                        print('aaaaaa ' + value.id);
                        Map<String, dynamic> billdata = {
                          'name': element.name,
                          'material': value,
                          'price': element.price,
                          'count': element.count
                        };
                        billcontroller.billmat.add(billdata);
                      });
                      controller.bill.value.service_fee =
                          double.parse(servicecontrol.text);
                      controller.bill.value.discount =
                          double.parse(discountcontrol.text);
                      controller.bill.value.study_fee =
                          double.parse(studycontrol.text);
                      controller.bill.value.workforce_fee =
                          double.parse(workforcecontrol.text);
                    });

                    // Bill tempBill = Bill(
                    //   discount: double.parse(discountcontrol.text),
                    //   service_fee: double.parse(servicecontroller.text),
                    //   state: 'pending',
                    //   total_price: 0,
                    //   study_fee: double.parse(studycontrol.text),
                    //   workforce_fee: double.parse(workforcecontrol.text),
                    //   date: Timestamp.now(),
                    //   id: '',
                    // );
                    // print(authController.currentUser.value.id);
                    controller.saveBill(_billForm);
                    // Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.accentColor,
                  child: Text("Save".tr,
                      style: Get.textTheme.bodyText2
                          .merge(TextStyle(color: Get.theme.primaryColor))),
                ),
              ),
              SizedBox(width: 10),
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  // controller.resetProfileForm(_billForm);
                  Navigator.pop(context);
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.hintColor.withOpacity(0.1),
                child: Text("Retern".tr, style: Get.textTheme.bodyText2),
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: _billForm,
          child: ListView(
            shrinkWrap: true,
            primary: true,
            children: [
              Text("Bill details".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              Text("Change the following details and save them".tr,
                      style: Get.textTheme.caption)
                  .paddingSymmetric(horizontal: 22, vertical: 5),
              // getImageHeaderWidget(authController),
              TextFieldWidget(
                control: servicecontrol,
                // onSaved: (input) => controller.bill.value.service_fee = input,
                // validator: (input) =>
                //     input.isNum ? "Should be double".tr : null,
                // initialValue: controller.serviceProvider.value.name,
                hintText: "100dt".tr,
                labelText: "Service fee".tr,
                // iconData: Icons.person_outline,
              ),
              TextFieldWidget(
                control: workforcecontrol,
                // onSaved: (input) =>
                //     controller.bill.value.workforce_fee = input as double,
                // validator: (input) =>
                //     input.isNum ? "Should be double".tr : null,
                // initialValue: controller.serviceProvider.value.description,
                hintText: "50dt".tr,
                labelText: "Workforce fee".tr,
                // iconData: Icons.map_outlined,
              ),
              TextFieldWidget(
                control: studycontrol,
                keyboardType: TextInputType.phone,
                // onSaved: (input) => Get.find<BillController>()
                //     .bill
                //     .value
                //     .study_fee = input as double,
                // validator: (input) =>
                //     input.isNum ? "Should be double".tr : null,
                // initialValue: controller.serviceProvider.value.phone.toString(),
                hintText: "20dt",
                labelText: "Study fee".tr,
                // iconData: Icons.phone_android_outlined,
              ),

              // GetBuilder<ProfileController>(builder: (profileController) {
              //   return MapSelect(context, profileController, addresscontrol);
              // }),
              TextFieldWidget(
                control: discountcontrol,
                // onSaved: (input) =>
                //     controller.bill.value.discount = input as double,
                // validator: (input) =>
                //     input.isNum ? "Should be double".tr : null,
                // initialValue: controller.serviceProvider.value.website,
                hintText: "10%".tr,
                labelText: "Discount".tr,
                // iconData: Icons.map_outlined,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Materials".tr, style: Get.textTheme.headline5)
                      .paddingOnly(top: 25, bottom: 25, right: 22, left: 22),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25, bottom: 25, right: 22, left: 22),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: Dialog(
                                  child: SingleChildScrollView(
                                    child: Column(children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                      Text(" Add material ",
                                          style: Get.textTheme.headline6),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.75,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: ListView(
                                            shrinkWrap: true,
                                            primary: true,
                                            children: [
                                              // getImageHeaderWidget(authController),
                                              TextFieldWidget(
                                                control: matnamecontrol,
                                                // onSaved: (input) => controller.bill.value.service_fee = input,
                                                // validator: (input) =>
                                                //     input.isNum ? "Should be double".tr : null,
                                                // initialValue: controller.serviceProvider.value.name,
                                                hintText: "SSD 256Go".tr,
                                                labelText: "Material name".tr,
                                                // iconData: Icons.person_outline,
                                              ),
                                              TextFieldWidget(
                                                control: matsupcontrol,
                                                // onSaved: (input) => controller.bill.value.service_fee = input,
                                                // validator: (input) =>
                                                //     input.isNum ? "Should be double".tr : null,
                                                // initialValue: controller.serviceProvider.value.name,
                                                hintText: "planc".tr,
                                                labelText: "supplier".tr,
                                                // iconData: Icons.person_outline,
                                              ),
                                              TextFieldWidget(
                                                control: matcountcontrol,

                                                // onSaved: (input) => controller.bill.value.service_fee = input,
                                                // validator: (input) =>
                                                //     input.isNum ? "Should be double".tr : null,
                                                // initialValue: controller.serviceProvider.value.name,
                                                hintText: "99".tr,
                                                labelText: "Countity ".tr,
                                                // iconData: Icons.person_outline,
                                              ),
                                              TextFieldWidget(
                                                control: matpricecontrol,
                                                // onSaved: (input) => controller.bill.value.service_fee = input,
                                                // validator: (input) =>
                                                //     input.isNum ? "Should be double".tr : null,
                                                // initialValue: controller.serviceProvider.value.name,
                                                hintText: "100dt".tr,
                                                labelText: "price".tr,
                                                // iconData: Icons.person_outline,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Row(
                                          children: [
                                            MaterialButton(
                                              elevation: 0,
                                              onPressed: () {
                                                material.name =
                                                    matnamecontrol.text;
                                                material.supplier =
                                                    matsupcontrol.text;
                                                material.count = int.parse(
                                                    matcountcontrol.text);
                                                material.price = double.parse(
                                                    matpricecontrol.text);
                                                billcontroller.mat
                                                    .add(material);

                                                billcontroller.matwid.add(
                                                    Matview(mat: material));
                                                billcontroller.update();
                                                Navigator.pop(context);
                                              },
                                              color: Get.theme.accentColor,
                                              height: 40,
                                              child: Wrap(
                                                runAlignment:
                                                    WrapAlignment.center,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                spacing: 9,
                                                children: [
                                                  Icon(Icons.add,
                                                      color: Get
                                                          .theme.primaryColor,
                                                      size: 24),
                                                  Text(
                                                    "Add".tr,
                                                    style: Get
                                                        .textTheme.subtitle1
                                                        .merge(TextStyle(
                                                            color: Get.theme
                                                                .primaryColor)),
                                                  ),
                                                ],
                                              ),
                                              shape: StadiumBorder(),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025,
                                            ),
                                            MaterialButton(
                                              elevation: 0,
                                              color: Get.theme.focusColor
                                                  .withOpacity(0.2),
                                              height: 40,
                                              onPressed: () {
                                                navigator.pop();
                                              },
                                              child: Wrap(
                                                runAlignment:
                                                    WrapAlignment.center,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                spacing: 9,
                                                children: [
                                                  Icon(Icons.cancel,
                                                      color:
                                                          Get.theme.hintColor,
                                                      size: 24),
                                                  Text(
                                                    "Cancel".tr,
                                                    style: Get
                                                        .textTheme.subtitle1
                                                        .merge(TextStyle(
                                                            color: Get.theme
                                                                .hintColor)),
                                                  ),
                                                ],
                                              ),
                                              shape: StadiumBorder(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.accentColor,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              GetBuilder<BillController>(
                  init: BillController(),
                  builder: (val) {
                    return Column(children: [
                      for (var ma in billcontroller.matwid) ma,
                    ]);
                  }),

              // TextFieldWidget(
              //   control: websitecontrol,
              //   onSaved: (input) =>
              //       controller.bill.value.date = input as Timestamp,
              //   validator: (input) =>
              //       input.isDateTime ? "Should be double".tr : null,
              //   // initialValue: controller.serviceProvider.value.website,
              //   hintText: "07/05/2000".tr,
              //   labelText: "Date".tr,
              //   // iconData: Icons.map_outlined,
              // ),
              // TextFieldWidget(
              //   control: websitecontrol,
              //   onSaved: (input) => controller.bill.value.state = input,
              //   validator: (input) => input.length < 3
              //       ? "Should be more than 3 letters".tr
              //       : null,
              //   // initialValue: controller.serviceProvider.value.website,
              //   hintText: "".tr,
              //   labelText: "State".tr,
              //   // iconData: Icons.map_outlined,
              // ),
            ],
          ),
        ));
  }
}
