import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/speaker.dart';
import 'package:partner_up/screens/add_event.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';
import 'package:partner_up/widgets/event_items.dart';
import 'package:partner_up/widgets/speaker_items.dart';

class HomeEvent extends StatefulWidget {
  const HomeEvent({super.key});

  @override
  State<HomeEvent> createState() => _HomeEventState();
}

class _HomeEventState extends State<HomeEvent> {
  List<Speaker> speakers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Welcome GDSC-IGDTUW', // ${FirebaseServices.currentUser.fname}',
            style: const TextStyle(
              color: PUColors.textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        backgroundColor: PUColors.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                children: [
                  Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(300),
                    decoration: BoxDecoration(
                      // boxShadow: ,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search speaker',
                              style: TextStyle(
                                color: PUColors.textColor.withOpacity(0.7),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: PUColors.textColor.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(10),
                  ),
                  Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(50),
                    decoration: BoxDecoration(
                      // boxShadow: ,
                      borderRadius: BorderRadius.circular(12),
                      color: PUColors.primaryColor,
                    ),
                    child: Image.asset(
                      'assets/images/filter.png',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const Text(
                'Popular Speakers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseServices.getAllSpeakers(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(
                              child: CircularProgressIndicator());

                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:

                          //map of all events
                          final data = snapshot.data?.docs;
                          speakers = data
                                  ?.map((e) => Speaker.fromJson(e.data()))
                                  .toList() ??
                              [];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SpeakerList(speaker: speakers[index]);
                            },
                            itemCount: speakers.length,
                          );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
