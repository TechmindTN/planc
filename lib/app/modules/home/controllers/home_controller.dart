import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/Network/InterventionNetwork.dart';
import 'package:home_services_provider/app/modules/profile/controllers/profile_controller.dart';
import 'package:home_services_provider/app/routes/app_pages.dart';

import '../../../../common/ui.dart';
import '../../../models/Intervention.dart';
import '../../../their_models/booking_model.dart';
import '../../../their_models/statistic.dart';
import '../../../repositories/booking_repository.dart';
import '../../../repositories/statistic_repository.dart';

class HomeController extends GetxController {
  StatisticRepository _statisticRepository;
  BookingsRepository _bookingsRepository;
  List<String> pages = [];
  final statistics = <Statistic>[].obs;
  final bookings = <Intervention>[].obs;
  final intervention = <Intervention>[].obs;
  final OngoingTasks = <Intervention>[].obs;
  final completedTasks = <Intervention>[].obs;
  final page = 1.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  var currentIndex = 1.obs;
  InterventionNetwork interventionNetwork = InterventionNetwork();
  ScrollController scrollController = ScrollController();

  HomeController() {
    _statisticRepository = new StatisticRepository();
    _bookingsRepository = new BookingsRepository();
  }
  @override
  Future<void> onInit() async {
    bookings.clear();
    // Get.find<ProfileController>().serviceProvider = null;
    getIntervention();
    print("bookings length 2222..............................");
    print(bookings.length);
    await refreshHome();
    update();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        loadMoreBookingsOfCategory(index: currentIndex.value);
      }
    });
    update();

    super.onInit();
  }

  Future refreshHome({bool showMessage = false}) async {
    await getStatistics();
    // await getBookings(index: 1);
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  void changeTab(int index) async {
    currentIndex.value = index;
    page.value = 1;
    isDone.value = false;
    await getBookings(index: index);
    Get.toNamed(Routes.ROOT, id: 1);
  }

  Future getStatistics() async {
    try {
      statistics.value = await _statisticRepository.getHomeStatistics();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getIntervention() async {
    try {
      intervention.value = await interventionNetwork.getInterventionsList(
          Get.find<ProfileController>().serviceProvider.value.id);
      // print("bookings length 2222..............................");
      // print(bookings.length);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future getBookings({int index}) async {
    try {
      // bookings.value = [];
      switch (index) {
        case 1:
          bookings.clear();
          // intervention.value = await interventionNetwork.getInterventionsList(
          //     Get.find<ProfileController>().serviceProvider.value.id);
          intervention.forEach((element) {
            if (element.states == "en attente") bookings.add(element);
          });
          // print("booking length..............................");

          // print(bookings.length);
          // Future.delayed(Duration(seconds: 10), () {
          //   print("booking length 2222..............................");
          //   print(bookings.length);
          //   print("intervention length 2222..............................");
          //   print(bookings.length);
          // });
          update();
          break;
        case 2:
          bookings.clear();
          intervention.forEach((element) {
            if (element.states == "en cours") bookings.add(element);
          });
          update();
          break;
        case 3:
          bookings.clear();
          // intervention.value = await interventionNetwork.getInterventionsList(
          //     Get.find<ProfileController>().serviceProvider.value.id);
          intervention.forEach((element) {
            if (element.states == "termine") bookings.add(element);
          });
          update();
          break;
        default:
          bookings.clear();
          // intervention.value = await interventionNetwork.getInterventionsList(
          //     Get.find<ProfileController>().serviceProvider.value.id);
          intervention.forEach((element) {
            if (element.states == "en attente") bookings.add(element);
          });
          update();
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
          List<Intervention> _bookings = await getPendingTasks();
          if (bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
        case 2:
          this.page.value++;
          var _bookings = await getOngoingTasks();
          if (_bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
        case 3:
          this.page.value++;
          var _bookings = await getCompletedTasks();
          if (_bookings.isNotEmpty) {
            this.bookings.value += _bookings;
          } else {
            this.isDone.value = true;
          }
          break;
        default:
          this.page.value++;
          var _bookings = await getPendingTasks();
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

  Future getPendingTasks({bool showMessage = false, id}) async {
    currentIndex.value = id;
    // QuerySnapshot snaps = await _interventionNetwork.InterventionsRef.get();
    // Intervention i;
    // snaps.docs.forEach((element) async {
    //   print(element.data()['provider']);
    //   ServiceProvider s = await getProviderbyRef(element.data()['provider']);
    //   Category c = await getCategorybyRef(element.data()['category']);
    //   Client cl = await getClientbyRef(element.data()['client']);
    //   i = Intervention.fromFire(element.data());
    //   i.client = cl;
    //   i.category = c;
    //   i.provider = s;
    //   i.printIntervention();
    // _interventionNetwork
    //   bookings.value.add(i);
    // });
    bookings.clear();
    intervention.forEach((element) {
      if (element.states == "pending") bookings.add(element);
    });
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedOngoingTask.value = ongoingTasks.isNotEmpty ? ongoingTasks.first : new Task();
  }

  getOngoingTasks({bool showMessage = false}) {
    bookings.clear();
    intervention.forEach((element) {
      if (element.states == "ongoing") bookings.add(element);
    });
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedCompletedTask.value = completedTasks.isNotEmpty ? completedTasks.first : new Task();
  }

  Future<dynamic> getCompletedTasks({bool showMessage = false}) async {
    bookings.clear();
    intervention.forEach((element) {
      if (element.states == "completed") bookings.add(element);
    });
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedArchivedTask.value = archivedTasks.isNotEmpty ? archivedTasks.first : new Task();
  }

  updateFireintervention(String id) async {
    await interventionNetwork.updateIntervention(id);
  }
}
