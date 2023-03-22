import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class FindSponsor extends StatefulWidget {
  const FindSponsor({super.key});
  static const routeName = 'find-sponsor';

  @override
  State<FindSponsor> createState() => _FindSponsorState();
}

class _FindSponsorState extends State<FindSponsor> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  final amtRange = [
    'Less than 10k',
    '10k-20k',
    '20k-30k',
    '30k-40k',
    'More than 40k'
  ];

  String? selectedVal = '10k-20k';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter Details',
            style: TextStyle(
              color: PUColors.textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          splashRadius: 5,
          icon: const Icon(Icons.arrow_back_ios),
          color: PUColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const Image(
              image: AssetImage('assets/images/BG.png'),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                    ),
                    child: const Text(
                      'Organization Name',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5),
                    ),
                    child: TextFormField(
                      controller: fnameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your organization name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        hintText: 'enter organization name',
                        focusColor: PUColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                    ),
                    child: const Text(
                      'Type of Organization',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5),
                    ),
                    child: TextFormField(
                      controller: lnameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        hintText: 'enter organization',
                        focusColor: PUColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                    ),
                    child: const Text(
                      'Amount of Sponsorship (in ₹)',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5),
                    ),
                    child: SizedBox(
                      //width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: PUColors.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: PUColors.primaryColor,
                              ),
                            ),
                          ),
                          value: selectedVal,
                          items: amtRange.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedVal = val as String;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                    ),
                    child: const Text(
                      'Reason for Sponsorship',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5),
                    ),
                    child: TextFormField(
                      controller: reasonController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a reason';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        hintText: 'enter reason',
                        focusColor: PUColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          await FirebaseServices().createSponsor(
                            fnameController.text.toString(),
                            lnameController.text.toString(),
                            selectedVal.toString(),
                            reasonController.text.toString(),
                            context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PUColors.primaryColor,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          getProportionateScreenHeight(50),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
