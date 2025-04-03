import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/admin_widget/admin_requst_widet.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/media_quary/media_quary_helper.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MeidaQuaryHelper.height(context);
    double screenWidth = MeidaQuaryHelper.width(context);

    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (route) => false);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: AppPalette.whiteClr,
              iconTheme: IconThemeData(color: AppPalette.blackClr),
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  }),
            ),
             body: SafeArea(
               child: Padding(
               padding: EdgeInsets.symmetric( horizontal: screenWidth * 0.08),
               child: ListView(
                children: [
                  AdminRequestWidget(screenWidth: screenWidth, screenHight: screenHight)
                ],
               ),
              )
            )
          )
        );
  }
}
