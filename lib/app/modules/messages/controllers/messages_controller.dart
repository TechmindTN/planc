import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/profile/controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// import '../../../Network/ChatNetwork.dart';
// import '../../../models/Chat.dart';
import '../../../Network/UserNetwork.dart';

// import '../../../models/Message.dart';

import '../../../models/Client.dart';
import '../../../models/Provider.dart';
import '../../../models/User.dart';
import '../../../repositories/chat_repository.dart';
import '../../../services/auth_service.dart';
import '../../auth/controllers/auth_controller.dart';
// import '../repository/notification_repository.dart';

class MessagesController extends GetxController {
    var chatDocs;
// RxList<Asset> images = <Asset>[].obs;
  Rx<File> file = File('').obs;
  UserNetwork userNetwork;
  // List<Map<String,dynamic>> chatDocs=[];
  AuthController _authController;

  final chatTextController = TextEditingController();
  ServiceProvider serviceProvider;
  User user;
  RxList<User> receiver = <User>[].obs;
  RxList<Client> receiver_client = <Client>[].obs;
  DocumentReference userRef;

  MessagesController() {
    userNetwork = new UserNetwork();
    _authController = Get.find<AuthController>();
  }

  @override
  void onInit() async {
    // await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'Appliance Repair Company'));
    // await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'Shifting Home'));
    serviceProvider = Get.find<ProfileController>().serviceProvider.value;
    user = Get.find<AuthController>().currentUser.value;
    userRef = await userNetwork.getUserRef(user.id);
    print('this user: ' + userRef.id);

    super.onInit();
  }

  @override
  void onClose() {
    chatTextController.dispose();
  }

  signIn() {
    //_chatRepository.signUpWithEmailAndPassword(_authService.user.value.email, _authService.user.value.apiToken);
//    _chatRepository.signInWithToken(_authService.user.value.apiToken);
  }

  // Future createMessage(Message _message) async {
  //   print(_message);
  //   _message.lastMessageTime = DateTime.now().toUtc().millisecondsSinceEpoch;

  //   message.value = _message;

  //   _chatRepository.createMessage(_message).then((value) {
  //     listenForChats(_message);
  //   });
  // }

  // Future listenForMessages() async {
  //   _chatRepository.getUserMessages(user.id).listen((event) {
  //     event.sort((Message a, Message b) {
  //       return b.lastMessageTime.compareTo(a.lastMessageTime);
  //     });
  //     messages.value = event;
  //   });
  // }

  // listenForChats(String id) async {
  //   chats.value = await userNetwork.getUserChats(id);
  //   chats.value.forEach((element) {
  //     messages = (element.conversation);
  //   });
  // }

  // addMessage(Message _message, String text) {}
  //   Chat _chat =
  //       new Chat(text, DateTime.now().toUtc().millisecondsSinceEpoch, user.id);
  //   if (_message.id == null) {
  //     _message.id = UniqueKey().toString();
  //     createMessage(_message);
  //   }
  //   _message.lastMessage = text;
  //   _message.lastMessageTime = _chat.time;
  //   _message.readByUsers = [_authService.user.value.id];
  //   _chatRepository.addMessage(_message, _chat).then((value) {
  //     _message.users.forEach((_user) {
  //       if (_user.id != _authService.user.value.id) {
  //         //sendNotification(text, "New Message From".tr + " " + _authService.user.value.name, _user);
  //       }
  //     });
  //   });
  // }

  Future<String> uploadFile(file) async {
    final filename = basename(file.path);
    final destination = "/Chat/media/$filename";
    // FirebaseStorage storage = FirebaseStorage.instance;
    // Reference refimage = storage.ref().child("/stores_main/$filename");
    final ref = FirebaseStorage.instance.ref(destination);
    UploadTask uploadtask = ref.putFile(file);
    // TaskSnapshot dowurl = await (await uploadtask.whenComplete(() {}));
    final snapshot = await uploadtask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    //var url = dowurl.toString();
    print(urlDownload);
    return urlDownload;
  }

  Future changeImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile pickedimage =
        await _picker.pickImage(source: ImageSource.gallery);
    file.value = File(pickedimage.path);
    update();
    print(file.value);
  }
}
