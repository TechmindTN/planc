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
          title: "BIENVENUE SUR PLANC",
          description:
              "ceci est l’application Provider où vous pouvez gérer votre boutique",
          pathImage: "assets/img/planCFull.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "PAGE D'ACCUEIL",
          description: "vous pouvez trouver vos services dans cette page",
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
              "vous recevrez une notification pour toute action liée à vos services",
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
              "en bas de la page de profil, vous pouvez ajouter des images pour votre compte, ces images seront visibles pour les utilisateurs",
          pathImage: "assets/img/catalog.png",
          colorBegin: Color.fromARGB(255, 255, 0, 0),
          colorEnd: Color.fromARGB(255, 245, 74, 74),
          directionColorBegin: Alignment.topLeft,
          directionColorEnd: Alignment.bottomRight),
    );
    slides.add(
      new Slide(
          title: "PLANC",
          description: "cliquez sur 'Done' pour créer votre profil",
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
