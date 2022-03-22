import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../their_models/booking_model.dart';
import '../../../their_models/statistic.dart';
import '../../../repositories/booking_repository.dart';
import '../../../repositories/statistic_repository.dart';

class HomeController extends GetxController {
  StatisticRepository _statisticRepository;
  BookingsRepository _bookingsRepository;

  final statistics = <Statistic>[].obs;
  final bookings = <Booking>[].obs;
  final page = 1.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final currentIndex = 1.obs;

  ScrollController scrollController = ScrollController();

  HomeController() {
    _statisticRepository = new StatisticRepository();
    _bookingsRepository = new BookingsRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshHome();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        loadMoreBookingsOfCategory(index: currentIndex.value);
      }
    });
    super.onInit();
  }

  Future refreshHome({bool showMessage = false}) async {
    await getStatistics();
    await getBookings(index: 1);
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  void changeTab(int index) async {
    currentIndex.value = index;
    page.value = 1;
    isDone.value = false;
    await getBookings(index: index);
    //Get.toNamed(pages[index], id: 1);
  }

  Future getStatistics() async {
    try {
      statistics.value = await _statisticRepository.getHomeStatistics();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getBookings({int index}) async {
    try {
      bookings.value = [];
      switch (index) {
        case 1:
          bookings.value = await _bookingsRepository.getOngoingBookings(page: 1);
          break;
        case 2:
          bookings.value = await _bookingsRepository.getCompletedBookings(page: 1);
          break;
        case 3:
          bookings.value = await _bookingsRepository.getArchivedBookings(page: 1);
          break;
        default:
          bookings.value = await _bookingsRepository.getOngoingBookings(page: 1);
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future loadMoreBookingsOfCategory({int index}) async {
    try {
      isLoading.value = true;
      switch (index) {
        case 1:
          this.page.value++;
          var _bookings = await _bookingsRepository.getOngoingBookings(page: page.value);
          if (_bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
        case 2:
          this.page.value++;
          var _bookings = await _bookingsRepository.getOngoingBookings(page: page.value);
          if (_bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
        case 3:
          this.page.value++;
          var _bookings = await _bookingsRepository.getOngoingBookings(page: page.value);
          if (_bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
        default:
          this.page.value++;
          var _bookings = await _bookingsRepository.getOngoingBookings(page: page.value);
          if (_bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
      }
    } catch (e) {
      this.isDone.value = true;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }
}
