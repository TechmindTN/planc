import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_services_provider/app/models/MaterialMod.dart';

import '../../../../common/ui.dart';
// import 'booking_options_popup_menu_widget.dart';

class Matview extends StatelessWidget {
  Matview({
    Key key,
    @required MaterialMod mat,
  })  : _mat = mat,
        super(key: key);

  final MaterialMod _mat;
  GetStorage box;
  @override
  Widget build(BuildContext context) {
    box = GetStorage();
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column(
            //   children: [
            //     Hero(
            //       tag: _mat.id,
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(10),
            //             topRight: Radius.circular(10)),
            //         child: CachedNetworkImage(
            //           height: 80,
            //           width: 80,
            //           fit: BoxFit.cover,
            //           // imageUrl: _booking.client.profile_photo,
            //           placeholder: (context, url) => Image.asset(
            //             'assets/img/loading.gif',
            //             fit: BoxFit.cover,
            //             width: double.infinity,
            //             height: 80,
            //           ),
            //           errorWidget: (context, url, error) =>
            //               Icon(Icons.error_outline),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(width: 12),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _mat.name,
                          style: Get.textTheme.bodyText2,
                          maxLines: 3,
                          // textAlign: TextAlign.end,
                        ),
                      ),
                      // BookingOptionsPopupMenuWidget(booking: _booking),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    children: [
                      Text("supplier :"),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _mat.supplier,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("quantity :"),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _mat.count.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Icon(
                      //   // Icons.ob,
                      //   size: 18,
                      //   color: Get.theme.focusColor,
                      // ),
                      Text("price :"),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _mat.price.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  // Divider(height: 8, thickness: 1),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Text(
                  //         "Total".tr,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.fade,
                  //         softWrap: false,
                  //         style: Get.textTheme.bodyText1,
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Align(
                  //           alignment: AlignmentDirectional.centerEnd,
                  //           child:
                  //               Text("40 dt", style: Get.textTheme.headline6)),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
