import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/presentation/provider/cubit/buttom_nav_cubit/buttom_nav_cubit.dart';
import 'package:user_panel/app/presentation/screens/pages/chat/chat_screen.dart';
import 'package:user_panel/app/presentation/screens/pages/home/home_screen.dart';
import 'package:user_panel/app/presentation/screens/pages/post/post_screen.dart';
import 'package:user_panel/app/presentation/screens/pages/profile/profile_screen.dart';
import 'package:user_panel/app/presentation/screens/pages/search/search_screen.dart';
import 'package:user_panel/core/themes/colors.dart';

const double bottomNavBarHeight = 70.0;

class BottomNavigationControllers extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    PostScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

   BottomNavigationControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: AppPalette.whiteClr.withAlpha((0.3 * 225).round()),
        highlightColor:  AppPalette.buttonClr.withAlpha((0.2 * 255).round()), 

      ),
      child: Scaffold(
        body: BlocBuilder<ButtomNavCubit, BottomNavItem>(
          builder: (context, state) {
            switch (state) {
              case BottomNavItem.home:
                return _screens[0];
              case BottomNavItem.search:
                return _screens[1];
              case BottomNavItem.post:
                return _screens[2];
              case BottomNavItem.chat:
                return _screens[3];
              case BottomNavItem.profile:
                return _screens[4];
            }
          }),
        bottomNavigationBar: BlocBuilder<ButtomNavCubit,BottomNavItem>(
          builder: (context, state) {
            return SizedBox(
              height: bottomNavBarHeight,
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
                    icon:  Icon( CupertinoIcons.search),
                    label: 'Search',
                    activeIcon: Icon(CupertinoIcons.search,),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.space_dashboard_outlined),
                    label: 'Post',
                    activeIcon: Icon(Icons.space_dashboard)
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    label: 'Chats',
                    activeIcon: Icon(CupertinoIcons.chat_bubble_fill)
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: 'Account',
                    activeIcon: Icon(CupertinoIcons.person_fill)
                  ),
                ]),
            );
          },
          ),
      )
      );
  }
}