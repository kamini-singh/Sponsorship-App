import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:partner_up/auth/auth.dart';
import 'package:partner_up/screens/speaker/tabs_screen_become.dart';
import 'package:partner_up/screens/speaker/tabs_scren_find.dart';
import 'package:partner_up/screens/sponsor/becomeSponsor/tabscreen.dart';
import 'package:partner_up/screens/sponsor/findSponsor/tabscreen.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main-page';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  // String userType = '';
  // Future<dynamic> getDetails() async {
  //   await FirebaseServices.getSelfInfo();
  //   userType = FirebaseServices.currentUser.userType;
  // }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //   getDetails();
            // if (userType == 'speakerOrg') {
            //   return const TabsScreenFind();
            // } else if (userType == 'speaker') {
            //   return const TabsScreenBecome();
            // } else if (userType == 'sponsor') {
            //   return const TabsScreenSponsorFind();
            // }
            // else if (userType == 'sponsorOrg') {
            //   return const TabsScreenSponsorOrg();
            // }
          }
          return const AuthPage();
        },
      ),
    );
  }
}
