import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';
import 'package:partner_up/widgets/chat_user_card.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  List<ChatUser> list = []; //list of users

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Inbox',
            style: TextStyle(
              color: PUColors.textColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
        body: StreamBuilder(
          stream: FirebaseServices.getMyUsersChats(),

            //get id of only known users
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());

                //if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  return StreamBuilder(
                    stream: FirebaseServices.getAllUsers(
                        snapshot.data?.docs.map((e) => e.id).toList() ?? []),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
        
                  //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    list = data
                            ?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ??
                        [];
        
                    if (list.isNotEmpty) {
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ChatUserCard(user: list[index]);
                        },
                      );
                    } else {
                      return const Center(
                         child: Text('No Connections Found'));
                    }
                }
              });  }
            }
        ),
      ),
    );
  }
}
