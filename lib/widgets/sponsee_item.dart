import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/sponsor.dart';
import 'package:partner_up/screens/sponsor/becomeSponsor/view_more_sponsor.dart';
import 'package:partner_up/utils/size_configs.dart';

class SponseeList extends StatefulWidget {
  const SponseeList({super.key, required this.sponsor});
  final Sponsor sponsor;

  @override
  State<SponseeList> createState() => _SponseeListState();
}

class _SponseeListState extends State<SponseeList> {
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
                    widget.sponsor.orgName,
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    widget.sponsor.orgType,
                    style: TextStyle(
                      color: PUColors.textColor.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                  // Text(
                  //   widget.event.time,
                  //   style: TextStyle(
                  //     color: PUColors.textColor.withOpacity(0.8),
                  //     fontSize: 15,
                  //   ),
                  // ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => SponseeDetails(
                            sponsor: widget.sponsor,
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
