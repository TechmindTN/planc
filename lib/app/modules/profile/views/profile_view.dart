import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/Branch.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_services_controller.dart';

import '../../../global_widgets/text_field_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool hideAppBar;
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  TextEditingController namecontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.name);
  TextEditingController desccontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.description);
  TextEditingController countrycontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .country);
  TextEditingController phonecontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .phone
          .toString());

  TextEditingController citycontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .city);
  TextEditingController statecontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .state);
  TextEditingController addresscontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .address);
  TextEditingController websitecontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.website);
  TextEditingController linkcontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .social_media['LinkedIn']);
  TextEditingController fbcontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .social_media['Facebook']);
  TextEditingController instcontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .branches
          .first
          .social_media['Instagram']);

  final EServicesController eServicesController =
      Get.find<EServicesController>();
  int nbr = 0;

  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }
  bool ok = false;

  @override
  Widget build(BuildContext context) {
    print(controller.serviceProvider.value.description);
    // namecontrol.text=controller.serviceProvider.value.name
    eServicesController.getAllCategories();
    print(controller.serviceProvider.value.name);
    List<Widget> checks = [];
    Get.put(EServicesController());
    // eServicesController.
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Profile".tr,
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
                    if (Get.find<ProfileController>()
                                .serviceProvider
                                .value
                                .name ==
                            '' ||
                        Get.find<ProfileController>().serviceProvider == null) {
                      ServiceProvider tempProvider = ServiceProvider(
                          description: desccontrol.text,
                          media: [],
                          name: namecontrol.text,
                          profile_photo: '',
                          website: websitecontrol.text,
                          categories: [],

                          // user: authController.userServices.dr,
                          // user: authController.userServices.getUserRef(authController.currentUser.value.id),
                          branches: [
                            Branch(
                              address: desccontrol.text,
                              branch_name: '',
                              city: citycontrol.text,
                              country: countrycontrol.text,
                              is_main: true,
                              phone: int.parse(phonecontrol.text),
                              social_media: {
                                "Facebook": fbcontrol.text,
                                "LinkedIn": linkcontrol.text,
                                "Instagram": instcontrol.text
                              },
                              state: statecontrol.text,
                              open_days: {},
                              zip_code: 0000,
                            ),
                          ]);
                      print(authController.currentUser.value.id);
                      controller.saveProviderForm(_profileForm, tempProvider);
                    } else {
                      controller.edit();
                      controller.update();
                    }
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
                  controller.resetProfileForm(_profileForm);
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.hintColor.withOpacity(0.1),
                child: Text("Reset".tr, style: Get.textTheme.bodyText2),
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: _profileForm,
          child: ListView(
            shrinkWrap: true,
            primary: true,
            children: [
              Text("Profile details".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              Text("Change the following details and save them".tr,
                      style: Get.textTheme.caption)
                  .paddingSymmetric(horizontal: 22, vertical: 5),
              getImageHeaderWidget(authController),
              TextFieldWidget(
                control: namecontrol,
                onSaved: (input) =>
                    controller.serviceProvider.value.name = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue: controller.serviceProvider.value.name,
                hintText: "John Doe".tr,
                labelText: "Company Name".tr,
                iconData: Icons.person_outline,
              ),
              TextFieldWidget(
                control: desccontrol,
                onSaved: (input) =>
                    controller.serviceProvider.value.description = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue: controller.serviceProvider.value.description,
                hintText: "What does your company do".tr,
                labelText: "Description".tr,
                iconData: Icons.map_outlined,
              ),

              // TextFieldWidget(
              //   onSaved: (input) => controller.serviceProvider.value.email = input,
              //   validator: (input) => !input.contains('@') ? "Should be a valid email" : null,
              //   initialValue: controller.serviceProvider.value.email,
              //   hintText: "johndoe@gmail.com",
              //   labelText: "Email".tr,
              //   iconData: Icons.alternate_email,
              // ),
              TextFieldWidget(
                control: phonecontrol,
                keyboardType: TextInputType.phone,
                onSaved: (input) => controller.serviceProvider.value.branches
                    .first.phone = int.parse(input),
                validator: (input) =>
                    !input.startsWith('+') && !input.startsWith('00')
                        ? "Phone number must start with country code!".tr
                        : null,
                initialValue: controller
                    .serviceProvider.value.branches.first.phone
                    .toString(),
                hintText: "+1 565 6899 659",
                labelText: "Phone number".tr,
                iconData: Icons.phone_android_outlined,
              ),
              TextFieldWidget(
                control: countrycontrol,
                onSaved: (input) => controller
                    .serviceProvider.value.branches.first.country = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue:
                    controller.serviceProvider.value.branches.first.country,
                hintText: "Tunisia".tr,
                labelText: "Country".tr,
                iconData: Icons.map_outlined,
              ),
              TextFieldWidget(
                control: statecontrol,
                onSaved: (input) => controller
                    .serviceProvider.value.branches.first.state = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue:
                    controller.serviceProvider.value.branches.first.state,
                hintText: "Tunis".tr,
                labelText: "State".tr,
                iconData: Icons.map_outlined,
              ),
              TextFieldWidget(
                control: citycontrol,
                onSaved: (input) => controller
                    .serviceProvider.value.branches.first.city = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue:
                    controller.serviceProvider.value.branches.first.city,
                hintText: "Centre Urbain Nord".tr,
                labelText: "City".tr,
                iconData: Icons.map_outlined,
              ),
              TextFieldWidget(
                control: addresscontrol,
                onSaved: (input) => controller
                    .serviceProvider.value.branches.first.address = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue:
                    controller.serviceProvider.value.branches.first.address,
                hintText: "123 Street, City 136, State, Country".tr,
                labelText: "Address".tr,
                iconData: Icons.map_outlined,
              ),
              TextFieldWidget(
                control: websitecontrol,
                onSaved: (input) =>
                    controller.serviceProvider.value.website = input,
                validator: (input) => input.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                initialValue: controller.serviceProvider.value.website,
                hintText: "www.google.com".tr,
                labelText: "Website".tr,
                iconData: Icons.map_outlined,
              ),
              Text("Categories".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              // for(var check in checks)
              // check,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 14, left: 20, right: 20),
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Get.theme.focusColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5)),
                          ],
                          border: Border.all(
                              color: Get.theme.focusColor.withOpacity(0.05))),
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(eServicesController.categories[index].name),
                          Obx((() => Checkbox(
                                activeColor: Colors.amber,
                                checkColor: Colors.amber,
                                value: eServicesController.chosencats[index],
                                onChanged: (bool newValue) {
                                  // setState(() {
                                  eServicesController.chosencats[index] =
                                      newValue;
                                  eServicesController.update();
                                  controller.update();
                                  print(index);
                                  print(eServicesController.chosencats[index]);
                                  // });
                                },
                              ))),
                        ],
                      ),
                    );
                  })),

              Text("Social Media".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              // Text("Fill your old password and type new password and confirm it".tr, style: Get.textTheme.caption).paddingSymmetric(horizontal: 22, vertical: 5),
              Obx(() {
                return TextFieldWidget(
                  control: linkcontrol,
                  onSaved: (input) => controller.serviceProvider.value.branches
                      .first.social_media['LinkedIn'] = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue: controller.serviceProvider.value.branches.first
                      .social_media['LinkedIn'],
                  hintText: "".tr,
                  labelText: "LinkedIn".tr,
                  iconData: Icons.map_outlined,
                );
              }),
              Obx(() {
                return TextFieldWidget(
                  control: fbcontrol,
                  onSaved: (input) => controller.serviceProvider.value.branches
                      .first.social_media['Facebook'] = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue: controller.serviceProvider.value.branches.first
                      .social_media['Facebook'],
                  hintText: "".tr,
                  labelText: "Facebook".tr,
                  iconData: Icons.map_outlined,
                );
              }),
              Obx(() {
                return TextFieldWidget(
                  control: instcontrol,
                  onSaved: (input) => controller.serviceProvider.value.branches
                      .first.social_media['Instagram'] = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue: controller.serviceProvider.value.branches.first
                      .social_media['Instagram'],
                  hintText: "".tr,
                  labelText: "Instagram".tr,
                  iconData: Icons.map_outlined,
                );
              }),
              if (Get.find<ProfileController>().serviceProvider.value.name !=
                      '' &&
                  Get.find<ProfileController>().serviceProvider != null)
                addImageHeaderWidget(authController)
            ],
          ),
        ));
  }

  Widget getImageHeaderWidget(AuthController control) {
    return Container(
      height: 380,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(children: [
        Container(
            constraints: BoxConstraints(maxHeight: 250), child: control.im),
        //
        //         Container(
        //         height: 150,
        //         child: Image(
        //   image: NetworkImage(store.image,

        //   ),
        // ),
        //       ),
        SizedBox(height: 20),
        FloatingActionButton(
            onPressed: () async {
              control.changeImage();
              control.update();
              // storeimage.printInfo();
              //     final ImagePicker _picker = ImagePicker();

              //     final XFile image = await _picker.pickImage(source: ImageSource.gallery);
              //     File im=File(image.path);
              //     storeimage=Image.file(im);
              //       storeimage=Container(
              //         height: 150,
              //         child: Image(
              //   image: FileImage(im,

              //   ),
              // ),
              //       );
              //    print(storeimage);
              //   storecontrol.update();
            },
            child: Icon(Icons.camera))
      ]),
    );
  }

  Widget addImageHeaderWidget(AuthController control) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(children: [
        Column(
          children: [
            for (var img in control.iml) img,
          ],
        ),
        //
        //         Container(
        //         height: 150,
        //         child: Image(
        //   image: NetworkImage(store.image,

        //   ),
        // ),
        //       ),
        SizedBox(height: 20),
        FloatingActionButton(
            onPressed: () async {
              control.addImage();
              control.update();
              // storeimage.printInfo();
              //     final ImagePicker _picker = ImagePicker();

              //     final XFile image = await _picker.pickImage(source: ImageSource.gallery);
              //     File im=File(image.path);
              //     storeimage=Image.file(im);
              //       storeimage=Container(
              //         height: 150,
              //         child: Image(
              //   image: FileImage(im,

              //   ),
              // ),
              //       );
              //    print(storeimage);
              //   storecontrol.update();
            },
            child: Icon(Icons.camera))
      ]),
    );
  }
}
