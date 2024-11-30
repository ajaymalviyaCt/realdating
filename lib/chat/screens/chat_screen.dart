import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/explore/exploreDetailsModel.dart';
import 'package:realdating/widgets/emoji_picker.dart';

import '../../main.dart';
import '../../services/date_time_services.dart';
import '../api/apis.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  final Rxn<ExploreDetailsModel> exploreDetailsModel;

  const ChatScreen({super.key, required this.user, required this.exploreDetailsModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];

  final _textController = TextEditingController();

  final bool _isUploading = false;
  final RxBool _showEmoji = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji.value) {
              setState(() => _showEmoji.value = !_showEmoji.value);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            //app bar
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
            ),

            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMessages(widget.user),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(top: mq.height * .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  print("line 80");
                                  print(index);
                                  Message? previousMessageModel;
                                  try {
                                    previousMessageModel = messageModel(index + 1);
                                  } catch (e) {}
                                  return Column(
                                    children: [
                                      Builder(builder: (context) {
                                        try {
                                          return SizedBox(
                                            child: (previousMessageModel != null)
                                                ? DateTimeServices.isSameDate(
                                                        date1: DateTimeServices.convertMillisecondsToLocalizedDateTime(int.parse(messageModel(index).sent))
                                                            .dateTime!,
                                                        date2: DateTimeServices.convertMillisecondsToLocalizedDateTime(int.parse(previousMessageModel.sent))
                                                            .dateTime!)
                                                    ? const SizedBox.shrink()
                                                    : messageDateStickyHeader(messageModel(index))
                                                : messageDateStickyHeader(messageModel(index)),
                                          );
                                        } catch (e) {
                                          return const SizedBox();
                                        }
                                      }),
                                      MessageCard(message: messageModel(index)),
                                    ],
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text('Say Hii! 👋', style: TextStyle(fontSize: 20)),
                            );
                          }
                      }
                    },
                  ),
                ),
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), child: CircularProgressIndicator(strokeWidth: 2))),
                _chatInput(),
                Obx(() {
                  if (_showEmoji.value == false) {
                    return const SizedBox.shrink();
                  }
                  return EmojiPickerWidget(
                    textEditingController: _textController,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Message messageModel(int index) => _list[index];

  // app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => ViewProfileScreen(user: widget.user)));
        },
        child: StreamBuilder(
            stream: APIs.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;

              print('user data--------------$data');
              final list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              return Row(
                children: [
                  //back button
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.black54)),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: mq.height * .05,
                      height: mq.height * .05,
                      imageUrl: widget.exploreDetailsModel.value?.userInfo[0].profileImage ?? "",
                      errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  //for adding some space
                  const SizedBox(width: 10),

                  //user name & last seen time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text("${widget.exploreDetailsModel.value?.userInfo[0].firstName ?? ""} ${widget.exploreDetailsModel.value?.userInfo[0].lastName ?? ""}",
                          style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              );
            }));
  }

/*  // bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //pick image from gallery button
                  // IconButton(
                  //     onPressed: () async {
                  //       final ImagePicker picker = ImagePicker();
                  //
                  //       // Picking multiple images
                  //       final List<XFile> images =
                  //           await picker.pickMultiImage(imageQuality: 70);
                  //
                  //       // uploading & sending image one by one
                  //       for (var i in images) {
                  //         log('Image Path: ${i.path}');
                  //         setState(() => _isUploading = true);
                  //         await APIs.sendChatImage(widget.user, File(i.path));
                  //         setState(() => _isUploading = false);
                  //       }
                  //     },
                  //     icon: const Icon(Icons.image,
                  //         color: Colors.blueAccent, size: 26)),

                  //take image from camera button


                  // IconButton(
                  //     onPressed: () async {
                  //       final ImagePicker picker = ImagePicker();
                  //
                  //       // Pick an image
                  //       final XFile? image = await picker.pickImage(
                  //           source: ImageSource.camera, imageQuality: 70);
                  //       if (image != null) {
                  //         log('Image Path: ${image.path}');
                  //         setState(() => _isUploading = true);
                  //
                  //         await APIs.sendChatImage(
                  //             widget.user, File(image.path));
                  //         setState(() => _isUploading = false);
                  //       }
                  //     },
                  //     icon: const Icon(Icons.camera_alt_rounded,
                  //         color: Colors.blueAccent, size: 26)),

                  //adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                if (_list.isEmpty) {
                  //on first message (add user to my_user collection of chat user)
                  APIs.sendFirstMessage(
                      widget.user, _textController.text, Type.text);
                } else {
                  //simply send message
                  APIs.sendMessage(
                      widget.user, _textController.text, Type.text);
                }
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }*/

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // Emoji button
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() => _showEmoji.value = !_showEmoji.value);
                    },
                    icon: const Icon(Icons.emoji_emotions, color: Colors.blueAccent, size: 25),
                  ),

                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (value) {
                        // Remove leading spaces
                        if (value.startsWith(' ')) {
                          _textController.text = value.trimLeft();
                          _textController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _textController.text.length),
                          );
                        }

                        // Remove emojis or unwanted characters
                        // String filteredText = value.replaceAll(
                        //     RegExp(
                        //         r'[^\w\s.,!?@#\$%^&*()\-+=<>:;"\[\]{}|~`/\\]'),
                        //     '');
                        // if (value != filteredText) {
                        //   _textController.text = filteredText;
                        //   _textController.selection =
                        //       TextSelection.fromPosition(
                        //         TextPosition(
                        //             offset: _textController.text.length),
                        //       );
                        // }
                      },
                      onTap: () {
                        if (_showEmoji.value) setState(() => _showEmoji.value = !_showEmoji.value);
                      },
                      decoration:
                          const InputDecoration(hintText: 'Type Something...', hintStyle: TextStyle(color: Colors.blueAccent), border: InputBorder.none),
                    ),
                  ),

                  // Adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),

          // Send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                if (_list.isEmpty) {
                  APIs.sendFirstMessage(widget.user, _textController.text.trim(), Type.text);
                } else {
                  APIs.sendMessage(widget.user, _textController.text.trim(), Type.text);
                }
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}

Widget messageDateStickyHeader(Message messageModel) {
  try {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        DateTimeServices.getRelativeDayNameWithinPast7Days(DateTimeServices.convertMillisecondsToLocalizedDateTime(int.parse(messageModel.sent)).dateTime!) ??
            DateTimeServices.convertMillisecondsToLocalizedDateTime(int.parse(messageModel.sent)).date!,
        // style: ,
      ),
    );
  } catch (e) {
    return const SizedBox.shrink();
  }
}
