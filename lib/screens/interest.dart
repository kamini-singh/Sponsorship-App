import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/screens/onboarding.dart';
import 'package:partner_up/utils/size_configs.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});
  static const routeName = 'interest';

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  int interest = 0;
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
                  'Choose your interest',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                    fontFamily: 'Poppins-Regular.ttf',
                    color: PUColors.textColor,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      interest = 0;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => OnBoardingScreen(
                          interest: interest,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: getProportionateScreenHeight(75),
                    width: getProportionateScreenWidth(200),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 179, 1, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Sponsors',
                        style: TextStyle(color: Colors.white, fontSize: 26),
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
                    setState(() {
                      interest = 1;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => OnBoardingScreen(
                          interest: interest,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: getProportionateScreenHeight(75),
                    width: getProportionateScreenWidth(200),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 179, 1, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Speakers',
                        style: TextStyle(
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
