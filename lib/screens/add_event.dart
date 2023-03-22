import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});
  static const routeName = 'add-event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController eventController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023, 3, 17),
    end: DateTime(2023, 3, 31),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    TextEditingController startController = TextEditingController(
        text: '${start.day} / ${start.month} / ${start.year}');
    TextEditingController endController =
        TextEditingController(text: '${end.day} / ${end.month} / ${end.year}');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 5,
          icon: const Icon(Icons.arrow_back_ios),
          color: PUColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Add Event Details',
            style: TextStyle(
              color: PUColors.textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(30),
                ),
                child: const Text(
                  'Event Name',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(5),
                ),
                child: TextFormField(
                  controller: eventController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the event name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: PUColors.primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: PUColors.primaryColor,
                      ),
                    ),
                    hintText: 'enter event name',
                    focusColor: PUColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(30),
                ),
                child: const Text(
                  'Date of the Event',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(170),
                      child: TextFormField(
                        controller: startController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the starting date';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: PUColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: PUColors.primaryColor,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: pickDateRange,
                            child: const Icon(
                              Icons.calendar_month,
                              color: PUColors.primaryColor,
                            ),
                          ),
                          hintText: 'start',
                          focusColor: PUColors.primaryColor,
                        ),
                      ),
                    ),
                    const Text('to'),
                    SizedBox(
                      width: getProportionateScreenWidth(170),
                      child: TextFormField(
                        controller: endController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the end date';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: pickDateRange,
                            child: const Icon(
                              Icons.calendar_month,
                              color: PUColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: PUColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: PUColors.primaryColor,
                            ),
                          ),
                          hintText: 'end',
                          focusColor: PUColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(30),
                ),
                child: const Text(
                  'Timings',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(5),
                ),
                child: TextFormField(
                  controller: timeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the time';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: PUColors.primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: PUColors.primaryColor,
                      ),
                    ),
                    hintText: 'enter time range',
                    focusColor: PUColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(30),
                ),
                child: const Text(
                  'About the Event',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(5),
                ),
                child: SizedBox(
                  height: getProportionateScreenHeight(150),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 7,
                    // expands: true,
                    keyboardType: TextInputType.multiline,
                    controller: aboutController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the detail';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: PUColors.primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: PUColors.primaryColor,
                        ),
                      ),
                      hintText: 'write a brief description about your event',
                      focusColor: PUColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await FirebaseServices().createEvent(
                        eventController.text.toString(),
                        startController.text.toString(),
                        endController.text.toString(),
                        timeController.text.toString(),
                        aboutController.text.toString(),
                        context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PUColors.primaryColor,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      getProportionateScreenHeight(50),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDate = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2023),
      lastDate: DateTime(2027),
    );

    if (newDate == null) return; // Pressed on cancel

    setState(() => dateRange = newDate); // Pressed on save
  }
}
