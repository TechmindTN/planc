import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_services_provider/app/models/Intervention.dart';

import '../../../../common/map.dart';
import '../../../../common/ui.dart';
import '../../../their_models/booking_model.dart';
import '../../../repositories/booking_repository.dart';

class BookingController extends GetxController {
  BookingsRepository _bookingRepository;
  final allMarkers = <Marker>[].obs;
  List<File> filel = [];
  List<Image> iml = [];
  GoogleMapController mapController;
  final booking = Intervention().obs;

  BookingController() {
    _bookingRepository = BookingsRepository();
  }

  @override
  void onInit() async {
    booking.value = Get.arguments as Intervention;
    super.onInit();
  }

  @override
  void onReady() async {
    // await refreshBooking();
    super.onReady();
  }

  Future refreshBooking({bool showMessage = false}) async {
    // initBookingAddress();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "Booking page refreshed successfully".tr));
    }
  }

  // Future<void> getBooking() async {
  //   try {
  //     booking.value = await _bookingRepository.getBooking(booking.value.id);
  //   } catch (e) {
  //     Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
  //   }
  // }

  // void initBookingAddress() {
  //   mapController.moveCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(target: booking.value.address.getLatLng(), zoom: 12.4746),
  //     ),
  //   );
  //   MapsUtil.getMarker(address: booking.value.address, id: booking.value.id, description: booking.value.user?.name ?? '').then((marker) {
  //     allMarkers.add(marker);
  //   });
  // }
}
