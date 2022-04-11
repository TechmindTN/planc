import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';

import '../their_models/role_enum.dart';

Widget RadioType(AuthController controller, chosen) {
  String dropdownValue = RoleEnum.Entreprise.name;

  String selected = 'cccccc';
  return Container(
    padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
    margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
    decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        // borderRadius: buildBorderRadius,
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5)),
        ],
        border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Type",
          style: Get.textTheme.bodyText1,
          textAlign: TextAlign.start,
        ),
        Obx(
          () => DropdownButton<String>(
            value: controller.selected.string,
            isExpanded: true,
            // icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              controller.updateRole(newValue);
              // dropdownValue = newValue;
              print(dropdownValue);
            },
            items: <String>[
              RoleEnum.Entreprise.name,
              RoleEnum.Professionel.name
            ].map<DropdownMenuItem<String>>((
              String value,
            ) {
              return DropdownMenuItem<String>(
                onTap: () {
                  controller.update();
                },
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    ),
  );
}
