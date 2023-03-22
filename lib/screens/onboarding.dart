import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/screens/event_speaker.dart';
import 'package:partner_up/screens/find_sponsor.dart';
import 'package:partner_up/screens/speaker.dart';
import 'package:partner_up/screens/sponsor.dart';
import 'package:partner_up/utils/size_configs.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key, required this.interest});
  static const routeName = 'on-boarding';
  int interest;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/BG.png'),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(230),
                ),
                const Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    color: PUColors.textColor,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                GestureDetector(
                  onTap: () {
                    widget.interest == 0
                        ? Navigator.of(context).pushNamed(SponsorPage.routeName)
                        : Navigator.of(context)
                            .pushNamed(SpeakerPage.routeName);
                  },
                  child: Container(
                    height: getProportionateScreenHeight(75),
                    width: getProportionateScreenWidth(250),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 179, 1, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.interest == 0
                            ? 'Become a sponsor'
                            : 'Become a speaker',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: PUColors.textColor,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                GestureDetector(
                  onTap: () {
                    widget.interest == 0
                        ? Navigator.of(context)
                            .pushReplacementNamed(FindSponsor.routeName)
                        : Navigator.of(context)
                            .pushReplacementNamed(EventSpeakerReg.routeName);
                  },
                  child: Container(
                    height: getProportionateScreenHeight(75),
                    width: getProportionateScreenWidth(250),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 179, 1, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.interest == 0
                            ? 'Find a sponsor'
                            : 'Find a speaker',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
