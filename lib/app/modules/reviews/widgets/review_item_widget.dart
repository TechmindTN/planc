import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../their_models/review_model.dart';
import '../../../routes/app_pages.dart';

class ReviewItemWidget extends StatelessWidget {
  final Review review;

  ReviewItemWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.REVIEW, arguments: this.review);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Wrap(
          runSpacing: 20,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 65,
                    width: 65,
                    fit: BoxFit.cover,
                    imageUrl: review.user.mediaThumb,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 65,
                      width: 65,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        review.user.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                        style: Get.textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).hintColor)),
                      ),
                      Text(
                        review.user.bio,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: Chip(
                    padding: EdgeInsets.all(0),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(review.rate.toString(), style: Get.textTheme.bodyText1.merge(TextStyle(color: Get.theme.primaryColor))),
                        Icon(
                          Icons.star_border,
                          color: Get.theme.primaryColor,
                          size: 16,
                        ),
                      ],
                    ),
                    backgroundColor: Get.theme.accentColor.withOpacity(0.9),
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
            Text(
              review.review,
              style: Get.textTheme.caption,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 3,
            )
          ],
        ),
      ),
    );
  }
}
