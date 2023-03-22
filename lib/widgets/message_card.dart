import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/message.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/date_util.dart';
import 'package:partner_up/utils/size_configs.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    //mq = MediaQuery.of(context).size;
    return FirebaseServices.user.uid == widget.message.fromId
        ? _userMessage()
        : _senderMessage();
  }

  //sender or another user's msg
  Widget _senderMessage() {
    //update that message is read from other user
    if (widget.message.read.isEmpty) {
      FirebaseServices.updateMessageReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * .04,
                  vertical: SizeConfig.screenHeight * .01),
              padding: EdgeInsets.all(SizeConfig.screenWidth * .04),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: PUColors.primaryColor,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )),
              child: Text(
                widget.message.msg,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              )),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.3),
        Row(
          children: [
            //msg send time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  //current user's msg
  Widget _userMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(SizeConfig.screenWidth * .01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //msg send time
              Text(
                MyDateUtil.getFormattedTime(
                    context: context, time: widget.message.sent),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              //msg read or not
              if (widget.message.read.isNotEmpty)
                const Icon(Icons.done_all_rounded, color: Colors.grey, size: 20),
            ],
          ),
        ),
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * .04,
                  vertical: SizeConfig.screenHeight * .01),
              padding: EdgeInsets.all(SizeConfig.screenWidth * .04),
              decoration: const BoxDecoration(
                  color: PUColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Text(
                widget.message.msg,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              )),
        ),
      ],
    );
  }
}
