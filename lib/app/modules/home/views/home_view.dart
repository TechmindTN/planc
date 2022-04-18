import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_service_controller.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_services_controller.dart';

import '../../../global_widgets/notifications_button_widget.dart';
import '../../../global_widgets/tab_bar_widget.dart';
import '../../../services/settings_service.dart';
import '../controllers/home_controller.dart';
import '../widgets/bookings_list_widget.dart';
import '../widgets/statistics_carousel_widget.dart';

class HomeView extends GetView<HomeController> {
  AuthController authController = Get.find<AuthController>();
  EServicesController eServicesController = Get.find<EServicesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            print(authController.currentUser.value.email);
            print(eServicesController.categories.first.name);

            controller.refreshHome(showMessage: true);
          },
          child: CustomScrollView(
            controller: controller.scrollController,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 290,
                elevation: 0.5,
                // pinned: true,
                floating: false,
                iconTheme: IconThemeData(color: Get.theme.primaryColor),
                title: Text(
                  "Plan C",
                  // Get.find<SettingsService>().setting.value.appName,
                  style: Get.textTheme.headline6,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.sort, color: Colors.black87),
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                ),
                actions: [NotificationsButtonWidget()],
                bottom: TabBarWidget(
                  tabs: [
                    ChipWidget(
                      text: "On Going".tr,
                      id: 0,
                      onSelected: (id) {
                        controller.changeTab(id);
                      },
                    ),
                    ChipWidget(
                      text: "waiting".tr,
                      id: 1,
                      onSelected: (id) {
                        controller.changeTab(id);
                      },
                    ),
                    ChipWidget(
                      text: "Completed".tr,
                      id: 2,
                      onSelected: (id) {
                        controller.changeTab(id);
                      },
                    )
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: StatisticsCarouselWidget(
                      statisticsList: controller.statistics,
                    ).paddingOnly(top: 70, bottom: 50)),
              ),
              GetBuilder<HomeController>(builder: (context) {
                return SliverToBoxAdapter(
                  child: Wrap(
                    children: [
                      BookingsListWidget(),
                    ],
                  ),
                );
              }),
            ],
          )),
    );
  }
}
