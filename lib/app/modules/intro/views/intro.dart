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
          description:
              "this is the provider application where you can manage your store",
          pathImage: "assets/img/planCFull.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "HOME PAGE",
          description: "you can find your services in this page",
          pathImage: "assets/img/home.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "NOTIFICATIONS",
          description:
              "you will receive notification for any action related to your services",
          pathImage: "assets/img/notifications.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "CATALOGUE",
          description:
              "in the bottum of the profile page, you can add images for your account, these images will be visible for the users",
          pathImage: "assets/img/catalog.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "PLANC",
          description: "click done to create your profile",
          pathImage: "assets/img/planCFull.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
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
