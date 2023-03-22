import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class EventSpeakerReg extends StatefulWidget {
  const EventSpeakerReg({super.key});
  static const routeName = 'event-speaker';

  @override
  State<EventSpeakerReg> createState() => _EventSpeakerRegState();
}

class _EventSpeakerRegState extends State<EventSpeakerReg> {
  TextEditingController orgController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    height: getProportionateScreenHeight(30),
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
                      controller: orgController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your organisation name';
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
                      'Type of organization',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                    ),
                    child: Text(
                      'Tech, Educational, Marketing etc',
                      style: TextStyle(
                        fontSize: 14,
                        color: PUColors.textColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(5),
                    ),
                    child: TextFormField(
                      controller: typeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the type of organization';
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
                        hintText: 'enter organization type',
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
                      'About Organization',
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
                      height: getProportionateScreenHeight(150),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 7,
                        // expands: true,
                        keyboardType: TextInputType.multiline,
                        controller: aboutController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the detail';
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
                          hintText:
                              'write a brief description about your organization',
                          focusColor: PUColors.primaryColor,
                        ),
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
                          await FirebaseServices().createSpeakerOrg(
                            orgController.text.toString(),
                            typeController.text.toString(),
                            aboutController.text.toString(),
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
