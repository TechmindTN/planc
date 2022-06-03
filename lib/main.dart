import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/auth/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';
import 'app/services/global_service.dart';
import 'app/services/settings_service.dart';
import 'app/services/translation_service.dart';

void initServices() async {
  Get.log('starting services ...');
  Firebase.initializeApp();
  await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingsService().init());
  await GetStorage.init();
  
  Get.log('All services started...');
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }
var ini=AppPages.INITIAL;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log('mar7be mar7be');
  var connectivityResult = await (Connectivity().checkConnectivity());
    

if (connectivityResult == ConnectivityResult.mobile) {
  // I am connected to a mobile network.
  await initServices();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  var useremail = prefs.get('email');
  if (useremail != null) {
    var userpass = prefs.get('pass');
    // if(await Get.find<AuthController>().verifylogin(useremail, userpass)){
    //   if (Get.find<AuthController>().currentProfile==null){
    //     ini=Routes.REGISTER2;
        
    //   }}
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
} else 
if (connectivityResult == ConnectivityResult.wifi) {
  await initServices();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  var useremail = prefs.get('email');
  if (useremail != null) {
    var userpass = prefs.get('pass');
    // if(await Get.find<AuthController>().verifylogin(useremail, userpass)){
    //   if (Get.find<AuthController>().currentProfile==null){
    //     ini=Routes.REGISTER2;
        
    //   }
    // }
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // I am connected to a wifi network.
}
else{
  ini=Routes.NETWORKERROR;
   await Get.putAsync(() => GlobalService().init());
     await Get.putAsync(()=>TranslationService().init());
  // await Get.putAsync(() => AuthService().init());


  await Get.putAsync(() => SettingsService().init());

  // if (await Geolocator.isLocationServiceEnabled() == false) {
  //   Geolocator.openLocationSettings();
  // }
}


// if (connectivityResult == ConnectivityResult.mobile) {
//   // I am connected to a mobile network.
//   await initServices();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//   var useremail = prefs.get('email');
//   if (useremail != null) {
//     var userpass = prefs.get('pass');
//     // Get.find<AuthController>().verifylogin(useremail, userpass);
//   }

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// } else if (connectivityResult == ConnectivityResult.wifi) {
//   await initServices();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//   var useremail = prefs.get('email');
//   if (useremail != null) {
//     var userpass = prefs.get('pass');
//     // Get.find<AuthController>().verifylogin(useremail, userpass);
//   }

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   // I am connected to a wifi network.
// }
// else{
//   ini=Routes.NETWORKERROR;
//    await Get.putAsync(() => GlobalService().init());
//      await Get.putAsync(()=>TranslationService().init());
//   // await Get.putAsync(() => AuthService().init());


//   await Get.putAsync(() => SettingsService().init());

//   // if (await Geolocator.isLocationServiceEnabled() == false) {
//   //   Geolocator.openLocationSettings();
//   // }
// }
  // await initServices();
  // // AuthController authController = AuthController();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var useremail = prefs.get('email');
  // if (useremail != null) {
  //   var userpass = prefs.get('password');
  //   Get.find<AuthController>().login(useremail, userpass, context);
  // }

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  runApp(
    Phoenix(
      child: GetMaterialApp(
        title: Get.find<SettingsService>().setting.value.appName,
        initialRoute:ini,
            // authController.currentUser != null ? AppPages.root :
            // AppPages.INITIAL,
        getPages: AppPages.routes,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: Get.find<TranslationService>().supportedLocales(),
        translationsKeys: Get.find<TranslationService>().translations,
        locale: Get.find<SettingsService>().getLocale(),
        fallbackLocale: Get.find<TranslationService>().fallbackLocale,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        themeMode: Get.find<SettingsService>().getThemeMode(),
        theme: Get.find<SettingsService>().getLightTheme(),
        //Get.find<SettingsService>().getLightTheme.value,
        darkTheme: Get.find<SettingsService>().getDarkTheme(),
      ),
    ),
  );
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
