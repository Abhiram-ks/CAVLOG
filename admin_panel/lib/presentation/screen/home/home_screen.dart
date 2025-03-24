import 'package:admin/presentation/screen/dashbord/manage_barber_screen.dart';
import 'package:admin/presentation/screen/dashbord/service_screen.dart';
import 'package:flutter/material.dart';
import '../../widget/home_widget/custom_tabbar.dart';
import '../dashbord/banner_management_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: TabBarCustom(screenWidth: screenWidth),
            body: SafeArea(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  ManageBarberScreen(screenHeight: screenHeight,screenWidth: screenWidth,),
                  ServiceScreen(screenHeight: screenHeight,screenWidth: screenWidth,),
                  BannerManagement(screenHeight: screenHeight,screenWidth: screenWidth,)
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
