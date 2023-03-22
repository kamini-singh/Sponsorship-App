import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/events.dart';
import 'package:partner_up/utils/size_configs.dart';

class EventList extends StatefulWidget {
  const EventList({super.key, required this.event});
  final Events event;

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(10),
      ),
      child: GestureDetector(
        child: Container(
          height: getProportionateScreenHeight(115),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                ),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: getProportionateScreenHeight(70),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    widget.event.eventName,
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    widget.event.start,
                    style: TextStyle(
                      color: PUColors.textColor.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.event.time,
                    style: TextStyle(
                      color: PUColors.textColor.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  const Text('View more'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
