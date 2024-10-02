import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/home_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatID();
    super.onInit();
  }

  // var chats = firestore.collection("chats");
  var chats = firestore.collection(chatCollection);
  var friendName = Get.arguments[0];
  var friendID = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentID = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocID;

  var isLoading = false.obs;

  getChatID() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {
          friendID: null,
          currentID: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocID = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_mgs': '',
              'users': {friendID: null, currentID: null},
              'toID': '',
              'from_id': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              chatDocID = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocID).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_mgs': msg,
        'toID': friendID,
        'from_id': currentID,
      });
      chats.doc(chatDocID).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'mgs': msg,
        'uid': currentID,
      });
    }
  }
}
