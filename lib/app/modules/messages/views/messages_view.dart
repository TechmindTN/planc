import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/Network/ClientNetwork.dart';
import 'package:home_services_provider/app/modules/profile/controllers/profile_controller.dart';
import '../../../../common/ui.dart';
// import '../../../Network/MessageNetwork.dart';
import '../../../Network/ServiceProviderNetwork.dart';
import '../../../Network/UserNetwork.dart';
// import '../../../models/Chat.dart';
import '../../../models/Client.dart';
// import '../../../models/Message.dart';

import '../../../global_widgets/circular_loading_widget.dart';

import '../../../models/Provider.dart';
import '../../../models/User.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/messages_controller.dart';
import '../widgets/chat_message_item_widget.dart';
import '../widgets/message.dart';
import '../widgets/new_message.dart';
import 'chats_view.dart';

// ignore: must_be_immutable
class MessagesView extends GetView<MessagesController> {
  // ServiceProviderNetwork _providerNetwork = ServiceProviderNetwork();
  ClientNetwork _clientNetwork = ClientNetwork();

  @override
  Widget build(BuildContext context) {
    print('message view');
    return Container(
        color: Colors.white,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.purple, Colors.pink],
        //     tileMode: TileMode.clamp,
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //   ),
        // ),
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Chat',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Ui.parseColor('#00B6BF'),
              // actions: [
              //   DropdownButton(
              //     icon: const Icon(
              //       Icons.more_vert,
              //       color: Colors.white,
              //     ),
              //     items: [
              //       DropdownMenuItem(
              //         child: Row(children: const [
              //           Icon(
              //             Icons.exit_to_app,
              //             color: Colors.pink,
              //           ),
              //           SizedBox(
              //             width: 8,
              //           ),
              //           Text('Logout')
              //         ]),
              //         value: 'logout',
              //       )
              //     ],
              //     onChanged: (itemIdentifier) {
              //       if (itemIdentifier == 'logout') {}
              //     },
              //   )
              // ],
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Chat")
                    .where('users',
                        arrayContains: getProviderref(Get.find<ProfileController>()
                            .serviceProvider
                            .value
                            .id))
                    .orderBy('LastMsgAt', descending: true)
                    .snapshots(),
                builder: (ctx, chatSnapshot) {
                  print('chat docs length: '+chatSnapshot.toString());
                
                  if (chatSnapshot.connectionState == ConnectionState.waiting || !chatSnapshot.hasData||chatSnapshot.hasError||chatSnapshot.isBlank) {
                    print('prob');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print('chats: ' + chatSnapshot.data.toString());
                    final chatDocs = chatSnapshot.data?.docs;
                    ServiceProvider sp;
                    //  var Lastmsg = FirebaseFirestore.instance
                    // .collection("Chat")
                    // .where('users', arrayContains: controller.userRef)

                    return ListView.builder(
                        itemCount: chatDocs?.length,
                        // ignore: missing_return
                        itemBuilder: (ctx, index) {
                          print('to to hello');
                          for(var el in chatDocs[index]["users"]) {
                            print('to hello');
                            if (el.id != Get.find<ProfileController>().serviceProvider.value.id) {
                              log('user.id ' + controller.user.id);
                              log('el.id ' + el.id);
                              // controller.userNetwork
                              //     .getUserById(el.id)
                              //     .then((value) {
                                // controller.receiver.add(value);
                                // controller.update();
                              // });
                              
                              _clientNetwork
                                  .getClientById(el.id)
                                  .then((value2) {
                                    print('client data '+value2.first_name.toString());
                                controller.receiver_client.add(value2);
                                print('reciever clients length: '+controller.receiver_client.length.toString());
                                print("first client "+controller.receiver_client.first.first_name.toString());
                              log("first client "+controller.receiver_client.first.first_name.toString());

                                controller.update();
                              });
                            }
                            controller.update();
                          };
                          controller.update();
                          return GetBuilder<MessagesController>(
                              // init: MessagesController(),
                              builder: (val)  {
                                Future.delayed(Duration(seconds: 5),
                                (){
                                  val.receiver_client.forEach((e){
log('chat data: '+e.toString());
// controller.update();
                                  });
                                  

                                }
                                );
                              //  if(controller.chatDocs.length>0) 
                               return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(children: [
                                      InkWell(
                                          child: Container(
                                            height: 80,
                                            child: Column(children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(val
                                                              .receiver_client
                                                              [index]
                                                              .profile_photo),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      val
                                                              .receiver_client
                                                              .value[index]
                                                              .first_name +
                                                          ' ' +
                                                          val
                                                              .receiver_client
                                                              .value[index]
                                                              .last_name,
                                                      // val.receiver.value[index]
                                                      //         .username ??
                                                      //     '',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Last message",
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                ],
                                              )
                                            ]),
                                          ),
                                          onTap: () {
                                            Get.to(() => ChatsView(
                                                chat_id: chatDocs[index].id,
                                                // user: controller
                                                //     .receiver.value[index],
                                                client: controller
                                                    .receiver_client
                                                    .value[index]));
                                          }),
                                      Divider(height: 8, thickness: 1),
                                    ]),
                                  );
                                  // else return Center(child: CircularProgressIndicator());
                                  }
                                  );
                        });
                  }
                })));
  }
}

getProviderref(String id) {
  return FirebaseFirestore.instance.doc('Provider/' + id);
}
