import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../services/translation_service.dart';
import '../controllers/colors_controllers.dart';
// import '../controllers/color_controller.dart';

class ColorView extends GetView<ColorController> {
  final bool hideAppBar;

  ColorView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    List<String> colors=[
      '#f4841f',
      '#6f03fc',
      '#5cd3f7'
    ];

    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Colors".tr,
                  style: context.textTheme.headline6,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
              ),
        body: ListView(
          primary: true,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                children: List.generate(colors.length, (index) {
                  var _col = colors.elementAt(index);
                  return RadioListTile(
                    value: _col,
                    groupValue: "colors",
                  
activeColor: Colors.amber,         
           // groupValue: Get.locale.toString(),
                    onChanged: (value) {
                      _col=value;
                      print(_col);
                      // controller.updateLocale(value);
                    },
                    title: Container(width: 20,
                    height: 20,
                    color: Ui.parseColor(_col),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }
}
