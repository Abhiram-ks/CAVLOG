import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/buttomnav/buttom_nav_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/pages/chat/chat_screen.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/pages/home/home_screen.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/pages/profile/profile_screen.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/pages/revenue/revenue_screen.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/pages/service/service_screen.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationControllers extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    RevenueScreen(),
    ServiceScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  
   BottomNavigationControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
       data: Theme.of(context).copyWith(
        splashColor: AppPalette.whiteClr.withAlpha((0.3 * 255).round()),
         highlightColor: AppPalette.buttonClr.withAlpha((0.2 * 255).round()), 
      ),
      child: Scaffold(
       body: BlocBuilder<ButtomNavCubit, BottomNavItem>(
        builder: (context, state) {
          switch (state){
           case BottomNavItem.home:
            return _screens[0];
           case BottomNavItem.revenue:
            return _screens[1];
           case BottomNavItem.service:
            return _screens[2];
           case BottomNavItem.chat:
            return _screens[3];
           case BottomNavItem.profile:
            return _screens[4];
          }
        }),
        bottomNavigationBar: BlocBuilder<ButtomNavCubit,BottomNavItem>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: BottomNavigationBar(
                enableFeedback: true,
                useLegacyColorScheme: true,
                elevation: 0,
                iconSize: 26,
                selectedItemColor: AppPalette.buttonClr,
                backgroundColor: AppPalette.whiteClr,
                landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                unselectedLabelStyle: TextStyle(color: AppPalette.hintClr),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type:BottomNavigationBarType.fixed, 
                currentIndex: BottomNavItem.values.indexOf(state),
                onTap: (index) {
                  context.read<ButtomNavCubit>().selectItem(BottomNavItem.values[index]);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                    activeIcon: Icon(Icons.home)
                  ),
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.account_balance_wallet_outlined),
                    label: 'Revenue',
                    activeIcon: Icon(Icons.account_balance_wallet,),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_box_outlined),
                    label: 'Service',
                    activeIcon: Icon(Icons.add_box)
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_outlined),
                    label: 'Chats',
                    activeIcon: Icon(Icons.chat)
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded),
                    label: 'Account',
                    activeIcon: Icon(Icons.person)
                  ),
                ],
              ),
            );
          },),
      ),
    );
  }
}

