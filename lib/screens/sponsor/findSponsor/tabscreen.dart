import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/screens/chat/chat_homepage.dart';
import 'package:partner_up/screens/sponsor/findSponsor/home_screen_sponsor.dart';
import 'package:partner_up/screens/sponsor/findSponsor/profile_sponsor.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class TabsScreenSponsorFind extends StatefulWidget {
  const TabsScreenSponsorFind({super.key});
  static const routeName = 'tabs-screen-find-sponsor';

  @override
  State<TabsScreenSponsorFind> createState() => _TabsScreenSponsorFindState();
}

class _TabsScreenSponsorFindState extends State<TabsScreenSponsorFind> {
  int currentIndex = 0;
  final List<Widget> children = [
    HomeSponsor(),
    const ChatHomePage(),
    ProfileScreenSponsor(user: FirebaseServices.currentUser)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: MoltenBottomNavigationBar(
        domeCircleColor: PUColors.primaryColor,
        domeCircleSize: 60,
        domeHeight: 30,
        domeWidth: 120,
        barHeight: getProportionateScreenHeight(70),
        selectedIndex: currentIndex,
        tabs: [
          MoltenTab(
            icon: const Icon(
              Icons.home_filled,
              size: 30,
            ),
          ),
          MoltenTab(
            icon: const Icon(
              Icons.chat,
              size: 30,
            ),
          ),
          MoltenTab(
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ],
        onTabChange: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
