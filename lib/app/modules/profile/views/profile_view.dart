import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/global_widgets/map_select_widget.dart';
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
      text: Get.find<ProfileController>().serviceProvider.value.country);
  TextEditingController phonecontrol = TextEditingController(
      text:
          Get.find<ProfileController>().serviceProvider.value.phone.toString());

  TextEditingController citycontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.city);
  TextEditingController statecontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.state);
  TextEditingController addresscontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.address);
  TextEditingController websitecontrol = TextEditingController(
      text: Get.find<ProfileController>().serviceProvider.value.website);
  TextEditingController linkcontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .social_media['LinkedIn']);
  TextEditingController fbcontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .social_media['Facebook']);
  TextEditingController instcontrol = TextEditingController(
      text: Get.find<ProfileController>()
          .serviceProvider
          .value
          .social_media['Instagram']);

  final EServicesController eServicesController =
      Get.find<EServicesController>();
  int nbr = 0;

  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }
  bool ok = false;
  final ScrollController scrollController=ScrollController();

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

    if (profileController.serviceProvider != null &&
        !profileController.serviceProvider.isBlank) {
      print("many cats " +
          Get.find<EServicesController>().categories.length.toString());
      int index = 0;
      Get.find<EServicesController>().categories.forEach((element) {
        bool a;

        profileController.serviceProvider.value.categories.forEach((value) {
          if (element.name == value.name) {
            eServicesController.chosencats[index] = true;
          }
        });
        index++;
        // print(element.name);
        // print(profileController.serviceProvider.value.categories[0].name);
        //         print(profileController.serviceProvider.value.categories[1].name);

        // if(a=profileController.serviceProvider.value.categories.contains(element)){

        //   int index=profileController.serviceProvider.value.categories.indexOf(element);
        //   Get.find<EServicesController>().chosencats[index]=true;
        // }
        print("condition " + a.toString());
      });
    }
    // print(controller.serviceProvider.value.categories.first.name);
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
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return (!controller.loading)?Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        controller.loading=true;
                        controller.update();
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

                            address: addresscontrol.text,
                            // branch_name: '',
                            city: citycontrol.text,
                            country: countrycontrol.text,
                            // is_main: true,
                            phone: int.parse(phonecontrol.text),
                            social_media: {
                              "Facebook": fbcontrol.text,
                              "LinkedIn": linkcontrol.text,
                              "Instagram": instcontrol.text
                            },
                            state: statecontrol.text,
                            open_days: {},
                            zip_code: 0000,
                          );
                          print(authController.currentUser.value.id);
                          controller.saveProviderForm(_profileForm, tempProvider);
                          // controller.loading=false;
                          // controller.update();
                        } else {
                          controller.edit(context);
                          controller.update();
                          controller.loading=false;
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
              ).paddingSymmetric(vertical: 10, horizontal: 20):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            }
          ),
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
              getImageHeaderWidget(authController,context),
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
                onSaved: (input) =>
                    controller.serviceProvider.value.phone = int.parse(input),
                validator: (input) =>
                    !input.startsWith('+') && !input.startsWith('00')
                        ? "Phone number must start with country code!".tr
                        : null,
                initialValue: controller.serviceProvider.value.phone.toString(),
                hintText: "+216 56 689 659",
                labelText: "Phone number".tr,
                iconData: Icons.phone_android_outlined,
              ),

              GetBuilder<ProfileController>(builder: (profileController) {
                return MapSelect(context, profileController, addresscontrol);
              }),
              // TextFieldWidget(
              //   control: countrycontrol,
              //   onSaved: (input) => controller
              //       .serviceProvider.value.branches.first.country = input,
              //   validator: (input) => input.length < 3
              //       ? "Should be more than 3 letters".tr
              //       : null,
              //   initialValue:
              //       controller.serviceProvider.value.branches.first.country,
              //   hintText: "Tunisia".tr,
              //   labelText: "Country".tr,
              //   iconData: Icons.map_outlined,
              // ),
              // TextFieldWidget(
              //   control: statecontrol,
              //   onSaved: (input) => controller
              //       .serviceProvider.value.branches.first.state = input,
              //   validator: (input) => input.length < 3
              //       ? "Should be more than 3 letters".tr
              //       : null,
              //   initialValue:
              //       controller.serviceProvider.value.branches.first.state,
              //   hintText: "Tunis".tr,
              //   labelText: "State".tr,
              //   iconData: Icons.map_outlined,
              // ),
              // TextFieldWidget(
              //   control: citycontrol,
              //   onSaved: (input) => controller
              //       .serviceProvider.value.branches.first.city = input,
              //   validator: (input) => input.length < 3
              //       ? "Should be more than 3 letters".tr
              //       : null,
              //   initialValue:
              //       controller.serviceProvider.value.branches.first.city,
              //   hintText: "Centre Urbain Nord".tr,
              //   labelText: "City".tr,
              //   iconData: Icons.map_outlined,
              // ),
              // TextFieldWidget(
              //   control: addresscontrol,
              //   onSaved: (input) => controller
              //       .serviceProvider.value.branches.first.address = input,
              //   validator: (input) => input.length < 3
              //       ? "Should be more than 3 letters".tr
              //       : null,
              //   initialValue:
              //       controller.serviceProvider.value.branches.first.address,
              //   hintText: "123 Street, City 136, State, Country".tr,
              //   labelText: "Address".tr,
              //   iconData: Icons.map_outlined,
              // ),
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

              if (Get.find<ProfileController>().serviceProvider.value.name !=
                      '' &&
                  Get.find<ProfileController>().serviceProvider != null)
                Text("Categories".tr, style: Get.textTheme.headline5)
                    .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              // for(var check in checks)
              // check,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              if (Get.find<ProfileController>().serviceProvider.value.name !=
                      '' &&
                  Get.find<ProfileController>().serviceProvider != null)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: eServicesController.categories.length,
                    itemBuilder: ((context, index) {
                      if (eServicesController.chosencats[index])
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
                                  color:
                                      Get.theme.focusColor.withOpacity(0.05))),
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(eServicesController.categories[index].name),
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
                                      controller.update();
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
                      else {
                        return SizedBox();
                      }
                    })),

              Text("Social Media".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              // Text("Fill your old password and type new password and confirm it".tr, style: Get.textTheme.caption).paddingSymmetric(horizontal: 22, vertical: 5),
              Obx(() {
                return TextFieldWidget(
                  control: linkcontrol,
                  onSaved: (input) => controller
                      .serviceProvider.value.social_media['LinkedIn'] = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue:
                      controller.serviceProvider.value.social_media['LinkedIn'],
                  hintText: "".tr,
                  labelText: "LinkedIn".tr,
                  iconData: Icons.map_outlined,
                );
              }),
              Obx(() {
                return TextFieldWidget(
                  control: fbcontrol,
                  onSaved: (input) => controller
                      .serviceProvider.value.social_media['Facebook'] = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue:
                      controller.serviceProvider.value.social_media['Facebook'],
                  hintText: "".tr,
                  labelText: "Facebook".tr,
                  iconData: Icons.map_outlined,
                );
              }),
              Obx(() {
                return TextFieldWidget(
                  control: instcontrol,
                  onSaved: (input) => controller
                      .serviceProvider.value.social_media['Instagram'] = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue: controller
                      .serviceProvider.value.social_media['Instagram'],
                  hintText: "".tr,
                  labelText: "Instagram".tr,
                  iconData: Icons.map_outlined,
                );
              }),
              if (Get.find<ProfileController>().serviceProvider.value.name !=
                      '' &&
                  Get.find<ProfileController>().serviceProvider != null)
                addImageHeaderWidget(authController),
              if (Get.find<ProfileController>().serviceProvider.value.name !=
                      '' &&
                  Get.find<ProfileController>().serviceProvider != null)
                FloatingActionButton(
                    onPressed: () async {
                      authController.addImage();
                      authController.update();
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
                    child: Icon(Icons.add_a_photo))
            ],
          ),
        ));
  }

  Widget getImageHeaderWidget(AuthController control, context) {
    return GetBuilder<AuthController>(
        init: AuthController(), // intialize with the Controller
        builder: (value) => Container(
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
                    constraints: BoxConstraints(maxHeight: 250),
                    child:
                        // control.im
                        (profileController
                                        .serviceProvider.value.profile_photo !=
                                    null &&
                                profileController
                                        .serviceProvider.value.profile_photo !=
                                    '')
                            ? Image.network(profileController
                                .serviceProvider.value.profile_photo)
                            : control.im),
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
                       showModalBottomSheet(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height*0.2
                        ),
                        context: context, builder: (context){
                          return Column(
                          children: [
                            ListTile(
                              onTap: (){
                                control.changeImage();
                      
                      Future.delayed(Duration(seconds: 5),(){
                      //   if(control.file!=null&&control.file.path!=''){
                      //   print('got image');
                      //   // scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.easeIn);
                      // }
                      });
                      controller.update();
                      Navigator.pop(context);
                              },
                              leading: Icon(Icons.photo),
                              title: Text("From Gallery"),

                            ),
                            ListTile(
                              onTap: (){
                                control.changeCameraImage();
                      
                      Future.delayed(Duration(seconds: 5),(){
                      //   if(control.file!=null&&control.file.path!=''){
                      //   print('got image');
                      //   // scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.easeIn);
                      // }
                      });
                      controller.update();
                      Navigator.pop(context);
                              },
                              leading: Icon(Icons.camera_alt),
                              title: Text("From Camera"),

                            ),
                          ],
                        );
                        });
                      // control.changeImage();
                      // control.update();
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
                    child: Icon(Icons.add_a_photo))
              ]),
            ));
  }

  Widget addImageHeaderWidget(AuthController control) {
    control.iml.forEach(((element) {
      control.boolimg.add(true);
    }));

    return GetBuilder<AuthController>(
        init: AuthController(), // intialize with the Controller
        builder: (value) => Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            width: 500,
            height: 300,
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: control.iml.length,
                itemBuilder: (context, index) {
                  var _media = control.iml.elementAt(index);
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                Dialog(
                                    insetPadding: EdgeInsets.all(0),
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      color:
                                          Colors.transparent.withOpacity(0.3),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      child: _media,
                                    )),
                              ],
                            );
                          });
                      //Get.toNamed(Routes.CATEGORY, arguments: _category);
                      //Get.toNamed(Routes.CATEGORY, arguments: _category);
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsetsDirectional.only(
                          end: 20,
                          start: index == 0 ? 20 : 0,
                          top: 10,
                          bottom: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: _media),
                          ),

                          Positioned(
                            top: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 88.0),
                              child: Container(
                                height: 25,
                                width: 25,
                                child: FloatingActionButton.small(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              child: Dialog(
                                                child: Column(children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.025,
                                                  ),
                                                  Text(
                                                      "do you want to delete this image?",
                                                      style: Get
                                                          .textTheme.headline6),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.75,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        child: _media),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Row(
                                                      children: [
                                                        MaterialButton(
                                                          elevation: 0,
                                                          onPressed: () {
                                                            if (!control
                                                                    .boolimg[
                                                                index]) {
                                                              print(control
                                                                  .boolimg
                                                                  .length);
                                                              value.iml
                                                                  .removeAt(
                                                                      index);
                                                              value.boolimg
                                                                  .removeAt(
                                                                      index);
                                                              print(control
                                                                  .boolimg
                                                                  .length);
                                                              value.update();
                                                              Navigator.pop(
                                                                  context);
                                                              value.update();
                                                            } else {
                                                              control.deleteImage(
                                                                  profileController
                                                                      .serviceProvider
                                                                      .value
                                                                      .media[index]);
                                                              value.iml
                                                                  .removeAt(
                                                                      index);
                                                              value.boolimg
                                                                  .removeAt(
                                                                      index);

                                                              control.update();
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          color: Get.theme
                                                              .accentColor,
                                                          height: 40,
                                                          child: Wrap(
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .center,
                                                            spacing: 9,
                                                            children: [
                                                              Icon(Icons.delete,
                                                                  color: Get
                                                                      .theme
                                                                      .primaryColor,
                                                                  size: 24),
                                                              Text(
                                                                "delete".tr,
                                                                style: Get
                                                                    .textTheme
                                                                    .subtitle1
                                                                    .merge(TextStyle(
                                                                        color: Get
                                                                            .theme
                                                                            .primaryColor)),
                                                              ),
                                                            ],
                                                          ),
                                                          shape:
                                                              StadiumBorder(),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.025,
                                                        ),
                                                        MaterialButton(
                                                          elevation: 0,
                                                          color: Get
                                                              .theme.focusColor
                                                              .withOpacity(0.2),
                                                          height: 40,
                                                          onPressed: () {
                                                            navigator.pop();
                                                          },
                                                          child: Wrap(
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .center,
                                                            spacing: 9,
                                                            children: [
                                                              Icon(Icons.cancel,
                                                                  color: Get
                                                                      .theme
                                                                      .hintColor,
                                                                  size: 24),
                                                              Text(
                                                                "Cancel".tr,
                                                                style: Get
                                                                    .textTheme
                                                                    .subtitle1
                                                                    .merge(TextStyle(
                                                                        color: Get
                                                                            .theme
                                                                            .hintColor)),
                                                              ),
                                                            ],
                                                          ),
                                                          shape:
                                                              StadiumBorder(),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            );
                                          });
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
                                    child: Icon(Icons.remove)),
                              ),
                            ),
                          )
                          // Padding(
                          //   padding:
                          //       const EdgeInsetsDirectional.only(start: 12, top: 8),
                          //   child: Text(
                          //     _media.name ?? '',
                          //     maxLines: 2,
                          //     style: Get.textTheme.bodyText2
                          //         .merge(TextStyle(color: Get.theme.primaryColor)),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                })
            // child: Column(children: [
            //   Column(
            //     children: [
            //       for (var img in control.iml) img,
            //     ],
            //   ),
            //   //
            //   //         Container(
            //   //         height: 150,
            //   //         child: Image(
            //   //   image: NetworkImage(store.image,

            //   //   ),
            //   // ),
            //   //       ),
            //   SizedBox(height: 20),
            //   FloatingActionButton(
            //       onPressed: () async {
            //         control.addImage();
            //         control.update();
            //         // storeimage.printInfo();
            //         //     final ImagePicker _picker = ImagePicker();

            //         //     final XFile image = await _picker.pickImage(source: ImageSource.gallery);
            //         //     File im=File(image.path);
            //         //     storeimage=Image.file(im);
            //         //       storeimage=Container(
            //         //         height: 150,
            //         //         child: Image(
            //         //   image: FileImage(im,

            //         //   ),
            //         // ),
            //         //       );
            //         //    print(storeimage);
            //         //   storecontrol.update();
            //       },
            //       child: Icon(Icons.camera))
            // ]),
            ));
  }
}
