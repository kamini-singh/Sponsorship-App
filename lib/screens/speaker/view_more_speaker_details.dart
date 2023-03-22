import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/models/speaker.dart';
import 'package:partner_up/screens/chat/chat_homepage.dart';
import 'package:partner_up/screens/chat/chat_screen.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class SpeakerDetails extends StatefulWidget {
  SpeakerDetails({super.key, required this.speaker});
  static const routeName = 'speaker-deatils';
  Speaker speaker;

  @override
  State<SpeakerDetails> createState() => _SpeakerDetailsState();
}

class _SpeakerDetailsState extends State<SpeakerDetails> {
  TextEditingController domainController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController eventController = TextEditingController();
late ChatUser user;

  @override
  void initState(){
  user = ChatUser(
  id: widget.speaker.id,
  fname: widget.speaker.fname,
  profileImage: '',
  userType: 'speaker',
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
                  widget.speaker.fname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    FirebaseServices.updateChatList(widget.speaker.id);
                    ChatPage(user: user);
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
                'Domain',
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
                widget.speaker.domain,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const Text(
                'Years of Experience',
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
                widget.speaker.experience,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const Text(
                'Total events attended',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              // TextField(
              //   controller: eventController,
              //   cursorColor: Colors.black,
              //   decoration: const InputDecoration(
              //     hintText: '3',
              //     border: UnderlineInputBorder(),
              //     focusColor: Colors.black,
              //     hoverColor: Colors.black,
              //   ),
              // ),
              Text(
                 '2',
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
