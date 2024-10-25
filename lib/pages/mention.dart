import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:realdating/pages/createPostUser/mention/getFriendModel.dart';
import 'package:get/get.dart';

import '../function/function_class.dart';
import 'createPostUser/createUserPost.dart';
import 'homepage/userHomeController.dart';

class mention extends StatefulWidget {


  @override
  _mentionState createState() => _mentionState();
}

class _mentionState extends State<mention> {
  List<String> availableData = [
    '@john_doe',
    '@jane_doe',
    '@user123',
    '@flutter_dev',
    '@developer_xyz'
  ];

  List<MyFriends> filteredList = [];
  UserHomeController userHomeController = Get.put(UserHomeController());

  @override
  void initState() {
    filteredList = userHomeController.userFriend;
    super.initState();
    userHomeController.getMyFriendsPost();
  }



  var holder_1 = [];



    List<MyFriends>? myFriends;

  final List<String> myList = [];
  final List<String> myListId = [];
    String selectedTag = "";

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          title: const Text(
            'Tag People',
            style: CustomTextStyle.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: IconButton(
                onPressed: () {
                  // Get.to(() => UserCreatePost();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserCreatePost(),
                    ),
                  );
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserCreatePost(dataP: MyData(myList,myListId)),
                  ));*/
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => UserCreatePost(dataP: MyData(myList,myListId)),
                  //   ),
                  // );

                  // uploadFileToServerUHome();
                },
                icon: Text("Add", style: TextStyle(fontWeight: FontWeight.w600,
                    color: Colors.red,
                    fontSize: 16),),
              ),
            ),

            // SvgPicture.asset('assets/icons/Share.svg'),
            SizedBox(width: 20)
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TypeAheadField<MyFriends>(
                // key: GlobalKey(),
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: selectedTag.isNotEmpty
                        ? selectedTag
                        : "Tag People..",
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return userHomeController.userFriend.
                  where((userFriend) =>
                      userFriend.friendFirstName!.toLowerCase().
                      contains(pattern.toLowerCase()));

                  /*      return userList.where((user) =>
                      user.name.toLowerCase().contains(pattern.toLowerCase()));*/

                  /*     List<MyFriends>? myFriends = userList
                      .where((user) => user.name.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();*/
                },

                itemBuilder: (context, MyFriends? suggestion) {
                  return ListTile(
                    title: Text(suggestion?.friendFirstName ?? ""),
                  );
                },
                onSuggestionSelected: (MyFriends? suggestion) {
                  // Replace the current text with the selected suggestion
                  // Add your logic to handle the selected user
                  setState(() =>
                  selectedTag = suggestion!.friendFirstName.toString());
                  myList.add(selectedTag);
                  myListId.add(suggestion?.friendId.toString()??"1");
                  print(selectedTag);

                  print(
                      'Selected user: ${suggestion?.friendFirstName
                          .toString()}');
                },
              ),
            ),
            // Expanded(
            //   child: GridView.builder(
            //     itemCount: userHomeController.userFriend.length,
            //       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //           maxCrossAxisExtent: 3), itemBuilder: (ctx, i){
            //         return Container(child:  Text(  "#$selectedTag",
            //           style: TextStyle(fontWeight: FontWeight.w500,
            //               color: Colors.blue,
            //               fontSize: 15),),);
            //   }),
            // ),

            Container(
              height: 150,
              child: ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  print("jfkrejgirotugoi");
                  print(myList);
                  return ListTile(
                    title: Text("@${
                        myList == null
                            ? "NO Tag"
                            : myList[index]
                    }",style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),),
                    // subtitle: Text(widget.dataP.parameter2[index]),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

class MyData {
  final List<String> parameter1;
  final List<String> parameter2;

  MyData(this.parameter1, this.parameter2);
}