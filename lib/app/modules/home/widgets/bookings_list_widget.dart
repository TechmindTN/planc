import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/circular_loading_widget.dart';
import '../controllers/home_controller.dart';
import 'bookings_list_item_widget.dart';

class BookingsListWidget extends GetView<HomeController> {
  BookingsListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.bookings.isEmpty) {
        return CircularLoadingWidget(height: 300);
      } else {
        int nbr=0;
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: controller.bookings.length + 1,
          itemBuilder: ((_, index) {
            if (index == controller.bookings.length) {
              return Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Center(
                    child: new Opacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                );
              });
            } else {
              nbr++;
              var _booking = controller.bookings.elementAt(index);
              if(nbr%2==0){
                return BookingsListItemWidget(booking: _booking);
              }
              else{
                return Column(
                  children: [
                    BookingsListItemWidget(booking: _booking),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/img/banner.jpg'),
                    )
                  ],
                );
              }
              return BookingsListItemWidget(booking: _booking);
            }
          }),
        );
      }
    });
  }
}
