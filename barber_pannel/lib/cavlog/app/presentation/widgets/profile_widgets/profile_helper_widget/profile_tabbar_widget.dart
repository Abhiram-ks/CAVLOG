import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/media_quary/constant/constant.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  TabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppPalette.blackClr,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


 SizedBox profileviewWidget(double screenWidth, BuildContext context,
      IconData icons, String heading, Color iconclr, {Color? textColor}) {
    return SizedBox(
      width: screenWidth * 0.55,
      child: Row(children: [
        Icon(
          icons,
          color: iconclr,
        ),
        ConstantWidgets.width20(context),
        Expanded(
          child: Text(
            heading,
            style: TextStyle(
              color: textColor ?? AppPalette.whiteClr,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]),
    );
  }