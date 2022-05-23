import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/bookings/controllers/booking_controller.dart';

import '../../../../common/ui.dart';
import '../../../Network/BillNetwork.dart';
import '../../../Network/InterventionNetwork.dart';
import '../../../models/Bill.dart';
import '../../../models/MaterialMod.dart';
import '../../../routes/app_pages.dart';

class BillController extends GetxController {
  Rx<Bill> bill = Bill().obs;
  BillNetwork billNetwork = BillNetwork();
  List<MaterialMod> mat = [];
  List<Map<String, dynamic>> billmat = [];
  List<Widget> matwid = [];
  InterventionNetwork interventionNetwork = InterventionNetwork();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> saveBill(GlobalKey<FormState> billForm,context) async {
    // mapdata['profile_photo'] = url;
    // serviceProvider.value.profile_photo = url;
    try {
      if (billForm.currentState.validate()) {
        print("hello1");
        // prepareCategories();
        print("hello2");

        // print("hello3");
        // // print(serviceProvider.value);
        // print("hello4");
        // // serviceProvider.value.profile_photo = url;
        // print("hello5");
        // serviceProvider.value.media = med;
        // print("hello6");
        // serviceProvider.value.categories = cat;
        // bill.value.materials = mat;
        if(billmat!=null&&billmat.isNotEmpty)bill.value.materials = billmat;
        DocumentReference dr = await billNetwork.addBill(bill.value);

        print("hello7");

        Future.delayed(Duration(seconds: 4), (() {
          print("docref id " + dr.id);
          bill.value.id = dr.id;
          interventionNetwork.updateBillIntervention(
              Get.find<BookingController>().booking.value.id, dr);
        }));



          int count = 0;
           Navigator.of(context).popUntil((_)=> count++>= 2);        
        // Get.offAndToNamed(
        //   Routes.ROOT,

        // );
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message:
                "There are errors in some fields please correct them!".tr));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Something was wrong".tr));
    }
  }

  Future<Bill> getBill(String id) {
    return billNetwork.getBillById(id);
  }


  calculateSum(serviceFee,workforceFee,studyFee,discount){
    double total=0;
    if(serviceFee!=null&&serviceFee!=''){
      total+=double.parse(serviceFee);
    }
    if(serviceFee!=null&&workforceFee!=''){
      total+=double.parse(workforceFee);
    }
    if(serviceFee!=null&&studyFee!=''){
      total+=double.parse(studyFee);
    }
    if(serviceFee!=null&&discount!=''){
      total-=double.parse(discount);
    }
    update();
    return total.toString();
  }
  calculateMat(price,quantity){
    double total=0;
    if(price!=null&&price!=''&&quantity!=null&&quantity!=''){
      total+=double.parse(price)*double.parse(quantity);
    }
    return total;
  }
}
