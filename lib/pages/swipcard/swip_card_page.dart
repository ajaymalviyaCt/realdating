import 'package:flutter/material.dart';
import 'package:realdating/pages/swipcard/swip_controller.dart';
import 'package:realdating/pages/swipcard/tinder_card.dart';
import 'package:realdating/pages/swipcard/tinder_card_controller.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../dash_board_page.dart';

class SwipCardPage extends StatefulWidget {
  const SwipCardPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SwipCardPageState createState() => _SwipCardPageState();
}

class _SwipCardPageState extends State<SwipCardPage> {
  TinderSwipController tinderSwipController = Get.put(TinderSwipController());

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  var indexStatic;
  void rebuildPage() {
    // Perform any necessary tasks
    for (int i = 0; i < tinderSwipController.user.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(
              text: tinderSwipController.user[i].firstName!,
              color: Colors.green),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Liked ${tinderSwipController.user[i].firstName!}"),
                ],
              ),
              duration: const Duration(milliseconds: 500),
            ));

            swipController.sendNotificationOnlyMatch(
              tinderSwipController.user[indexStatic].id,
            );
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rejected ${tinderSwipController.user[i].firstName}"),
                ],
              ),
              duration: const Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              content: Text("Superliked ${tinderSwipController.user[i].firstName!}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {

            print("Region $region");
          }));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    // Use setState to trigger a rebuild
    setState(() {
      // Update your state variables here
    });
  }

  @override
  void initState() {
    super.initState();
    rebuildPage();
    tinderSwipController.getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Matches",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Stack(
          children: [
            Obx(
              () => tinderSwipController.lastIndex.value
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "No User Found !!",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                // rebuildPage();
                                // tinderSwipController.lastIndex.value=false;
                                Get.offAll(() => const DashboardPage());

                                //   Navigator.pushReplacement                         //     (context, MaterialPageRoute(builder: (context) => const DashboardPage()) );
                              },
                              child: const Icon(Icons.refresh_outlined))
                        ],
                      ),
                    )
                  : Stack(children: [
                      Container(
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 60),
                          child: SwipeCards(
                            matchEngine: _matchEngine!,
                            itemBuilder: (BuildContext context, int index) {
                              print(
                                  "firstname$index${tinderSwipController.user[index].firstName}");
                              indexStatic = index;
                              return TinderCard(
                                  user: tinderSwipController.user![index]);
                            },
                            onStackFinished: () {
                              tinderSwipController.lastIndex.value = true;
                              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              //   content: Text("Stack Finished"),
                              //   duration: Duration(milliseconds: 500),
                              // ));
                            },
                            itemChanged: (SwipeItem item, int index) {
                              print(
                                  "item: ${item.content.text}, index: $index");

                              print("newIndexxxx$indexStatic");
                            },
                            leftSwipeAllowed: true,
                            rightSwipeAllowed: true,
                            upSwipeAllowed: false,
                            fillSpace: true,

                            likeTag: Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green)),
                              child: const Text('Like'),
                            ),
                            nopeTag: Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              child: const Text('Rejected'),
                            ),
                            // superLikeTag: Container(
                            //   margin: const EdgeInsets.all(15.0),
                            //   padding: const EdgeInsets.all(3.0),
                            //   decoration: BoxDecoration(
                            //       border: Border.all(color: Colors.orange)
                            //   ),
                            //   child: Text('Super Like'),
                            // ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              swipeLeftButton(),
                              swipeRightButton2(),
                              swipeRightButton(),

                              /*   ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(200.0),
                                          side: BorderSide(color: Colors.red)))),
                              onPressed: () {
                                _matchEngine!.currentItem?.nope();
                              },
                              child: Icon(Icons.cancel)),
                          ElevatedButton(
                              onPressed: () {
                                _matchEngine!.currentItem?.superLike();
                              },
                              child: const Text("Superlike")),
                          ElevatedButton(
                              onPressed: () {
                                _matchEngine!.currentItem?.like();
                              },
                              child: const Text("Like"))*/
                            ],
                          ),
                        ),
                      )
                    ]),
            ),
            // tinderSwipController.lastIndex.value
            //     ? Align(alignment: Alignment.center, child: unswipeButton())
            //     : SizedBox(),
          ],
        ));
  }

  SwipController swipController = Get.put(SwipController());

  //swipe card to the right side
  Widget swipeRightButton() {
    return InkWell(
      onTap: () {
        _matchEngine!.currentItem?.like();
        _matchEngine!.currentItem?.content.text;
        // swipController.sendNotificationOnlyMatch(
        //   tinderSwipController.user?[indexStatic].id,
        // );

        print("fmlgrlg");
        print(indexStatic);
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.9),
              spreadRadius: -10,
              blurRadius: 20,
              offset: const Offset(0, 20), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
  Widget swipeRightButton2() {
    return InkWell(
      onTap: () {
        _matchEngine!.currentItem?.superLike();
        _matchEngine!.currentItem?.content.text;
        // swipController.sendNotificationOnlyMatch(
        //   tinderSwipController.user?[indexStatic].id,
        // );

        print("fmlgrlg");
        print(indexStatic);
      },
      child: Container(
        height: 70,
        // decoration: BoxDecoration(
        //
        //   borderRadius: BorderRadius.circular(50),
        //   boxShadow: [
        //     BoxShadow(
        //       color: const Color(0xFFFF3868).withOpacity(0.9),
        //       spreadRadius: -10,
        //       blurRadius: 20,
        //       offset: const Offset(0, 20), // changes position of shadow
        //     ),
        //   ],
        // ),
        child: Image.asset("assets/images/pramod222.png"),
       

      ),
    );
  }

//swipe card to the left side
  Widget swipeLeftButton() {
    return InkWell(
      onTap: () {
        _matchEngine!.currentItem?.nope();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFFF3868),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3868).withOpacity(0.9),
              spreadRadius: -10,
              blurRadius: 20,
              offset: const Offset(0, 20), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.close,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget unswipeButton() {
    return InkWell(
      onTap: () async {
        await tinderSwipController.getAllUser();
        setState(() {});
        // controller.unswipe();
        // swipController.SwipMatch();
        // setState((){});
        print("here=====>");
      },
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: const Icon(
          Icons.rotate_left_rounded,
          color: Colors.grey,
          size: 40,
        ),
      ),
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}
