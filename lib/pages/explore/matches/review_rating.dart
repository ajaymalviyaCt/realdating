import 'dart:async';

// import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:realdating/chat/api/apis.dart';
import 'package:realdating/services/base_client01.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../consts/app_urls.dart';


class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  var comment, ratingcount = null;

  TextEditingController txt_comment = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getUserId();
  }


  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? user_id = prefs.getString('user_id');
    print('user id here1----- $user_id');
    print('user id here-2---- $user_uid');
  }

  @override
  void dispose() {
   // _connectivitySubscription?.cancel();
    super.dispose();
  }

  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException {
  //     return;
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }

  void uploadFileToServerInfluencer() async {



    final response = await BaseClient01().post(Appurls.review,{
      "review": txt_comment.text.toString(),
      "rating_star": ratingcount.toString(),
      "user_id": "${user_uid}"
    });
   // isLoadig(false);
    bool status= response["success"];
    if(status == true){
      //Get.to(()=> DashboardPage());
    }
    // print("??????????????${request.fields.toString()}");
    // request.send().then((response) {
    //   http.Response.fromStream(response).then((onValue) async {
    //     try {
    //       Navigator.pop(context);
    //
    //       print("response.statusCod");
    //
    //       print(onValue.body);
    //       // _future = myprofile();
    //       //Rahul
    //       //  _willPopCallback();
    //       Fluttertoast.showToast(
    //           msg: "add comment successfully",
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           backgroundColor: Colors.black,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //     } catch (e) {
    //       Fluttertoast.showToast(
    //           msg: "Something went wrong....",
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           backgroundColor: const Color(0xffC83760),
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //       // handle exeption
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Login',
                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: SizedBox(
                                height: 210,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Review',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.98,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 30,
                                        initialRating: 0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding:
                                        const EdgeInsets.symmetric(horizontal: 3.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          ratingcount = rating;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: txt_comment,
                                        decoration: const InputDecoration(
                                            hintText: 'Add Comment'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        // width: 200,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); //close Dialog
                                                    },
                                                    child: const Text("Cancel",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.black))),
                                                TextButton(
                                                    onPressed: () {
                                                      if (formKey.currentState!.validate()) {
                                                        uploadFileToServerInfluencer();
                                                      }
                                                     // uploadFileToServerInfluencer();
                                                    },
                                                    child: const Text("Save",
                                                        style: TextStyle(
                                                            color: Colors.black)))
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
            ]),
          ),

        )





      ),
    );
  }
}
