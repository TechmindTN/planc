import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

class Which extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vous Etes??"),
        centerTitle: true,
      ),
      body: InkWell(
        onTap: () {
          Get.toNamed(Routes.LOGIN,);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.orange[400],
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.445,
                child: Center(
                  child: Text("Entreprise",
                  style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
                    Container(
                color: Colors.orange[300],
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.445,
                child: Center(
                  child: Text("Professionnel de métier",
                  style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );

    // TODO: implement build
    throw UnimplementedError();
  }

}