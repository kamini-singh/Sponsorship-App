import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:partner_up/models/chat_user.dart';
import 'package:partner_up/models/message.dart';
import 'package:partner_up/models/speaker.dart';
import 'package:partner_up/models/speakerOrg.dart';
import 'package:partner_up/screens/speaker/tabs_screen_become.dart';
import 'package:partner_up/screens/speaker/tabs_scren_find.dart';
import 'package:partner_up/screens/sponsor/becomeSponsor/tabscreen.dart';
import 'package:partner_up/screens/sponsor/findSponsor/tabscreen.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  static User get user => auth.currentUser!;
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore data
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  final docSponsorOrg = FirebaseFirestore.instance
      .collection('sponsorOrg')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  final docSponsor = FirebaseFirestore.instance
      .collection('sponsor')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  final docSpeaker = FirebaseFirestore.instance
      .collection('speaker')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  final docSpeakerOrg = FirebaseFirestore.instance
      .collection('speakerOrg')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  final docEvent = FirebaseFirestore.instance
      .collection('events')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  final docUser = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  Future createSpeaker(
    String fname,
    String lname,
    String domain,
    String exp,
    String event,
    BuildContext context,
  ) async {
    final json = {
      'fname': fname,
      'lname': lname,
      'domain': domain,
      'experience': exp,
      'events': event,
      'id': FirebaseAuth.instance.currentUser?.uid,
    };

    await docSpeaker.set(json);
    ChatUser newUser = ChatUser(
        fname: fname,
        id: FirebaseAuth.instance.currentUser!.uid,
        userType: 'speaker',
        profileImage: '');
    await docUser.set(newUser.toJson());
    await getSelfInfo();
    Navigator.of(context).pushReplacementNamed(TabsScreenBecome.routeName);
  }

  Future createSponsorOrg(
    String orgName,
    String orgType,
    String range,
    String gst,
    BuildContext context,
  ) async {
    final json = {
      'orgName': orgName,
      'orgType': orgType,
      'range': range,
      'gst': gst,
      'id': FirebaseAuth.instance.currentUser?.uid,
    };

    ChatUser newUser = ChatUser(
        fname: orgName,
        id: FirebaseAuth.instance.currentUser!.uid,
        userType: 'sponsorOrg',
        profileImage: '');
    await docUser.set(newUser.toJson());
    await docSponsorOrg.set(json);
    await getSelfInfo();
    Navigator.of(context).pushReplacementNamed(TabsScreenSponsorOrg.routeName);
  }

 Future createSponsor(
    String orgName,
    String orgType,
    String amount,
    String reason,
    BuildContext context,
  ) async {
    final json = {
      'orgName': orgName,
      'orgType': orgType,
      'amount': amount,
      'reason': reason,
      'id': FirebaseAuth.instance.currentUser?.uid,
    };
    ChatUser newUser = ChatUser(
        fname: orgName,
        id: FirebaseAuth.instance.currentUser!.uid,
        userType: 'sponsor',
        profileImage: '');
    await docUser.set(newUser.toJson());
    await docSponsor.set(json);
    await getSelfInfo();
    Navigator.of(context).pushReplacementNamed(TabsScreenSponsorFind.routeName);
  }

  Future createSpeakerOrg(
    String orgName,
    String orgType,
    String about,
    BuildContext context,
  ) async {
    final json = {
      'orgName': orgName,
      'orgType': orgType,
      'about': about,
      'id': FirebaseAuth.instance.currentUser?.uid,
    };

    ChatUser newUser = ChatUser(
        fname: orgName,
        id: FirebaseAuth.instance.currentUser!.uid,
        userType: 'speakerOrg',
        profileImage: '');
    await docUser.set(newUser.toJson());
    await docSpeakerOrg.set(json);
    await getSelfInfo();
    Navigator.of(context).pushReplacementNamed(TabsScreenFind.routeName);
  }

  Future createEvent(
    String eventName,
    String startDate,
    String endDate,
    String time,
    String about,
    BuildContext context,
  ) async {
    final json = {
      'eventName': eventName,
      'start': startDate,
      'end': endDate,
      'time': time,
      'about': about,
      'id': FirebaseAuth.instance.currentUser?.uid,
    };
    await docSpeaker.set(json);
    ChatUser newUser = ChatUser(
        fname: eventName,
        id: FirebaseAuth.instance.currentUser!.uid,
        userType: 'event',
        profileImage: '');
    await docUser.set(newUser.toJson());
    await docEvent.set(json);
    Navigator.of(context).pop();
  }

  //for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    return firestore
        .collection('user')
        .where('id', whereIn: userIds.isEmpty ? [''] : userIds)
        .snapshots();
  }

  //****Chat Page related APIs *****

  // chats(collection)--> conversation_id(doc) --> messages (collection) -->message (doc)
  //useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: false)
        .snapshots();
  }

  //for sending msg
  static Future<void> sendMessage(ChatUser chatUser, String msg) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: Type.text,
        fromId: user.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //updaet read status of a message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //new tasks
  //retrieving events from events collection
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllEvents() {
    return firestore.collection('events').snapshots();
  }

  //retrieving sponsors from sponsorOrg collection
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSponsorOrgs() {
    return firestore.collection('sponsorOrg').snapshots();
  }

  //retrieving sponsee's from sponsor collection
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSponsees() {
    return firestore.collection('sponsor').snapshots();
  }

  //retrieving speakers from speaker collection
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSpeakers() {
    return firestore.collection('speaker').snapshots();
  }

  // for storing self information
  static late ChatUser currentUser;
  //for getting self info
  static Future<void> getSelfInfo() async {
    await firestore.collection('user').doc(user.uid).get().then((user) async {
      if (user.exists) {
        currentUser = ChatUser.fromJson(user.data()!);
      }
    });
  }

  //****Firebase Storage related work*****
  static FirebaseStorage storage = FirebaseStorage.instance;

  // update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref.putFile(file).then((p0) {});

    //updating image in firestore database
    currentUser.profileImage = await ref.getDownloadURL();
    await firestore
        .collection('user')
        .doc(user.uid)
        .update({'profileImage': currentUser.profileImage});
  }

//add user to chat list
  static Future<void> updateChatList(String addedId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('myChats')
        .doc(addedId)
        .set({});
    await FirebaseFirestore.instance
        .collection('user')
        .doc(addedId)
        .collection('myChats')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({});
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersChats() {
    return firestore
        .collection('user')
        .doc(user.uid)
        .collection('myChats')
        .snapshots();
  }

//getting speakerOrg info
static Future<void> getSpeakerOrgInfo(SpeakerOrg speakerOrg) async {
    await firestore.collection('speakerOrg').doc(user.uid).get().then((user) async {
      if (user.exists) {
        speakerOrg = SpeakerOrg.fromJson(user.data()!);
      }
    });
  }

//getting speaker info
static Future<void> getSpeakerInfo(Speaker speaker) async {
    await firestore.collection('speaker').doc(user.uid).get().then((user) async {
      if (user.exists) {
        speaker = Speaker.fromJson(user.data()!);
      }
    });
  }
}
