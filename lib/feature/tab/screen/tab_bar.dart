import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/account/screen/account_screen.dart';
import 'package:mobile_survey/feature/assignment/screen/assignment_screen.dart';
import 'package:mobile_survey/feature/home/screen/home_screen.dart';
import 'package:mobile_survey/feature/pending/screen/pending_screen.dart';
import 'package:mobile_survey/feature/tab/provider/tab_provider.dart';
import 'package:provider/provider.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  Widget _getPage(int index) {
    if (index == 0) {
      return const HomeScreen();
    }
    if (index == 1) {
      return const AssignmentScreen();
    }
    if (index == 2) {
      return const PendingScreen();
    }
    if (index == 3) {
      return const AccountScreen();
    }

    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    var bottomBarProvider = Provider.of<TabProvider>(context);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomBarProvider.page,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (index) {
            bottomBarProvider.setPage(index);
          },
          iconSize: 18,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          selectedLabelStyle: const TextStyle(
              fontSize: 13,
              color: primaryColor,
              height: 1.5,
              fontWeight: FontWeight.w600),
          elevation: 0,
          selectedIconTheme: const IconThemeData(color: primaryColor),
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xFF575551),
          unselectedLabelStyle: const TextStyle(
              color: Color(0xFF575551),
              height: 1.5,
              fontWeight: FontWeight.w600),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage('assets/icon/home_icon.png'), size: 18),
              activeIcon: ImageIcon(
                  AssetImage('assets/icon/home_active_icon.png'),
                  size: 18),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icon/assignment_icon.png'),
                    size: 18),
                activeIcon: ImageIcon(
                    AssetImage('assets/icon/assignment_active_icon.png'),
                    size: 18),
                label: 'Assignment',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icon/pending_icon.png'),
                  size: 18),
              activeIcon: ImageIcon(
                  AssetImage('assets/icon/pending_active_icon.png'),
                  size: 18),
              label: 'Pending',
            ),
            BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage('assets/icon/akun_icon.png'), size: 18),
              activeIcon: ImageIcon(
                  AssetImage('assets/icon/akun_active_icon.png'),
                  size: 18),
              label: 'Profile',
            ),
          ],
        ),
        body: _getPage(bottomBarProvider.page));
  }
}
