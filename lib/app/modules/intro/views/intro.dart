import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/routes/app_pages.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          title: "WELCOME TO PLANC",
          description: "this is the Provider where you can manage your store",
          pathImage: "assets/icon/planclogo1.png",
          colorBegin: Color.fromARGB(255, 189, 44, 218),
          colorEnd: Color.fromARGB(255, 128, 0, 167),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "HOME PAGE",
          description: "You can find your services in this page",
          pathImage: "assets/img/home.png",
          colorBegin: Color.fromARGB(255, 189, 44, 218),
          colorEnd: Color.fromARGB(255, 128, 0, 167),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "NOTIFICATIONS",
          description:
              "You receveive a notification for every action done in the application ",
          pathImage: "assets/img/notifications.png",
          colorBegin: Color.fromARGB(255, 189, 44, 218),
          colorEnd: Color.fromARGB(255, 128, 0, 167),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "CATALOG",
          description:
              "At the end of the profil page, you can add a catalog of photos that can be visible to the clients",
          pathImage: "assets/img/catalog.png",
          colorBegin: Color.fromARGB(255, 189, 44, 218),
          colorEnd: Color.fromARGB(255, 128, 0, 167),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "PLANC",
          description: "Click 'Done' to create your profile",
          pathImage: "assets/icon/planclogo1.png",
          colorBegin: Color.fromARGB(255, 189, 44, 218),
          colorEnd: Color.fromARGB(255, 128, 0, 167),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
  }

  void onDonePress() {
    // Do what you want
    Get.offAllNamed(Routes.CATEGORY);
    print("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
