import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/models/events.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/widgets/event_items.dart';
import 'package:partner_up/utils/size_configs.dart';

class HomeBecomeScreen extends StatefulWidget {
  HomeBecomeScreen({super.key, required this.interest});
  static const routeName = 'home-become';
  int interest;

  @override
  State<HomeBecomeScreen> createState() => _HomeBecomeScreenState();
}

class _HomeBecomeScreenState extends State<HomeBecomeScreen> {
  @override
  List<Events> events = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Welcome ${FirebaseServices.currentUser.fname}',
            style: const TextStyle(
              color: PUColors.textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                              'Search upcoming events',
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
                'Popular Events',
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
                    stream: FirebaseServices.getAllEvents(),
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
                          events = data
                                  ?.map((e) => Events.fromJson(e.data()))
                                  .toList() ??
                              [];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return EventList(event: events[index]);
                            },
                            itemCount: events.length,
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
