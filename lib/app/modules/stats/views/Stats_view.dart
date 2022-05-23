import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/home/controllers/home_controller.dart';
import 'package:home_services_provider/app/modules/home/widgets/statistic_carousel_item_widget.dart';

import '../../../../common/ui.dart';
import '../../../global_widgets/notifications_button_widget.dart';
import '../../../global_widgets/tab_bar_widget.dart';
import '../../../services/auth_service.dart' show AuthService;
import '../../../their_models/statistic.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../e_services/controllers/e_services_controller.dart';
import '../../home/widgets/bookings_list_widget.dart';
import '../../home/widgets/statistics_carousel_widget.dart';

class StatsView extends StatefulWidget {
  StatsView({Key key}) : super(key: key);
  AuthController authController = Get.find<AuthController>();

  EServicesController eServicesController = Get.find<EServicesController>();
  @override
  StatsViewState createState() => new StatsViewState();
}

class StatsViewState extends State<StatsView> {
  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>().getStatistics();
    var controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stats".tr,
          style: Get.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => {Navigator.pop(context)}),
        actions: [NotificationsButtonWidget()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshNotifications(showMessage: true);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StatisticList(context),
        ),
      ),
      // RefreshIndicator(
      //     onRefresh: () async {
      //       controller.refreshHome(showMessage: true);
      //     },
      //     child: CustomScrollView(
      //         // controller: controller.scrollController,
      //         shrinkWrap: false,
      //         slivers: <Widget>[
      //           SliverAppBar(
      //             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //             expandedHeight: 290,
      //             elevation: 0.5,
      //             // pinned: true,
      //             floating: false,
      //             iconTheme: IconThemeData(color: Get.theme.primaryColor),
      //             title: Text(
      //               "Stats",
      //               // Get.find<SettingsService>().setting.value.appName,
      //               style: Get.textTheme.headline6,
      //             ),
      //             centerTitle: true,
      //             automaticallyImplyLeading: false,
      //             leading: new IconButton(
      //               icon: new Icon(Icons.arrow_back, color: Colors.black87),
      //               onPressed: () => {Navigator.pop(context)},
      //             ),
      //             actions: [NotificationsButtonWidget()],
      //             // flexibleSpace: FlexibleSpaceBar(
      //             //     collapseMode: CollapseMode.parallax,
      //             //     background: StatisticsCarouselWidget(
      //             //       statisticsList: Get.find<HomeController>().statistics,
      //             //     ).paddingOnly(top: 70, bottom: 0)),
      //           ),

      //         ]))
    );
  }

  Widget StatisticList(context) {
    return Obx(() {
      var _Statistic = Get.find<HomeController>().statistics;
      print('stats length ' + _Statistic.length.toString());
      return GridView.builder(
        itemCount: _Statistic.length,
        itemBuilder: (context, index) {
          return StatisticCarouselItemWidget(
            marginLeft: 10,
            statistic: _Statistic.elementAt(index),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      );

      // return ListView.separated(
      //     itemCount: _Statistic.length,
      //     separatorBuilder: (context, index) {
      //       return SizedBox(height: 7);
      //     },
      //     shrinkWrap: true,
      //     primary: false,
      //     itemBuilder: (context, index) {
      //       // Message _message = _messages.elementAt(index);
      //       // printInfo(info: _message.toMap().toString());
      //       return StatisticsCarouselWidget(
      //         statisticsList: _Statistic,
      //       );
      //     });
    });
  }
}
