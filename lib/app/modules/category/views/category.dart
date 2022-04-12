import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/Provider.dart';

import '../../../routes/app_pages.dart';
import '../../e_services/controllers/e_services_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class CategoryView extends StatefulWidget {
  CategoryView({Key key}) : super(key: key);

  @override
  CategoryViewState createState() => new CategoryViewState();
}

class CategoryViewState extends State<CategoryView> {
  final EServicesController eServicesController =
      Get.find<EServicesController>();
  final ProfileController profileController = ProfileController();
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    eServicesController.getAllCategories();
    if (profileController.serviceProvider != null &&
        !profileController.serviceProvider.isBlank) {
      print("many cats " +
          Get.find<EServicesController>().categories.length.toString());
      Future.delayed(Duration(seconds: 5), (() {
        print("many cats " +
            Get.find<EServicesController>().categories.length.toString());
      }));
      int index = 0;
      // Get.find<EServicesController>().categories.forEach((element) {
      //   bool a;

      //   // profileController.serviceProvider.value.categories.forEach((value) {
      //   //   if (element.name == value.name) {
      //   //     eServicesController.chosencats[index] = true;
      //   //   }
      //   // });
      //   index++;
      //   // print(element.name);
      //   // print(profileController.serviceProvider.value.categories[0].name);
      //   //         print(profileController.serviceProvider.value.categories[1].name);

      //   // if(a=profileController.serviceProvider.value.categories.contains(element)){

      //   //   int index=profileController.serviceProvider.value.categories.indexOf(element);
      //   //   Get.find<EServicesController>().chosencats[index]=true;
      //   // }
      //   print("condition " + a.toString());
      // });
    }
    // print(controller.serviceProvider.value.categories.first.name);
    // namecontrol.text=controller.serviceProvider.value.name
    // eServicesController.getAllCategories();
    return SafeArea(
      child: Scaffold(
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
            child:
                // Column(
                //   children: [
                //     Text("Categories".tr, style: Get.textTheme.headline5)
                //         .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                //     // for(var check in checks)
                //     // check,
                //     SizedBox(
                //       height: MediaQuery.of(context).size.height * 0.03,
                //     ),

                Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24),
              child: MaterialButton(
                elevation: 0,
                onPressed: () {
                  Get.toNamed(
                    Routes.PROFILE,
                  );
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.accentColor,
                child: Text("Next".tr,
                    style: Get.textTheme.bodyText2
                        .merge(TextStyle(color: Get.theme.primaryColor))),
              ),
            ),

            // ],
          ),
          body: GetBuilder<EServicesController>(builder: (control) {
            if (control.categories != null && control.categories.length > 0)
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  children: [
                    Center(child: Text('Categories')),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: eServicesController.categories.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 14, left: 20, right: 20),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 10),
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Get.theme.focusColor.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: Offset(0, 5)),
                                ],
                                border: Border.all(
                                    color: Get.theme.focusColor
                                        .withOpacity(0.05))),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    eServicesController.categories[index].name),
                                Obx((() => Checkbox(
                                      activeColor: Colors.amber,
                                      checkColor: Colors.amber,
                                      value:
                                          eServicesController.chosencats[index],
                                      onChanged: (bool newValue) {
                                        // setState(() {
                                        eServicesController.chosencats[index] =
                                            newValue;
                                        eServicesController.update();
                                        Get.find<ProfileController>().update();
                                        print(eServicesController
                                            .categories[index].id);
                                        print(eServicesController
                                            .chosencats[index]);
                                        // });
                                      },
                                    ))),
                              ],
                            ),
                          );
                        })),
                  ],
                ),
              );
            else {
              return CircularProgressIndicator();
            }
          })),
    );
  }
}
