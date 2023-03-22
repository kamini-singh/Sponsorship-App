import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/speaker.dart';
import 'package:partner_up/screens/speaker/view_more_speaker_details.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class SpeakerList extends StatefulWidget {
  const SpeakerList({super.key, required this.speaker});

  final Speaker speaker;

  @override
  State<SpeakerList> createState() => _SpeakerListState();
}

class _SpeakerListState extends State<SpeakerList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(10),
      ),
      child: GestureDetector(
        child: Container(
          height: getProportionateScreenHeight(130),
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
                  size: getProportionateScreenHeight(65),
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    widget.speaker.fname,
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    widget.speaker.domain,
                    style: TextStyle(
                      color: PUColors.textColor.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.speaker.experience,
                    style: TextStyle(
                      color: PUColors.textColor.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => SpeakerDetails(
                            speaker: widget.speaker,
                          ),
                        ),
                      );
                      //widget.speaker.id
                    },
                    child: const Text('View more'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
