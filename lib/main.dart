import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:partner_up/auth/main_page.dart';
import 'package:partner_up/auth/verify.dart';
import 'package:partner_up/firebase_options.dart';
import 'package:partner_up/screens/add_event.dart';
import 'package:partner_up/screens/event_speaker.dart';
import 'package:partner_up/screens/find_sponsor.dart';
import 'package:partner_up/screens/interest.dart';
import 'package:partner_up/screens/onboarding.dart';
import 'package:partner_up/screens/speaker.dart';
import 'package:partner_up/screens/speaker/home_become.dart';
import 'package:partner_up/screens/speaker/tabs_screen_become.dart';
import 'package:partner_up/screens/speaker/tabs_scren_find.dart';
import 'package:partner_up/screens/speaker/view_more_speaker_details.dart';
import 'package:partner_up/screens/sponsor.dart';
import 'package:partner_up/screens/sponsor/becomeSponsor/tabscreen.dart';
import 'package:partner_up/screens/sponsor/findSponsor/tabscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
            .copyWith(background: Colors.white),
      ),
      home: const MainPage(),
      routes: {
        OnBoardingScreen.routeName: (context) => OnBoardingScreen(interest: 0),
        InterestScreen.routeName: (context) => const InterestScreen(),
        SpeakerPage.routeName: (context) => const SpeakerPage(),
        Verification.routeName: (context) => const Verification(),
        MainPage.routeName: (context) => const MainPage(),
        SponsorPage.routeName: (context) => const SponsorPage(),
        HomeBecomeScreen.routeName: (context) => HomeBecomeScreen(
              interest: 1,
            ),
        TabsScreenBecome.routeName: (context) => const TabsScreenBecome(),
        TabsScreenSponsorFind.routeName: (context) => const TabsScreenSponsorFind(),
        TabsScreenSponsorOrg.routeName: (context) => const TabsScreenSponsorOrg(),
        EventSpeakerReg.routeName: (context) => const EventSpeakerReg(),
        TabsScreenFind.routeName: (context) => const TabsScreenFind(),
        AddEvent.routeName: (context) => const AddEvent(),
        FindSponsor.routeName : (context) => const FindSponsor(),
      },
    );
  }
}
