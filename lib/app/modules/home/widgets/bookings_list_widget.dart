import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/circular_loading_widget.dart';
import '../controllers/home_controller.dart';
import 'bookings_list_item_widget.dart';
import '../../../models/Intervention.dart';

class BookingsListWidget extends GetView<HomeController> {
  List<Intervention> bookings = <Intervention>[].obs;
  BookingsListWidget({Key key, 
  // this.bookings
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
      Future<List<Intervention>> futureBookings;
      if(controller.currentIndex.value==0){
        futureBookings=controller.getPendingTasks();
        
      }
      else if(controller.currentIndex.value==1){
        futureBookings=controller.getOngoingTasks();
        
      }
      else{
        futureBookings=controller.getCompletedTasks();
        
      }
      // if (bookings.isEmpty) {
      //   return CircularLoadingWidget(height: 300);

      //   // return Center(child: Text("List Is Empty"));
      // } else {
        int nbr = 0;
        return GetBuilder<HomeController>(
          builder: (controller) {
            return FutureBuilder(
              future: futureBookings,
              builder: (context,snapshot) {
                
                if(snapshot.hasData){

                bookings=snapshot.data as List<Intervention>;
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: bookings.length + 1,
                  itemBuilder: ((_, index) {
                    if (index == bookings.length) {
                      return Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Center(
                            child: new Opacity(
                              opacity: controller.isLoading.value ? 1 : 0,
                              // child: new CircularProgressIndicator(),
                            ),
                          ),
                        );
                      });
                    } else {
                      nbr++;
                      var _booking = bookings.elementAt(index);

                      if (nbr % 2 == 0) {
                        return BookingsListItemWidget(booking: _booking);
                      } else {
                        return Column(
                          children: [
                            BookingsListItemWidget(booking: _booking),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset('assets/img/banner.png'),
                            )
                          ],
                        );
                      }
                      return BookingsListItemWidget(booking: _booking);
                    }
                  }),
                );}
                
                else{
                  return CircularLoadingWidget();
                }
              }
              
            );
          }
        );
      // }
    // });
  }
}
