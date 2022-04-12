import 'package:get/get.dart';
import 'package:home_services_provider/app/Network/CategoryNetwork.dart';
import 'package:home_services_provider/app/models/Category.dart';

import '../../../../common/ui.dart';
import '../../../their_models/e_service_model.dart';
import '../../../their_models/review_model.dart';
import '../../../repositories/e_service_repository.dart';

class EServiceController extends GetxController {
  final eService = EService().obs;
  final reviews = <Review>[].obs;
  final currentSlide = 0.obs;
  EServiceRepository _eServiceRepository;

  EServiceController() {
    _eServiceRepository = new EServiceRepository();
  }

  @override
  void onInit() async {
    eService.value = Get.arguments as EService;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEService();
    super.onReady();
  }

  Future refreshEService({bool showMessage = false}) async {
    await getEService();
    await getReviews();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message:
              eService.value.title + " " + "page refreshed successfully".tr));
    }
  }

  Future getEService() async {
    try {
      eService.value = await _eServiceRepository.get(eService.value.id);
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getReviews() async {
    try {
      reviews.value = await _eServiceRepository.getReviews(eService.value.id);
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
