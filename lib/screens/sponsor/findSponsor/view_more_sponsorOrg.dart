import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/models/sponsorOrg.dart';
import 'package:partner_up/screens/chat/chat_screen.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class SponsorDetails extends StatefulWidget {
  SponsorDetails({super.key, required this.sponsorOrg});
  static const routeName = 'sponsor-deatils';
  SponsorOrg sponsorOrg;

  @override
  State<SponsorDetails> createState() => _SponsorDetailsState();
}

class _SponsorDetailsState extends State<SponsorDetails> {
  TextEditingController domainController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  late ChatUser user;

  @override
  void initState(){
  user = ChatUser(
  id: widget.sponsorOrg.id,
  fname: widget.sponsorOrg.orgName,
  profileImage: '',
  userType: 'sponsorOrg',
);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PUColors.primaryColor,
        elevation: 0,
        toolbarHeight: getProportionateScreenHeight(110),
        leading: IconButton(
          splashRadius: 5,
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Icon(
              Icons.account_circle,
              size: getProportionateScreenHeight(65),
              color: Colors.grey,
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sponsorOrg.orgName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    FirebaseServices.updateChatList(widget.sponsorOrg.id);
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ChatPage(
                            user: user,
                          ),
                        ),
                      );;
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Organization Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              // TextField(
              //   controller: domainController,
              //   cursorColor: Colors.black,
              //   decoration: const InputDecoration(
              //     //hintText: ,
              //     border: UnderlineInputBorder(),
              //     focusColor: Colors.black,
              //     hoverColor: Colors.black,
              //   ),
              // ),
              Text(
                widget.sponsorOrg.orgType,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const Text(
                'Range of Sponsorship provided',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              // TextField(
              //   controller: expController,
              //   cursorColor: Colors.black,
              //   decoration: const InputDecoration(
              //     hintText: '2',
              //     border: UnderlineInputBorder(),
              //     focusColor: Colors.black,
              //     hoverColor: Colors.black,
              //   ),
              // ),
              Text(
                widget.sponsorOrg.range,
                style: TextStyle(
                  fontSize: 22,
                ),
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
                      'Visit',
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
                      'Visit',
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
                      'Visit',
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
                      'Visit',
                      style: TextStyle(
                        color: PUColors.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
