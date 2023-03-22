import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/sponsorOrg.dart';
import 'package:partner_up/screens/sponsor/findSponsor/view_more_sponsorOrg.dart';
import 'package:partner_up/utils/size_configs.dart';

class SponserList extends StatefulWidget {
  const SponserList({super.key, required this.sponsorOrg});
  final SponsorOrg sponsorOrg;

  @override
  State<SponserList> createState() => _SponserListState();
}

class _SponserListState extends State<SponserList> {
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
                    widget.sponsorOrg.orgName,
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    widget.sponsorOrg.orgType,
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
                          builder: (BuildContext context) => SponsorDetails(
                            sponsorOrg: widget.sponsorOrg,
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
