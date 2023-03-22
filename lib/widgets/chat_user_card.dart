import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/models/message.dart';
import 'package:partner_up/screens/chat/chat_screen.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/date_util.dart';
import 'package:partner_up/utils/size_configs.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

//last message info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      //horizontal :  mq.width * .04
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            //for navigating to chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatPage(user: widget.user)));
          },
          child: StreamBuilder(
            stream: FirebaseServices.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];

              return ListTile(
                //user profile picture
                leading:const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(CupertinoIcons.person, color: Colors.white,),),

                //user name
                title: Text(widget.user.fname),

                //last message
                subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                            ? 'Image'
                            : _message!.msg
                        :'',
                    maxLines: 1),

                //last message time
                trailing: _message == null
                    ? null //show nothing when no message is sent
                    : _message!.read.isEmpty &&
                            _message!.fromId != FirebaseServices.user.uid
                        ?
                        //show for unread message
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent.shade400,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        :
                        //message sent time
                        Text(
                            MyDateUtil.getLastMessageTime(
                                context: context, time: _message!.sent),
                                style: const TextStyle(color: Colors.black54,
                                 ),
                          ),
              );
            },
          )),
    );
    
  }
}