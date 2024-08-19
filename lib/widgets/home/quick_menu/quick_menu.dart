import 'package:clean_mngr/screens/profile.dart';
import 'package:clean_mngr/widgets/home/quick_menu/infinite_scroll_list.dart';
import 'package:clean_mngr/widgets/home/quick_menu/quick_menu_item.dart';
import 'package:flutter/material.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      // color: Colors.transparent,
      child: InfiniteScrollList(
        diameterRatio: 3,
        itemExtent: 150,
        scrollDirection: Axis.horizontal,
        children: [
          QuickMenuItem(
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              print('Home');
            },
          ),
          QuickMenuItem(
            icon: Icons.person_outline,
            label: 'Profile',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
          ),
          QuickMenuItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () {
              print('Settings');
            },
          ),
          QuickMenuItem(
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            onTap: () {
              print('Notifications');
            },
          ),
          QuickMenuItem(
            icon: Icons.logout_outlined,
            label: 'Logout',
            onTap: () {
              print('Logout');
            },
          ),
        ],
      ),
    );
  }
}