import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/chatmessage.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/pages/brokers/brokerprofile.dart';
import 'package:hashching/pages/brokers/chatscreen/send_message_screen.dart';
import 'package:hashching/services/api_services.dart';

import 'package:hashching/styles/masterstyle.dart';
import 'package:image_picker/image_picker.dart';

class BrokersChat extends StatefulWidget {
  BrokersChat({Key? key, required this.consumerBrokers}) : super(key: key);
 final AllConsumerBrokers consumerBrokers;

  @override
  _BrokersChatState createState() => _BrokersChatState();
}

class _BrokersChatState extends State<BrokersChat> {
  TextEditingController chatController = TextEditingController();
  File? image;
  _handleImage(ImageSource source) async {
    var _imageFile = await ImagePicker().pickImage(source: source);
    if (_imageFile != null) {
      setState(() {
        image = File(_imageFile.path);

        //  getCroppedImage(context, _image);
      });
     senderInbox.insert(0, ChatMessageModel(image: image!, messageType: "file", message: ""));
    }
  }

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  List<ChatMessageModel> senderInbox = <ChatMessageModel>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
    backgroundColor: MasterStyle.backgroundColor,
      // appBar: appbar(context),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              appbar(context),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: senderInbox.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                  
                    return SendMessageScreen(message: senderInbox[index]);
                  },
                ),
              ),
              Container(
                color: MasterStyle.backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0, right: 0),
                        child: TextFormField(
                          style: MasterStyle.chatWhiteTextStyle,
                          controller: chatController,
                          // maxLines: 2,
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.left,
                          cursorColor: Colors.white,
                          decoration: new InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                _handleImage(ImageSource.gallery);
                              },
                              child: Container(
                                  height: 10.94,
                                  width: 22.85,
                                  margin: EdgeInsets.all(14),
                                  child: SvgPicture.asset(
                                    "assets/icons/attachement.svg",
                                    height: 10.94,
                                    width: 22.85,
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            hintStyle: MasterStyle.chatWhiteTextStyle,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MasterStyle.borderColor, width: 1),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(19.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MasterStyle.borderColor, width: 1),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(19.0),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 18.0, right: 0, top: 11, bottom: 11),
                            hintText: "Enter your message here",
                            border: new OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MasterStyle.borderColor, width: 1),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(19.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (chatController.text.trim().isEmpty) {
                        } else {
                          FocusScope.of(context).unfocus();
                          ApiServices.sendMessageToBroker(widget.consumerBrokers.brokerId, chatController.text);
                         senderInbox.insert(0, ChatMessageModel( image:"",messageType: "text", message: chatController.text));
                          chatController.clear();
                        }
                      },
                      child: Container(
                        child: SvgPicture.asset(
                          "assets/icons/chat_arrow.svg",  
                          matchTextDirection: true,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appbar(context) {
    return AppBar(
      backgroundColor: MasterStyle.secondaryColor,
      elevation: 0,
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>BrokerProfile(consumerBrokers: widget.consumerBrokers,)));
        },
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.consumerBrokers.profilePic),
                maxRadius: 22,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.consumerBrokers.firstName +
                    ' ' +
                    widget.consumerBrokers.lastName,
                style: MasterStyle.chatWhiteTextStyle
                    .merge(TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MasterStyle.whiteColor,
          )),
      actions: [
        // Container(
        //   child: SvgPicture.asset(
        //     "assets/icons/vedio_icon.svg",
        //     matchTextDirection: true,
        //     height: 32,
        //     width: 32,
        //   ),
        // ),
        InkWell(
          onTap: () {
            SimplifiedWidgets.triggerToCall(widget.consumerBrokers.mobile);
          },
          child: Container(
            // radius:15.r,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            height: 30.h,
            width: 30.w,
            margin: EdgeInsets.only(right: 15, left: 7),
            //  padding: EdgeInsets.all(10),
            child: Icon(Icons.call,
                color: MasterStyle.appSecondaryColor, size: 16),
          ),
        ),
      ],
    );
  }
}
