import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner_up/auth/main_page.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class ProfileScreenSponsor extends StatefulWidget {
  const ProfileScreenSponsor({super.key, required this.user});
  final ChatUser user;
  @override
  State<ProfileScreenSponsor> createState() => _ProfileScreenSponsorState();
}

class _ProfileScreenSponsorState extends State<ProfileScreenSponsor> {
  String _image = '';
  TextEditingController typeController = TextEditingController(text: 'App');
  TextEditingController aboutController = TextEditingController(
      text: 'Student Club which conducts technical events');
  TextEditingController eventController = TextEditingController(text: '4');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getProportionateScreenHeight(160),
            decoration: const BoxDecoration(
              color: PUColors.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
                top: getProportionateScreenHeight(60),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 80);
                          if (image != null) {
                            setState(() {
                              _image = image.path;
                            });
                            FirebaseServices.updateProfilePicture(File(_image));
                            setState(() {
                              _image = widget.user.profileImage;
                            });
                          }
                        },
                        child: _image != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.screenHeight * .1),
                                child: Container(
                                  width: SizeConfig.screenHeight * .08,
                                  height: SizeConfig.screenHeight * .08,
                                  child: Image.network(
                                    widget.user.profileImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.account_circle,
                                size: getProportionateScreenWidth(60),
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.user.fname,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Organization',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: getProportionateScreenWidth(38),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('sponsor')
                      .doc(widget.user.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("Loading"));
                    }
                    var userDocument = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Type of Organization',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          userDocument['orgType'],
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Divider(
                          color: PUColors.textColor.withOpacity(0.8),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25),
                        ),
                        const Text(
                          'Amount of Sponsorship required',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          userDocument['amount'],
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Divider(
                          color: PUColors.textColor.withOpacity(0.8),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25),
                        ),
                        const Text(
                          'Reason of Sponsorship',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          userDocument['reason'],
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Divider(
                          color: PUColors.textColor.withOpacity(0.8),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25),
                        ),
                        const Text(
                          'Social Media Handles',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          children: [
                            Container(
                              height: getProportionateScreenHeight(30),
                              width: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/linkedin.png',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            GestureDetector(
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                  color: PUColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          children: [
                            Container(
                              height: getProportionateScreenHeight(30),
                              width: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/twitter.png',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            GestureDetector(
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                  color: PUColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          children: [
                            Container(
                              height: getProportionateScreenHeight(30),
                              width: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/github.png',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            GestureDetector(
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                  color: PUColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          children: [
                            Container(
                              height: getProportionateScreenHeight(30),
                              width: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/insta.jpeg',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            GestureDetector(
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                  color: PUColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25),
                        ),
                        Divider(
                          color: PUColors.textColor.withOpacity(0.8),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(22),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                    'Are you sure you want to logout ?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance
                                          .signOut()
                                          .then((_) {
                                        print('success logging out');
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                MainPage.routeName);
                                      }).catchError((e) {
                                        print('failure logging out');
                                        print(e);
                                      });
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: PUColors.primaryColor),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          color: PUColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Text(
                                'Logout',
                                style: TextStyle(
                                  color: PUColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              const Icon(
                                Icons.logout,
                                color: PUColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
