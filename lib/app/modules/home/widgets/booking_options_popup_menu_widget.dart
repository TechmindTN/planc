import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Intervention.dart';
import '../../../their_models/booking_model.dart';
import '../../../routes/app_pages.dart';
import '../../bill/controllers/bill_controller.dart';

class BookingOptionsPopupMenuWidget extends StatelessWidget {
  const BookingOptionsPopupMenuWidget({
    Key key,
    @required Intervention booking,
  })  : _booking = booking,
        super(key: key);

  final Intervention _booking;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onSelected: (item) {
        switch (item) {
          case "Create a bill":
            {
              // TODO accept the booking

              Get.toNamed(Routes.BILL, arguments: _booking);
              Get.find<BillController>().billmat = [];
              Get.find<BillController>().mat = [];
              Get.find<BillController>().matwid = [];
              // Get.toNamed(Routes.BILL, arguments: _booking);
            }
            break;
          case "decline":
            {
              // TODO decline the booking
            }
            break;
          case "view":
            {
              Get.toNamed(Routes.BOOKING, arguments: _booking);
            }
            break;
        }
      },
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Icon(Icons.assignment_outlined, color: Get.theme.hintColor),
                Text(
                  "View Details".tr,
                  style: TextStyle(color: Get.theme.hintColor),
                ),
              ],
            ),
            value: "view",
          ),
        );
        list.add(PopupMenuDivider(
          height: 10,
        ));
        list.add(
          PopupMenuItem(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Icon(Icons.check_circle_outline, color: Get.theme.hintColor),
                Text(
                  "Create a bill".tr,
                  style: TextStyle(color: Get.theme.hintColor),
                ),
              ],
            ),
            value: "Create a bill",
          ),
        );
        list.add(
          PopupMenuItem(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                Text(
                  "Decline".tr,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
            value: "decline",
          ),
        );
        return list;
      },
      child: Icon(
        Icons.more_vert,
        color: Get.theme.hintColor,
      ),
    );
  }
}
