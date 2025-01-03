import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/explore/exploreDetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../api/apis.dart';
import '../helper/my_date_util.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';
import 'dialogs/profile_dialog.dart';

//card to represent a single user in home screen
class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  final RxList<ExploreDetailsModel> otherUserList;

  const ChatUserCard({super.key, required this.user, required this.otherUserList});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;

  static Future<void> getuserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_uid = "${prefs.getInt('user_id')}";
    email = prefs.getInt('user_id');
    displayName = prefs.getInt('user_id');
    about = prefs.getInt('user_id');
    photoURL = prefs.getInt('user_id');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserid();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final Rxn<ExploreDetailsModel> exploreDetailsModel = Rxn(widget.otherUserList.firstWhereOrNull(
        (element) => element.userInfo[0].id.toString() == widget.user.id,
      ));
      return Card(
        margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
        // color: Colors.blue.shade100,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () {
              //for navigating to chat screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChatScreen(
                            user: widget.user,
                            exploreDetailsModel: exploreDetailsModel,
                          )));
            },
            child: StreamBuilder(
              stream: APIs.getLastMessage(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) _message = list[0];

                return ListTile(
                  //user profile picture
                  leading: InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (_) => ProfileDialog(user: widget.user));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .03),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: mq.height * .055,
                        height: mq.height * .055,
                        imageUrl: exploreDetailsModel.value?.userInfo[0].profileImage ?? "",
                        errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                  ),

                  //user name
                  title: Text("${exploreDetailsModel.value?.userInfo[0].firstName ?? ""} ${exploreDetailsModel.value?.userInfo[0].lastName ?? ""}"),

                  //last message
                  subtitle: Text(
                      _message != null
                          ? _message!.type == Type.image
                              ? 'image'
                              : _message!.msg
                          : widget.user.about,
                      maxLines: 1),

                  //last message time
                  trailing: _message == null
                      ? null //show nothing when no message is sent
                      : _message!.read.isEmpty && _message!.fromId != user_uid
                          ?
                          //show for unread message
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(color: Colors.greenAccent.shade400, borderRadius: BorderRadius.circular(10)),
                            )
                          :
                          //message sent time
                          Text(
                              MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
                              style: const TextStyle(color: Colors.black54),
                            ),
                );
              },
            )),
      );
    });
  }
}
