import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/models/message.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';
import 'package:partner_up/widgets/message_card.dart';

class ChatPage extends StatefulWidget {
  final ChatUser user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
//for storing all the messages
  List<Message> _list = [];

//for handling meassage text
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
            top: getProportionateScreenHeight(30),
          ),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.1,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: PUColors.primaryColor,
                  )),
              //add profile picture here

              Icon(
                Icons.account_circle,
                size: getProportionateScreenWidth(50),
                color: Colors.grey,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * .05,
              ),
              //user details
              Text(
                widget.user.fname,
                style: const TextStyle(
                  color: PUColors.primaryColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        //streambuilder to get msgs
        Expanded(
          child: StreamBuilder(
              stream: FirebaseServices.getAllMessages(widget.user),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();

                  //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _list =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return MessageCard(message: _list[index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Start Messaging',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                }
              }),
        ),
        _chatInput(),
      ],
    ));
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenWidth(10)),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  color: PUColors.primaryColor,
                ),
              ),
              child: Row(
                children: [
                  //emoji Button
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.emoji_emotions),
                      color: PUColors.primaryColor),

                  // to get msg input from user
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(color: PUColors.primaryColor),
                          border: InputBorder.none),
                    ),
                  ),

                  //to take image from gallery
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.image),
                      color: PUColors.primaryColor),
                  MaterialButton(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 5, left: 10),
                    minWidth: 0,
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        FirebaseServices.sendMessage(
                            widget.user, _textController.text);
                        _textController.text = '';
                      }
                    },
                    child: const Icon(Icons.send, color: PUColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
