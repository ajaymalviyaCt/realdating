import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';
import '../HomePage/homepage.dart';
import '../constant/constant.dart';
import 'dart:math' as math;

import '../constant/heartanim.dart';

class Audience extends StatefulWidget {

  final String channelName,userId;

  const Audience({Key? key,required this.channelName,required this.userId}) : super(key: key);

  @override
  State<Audience> createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {

  late RtcEngine _engine;
  final _users=<int>[];
  final TextEditingController _controller=TextEditingController();
  late AgoraRtmClient _client;
  late AgoraRtmChannel _channel;
  List messages=["first message"];
  List names=["Muhammad"];
  List images=["image123"];
  final ScrollController _scrollController=ScrollController();
  bool heart=false;
  final _random=math.Random();
  late Timer _timer;
  double height=0.5;


  @override
  void initState(){
    super.initState();
    initializeAgora();
    _createClient();
  }
  @override
  void dispose(){
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initializeAgora() async {
    _engine=await RtcEngine.createWithContext(RtcEngineContext(appId));//goto constant.dart file
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Audience);

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel,uid,elapsed){
        if(kDebugMode) {
          print("onJoinChannel: $channel, uid: $uid");
        }
      },
      leaveChannel: (stats){
        if(kDebugMode) {
          print("channel left");
        }
        setState(() {
          _users.clear();
        });
      },
      userJoined: (uid,elapsed){
        print("UserJoined: $uid");
        setState(() {
          _users.add(uid);
        });
      },
      userOffline: (uid,elapsed){
        if(kDebugMode){
          print("Useroffline: $uid");
        }
        setState(() {
          _users.remove(uid);
        });
      },
    ));
    await _engine.joinChannel(null,widget.channelName, null, 0);
  }
  void _onScrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn
    );
  }
  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          _broadcastView(),
          leaveChannelText(),
          (names.isEmpty)?Container():Container(
            width: w,
            height: h*0.5,
            margin: EdgeInsets.only(top: h*0.5,bottom: h*0.09),
            child: ListView.builder(
                itemCount: names.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(images[index]),
                    ),
                    subtitle: Text(messages[index]),
                    title: Text(names[index]),
                  );
                }),
          ),
          sendTextfield(),
          if(heart==true)Container(
            width: w,
            height: h*0.5,
            margin: EdgeInsets.only(top: h*0.55,left: w*0.65),
            child: Column(
              children: heartPop(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getRenderViews()
  {
    final List<StatefulWidget> list=[];
    for(var uid in _users){
      list.add(RtcRemoteView.SurfaceView(uid: uid,channelId: widget.channelName,));
    }
    return list;
  }
  Widget _broadcastView(){

    final views=_getRenderViews();
    switch(views.length){
      case 1:
        return Column(
          children: [
            _expandedView([views[0]]),
          ],
        );
      case 2:
        return Column(
          children: [
            _expandedView([views[0]]),
            _expandedView([views[1]]),
          ],
        );
      case 3:
        return Column(
          children: [
            _expandedView(views.sublist(0,2)),
            _expandedView(views.sublist(2,3)),
          ],
        );
      case 4:
        return Column(
          children: [
            _expandedView(views.sublist(0,2)),
            _expandedView(views.sublist(2,4)),
          ],
        );
      default:
        return Container();
    }
  }
  Widget _expandedView(List<Widget> views)
  {
    final wrappedView=views.map((view) => Expanded(child: Container(child: view,))).toList();
    return Expanded(child: Row(
      children: wrappedView,
    ));
  }
  Widget leaveChannelText(){
    return InkWell(
      onTap: ()
      {
        _onCallEnd();
      },
      child: Container(
        margin:const EdgeInsets.only(left: 10,top: 20),
        padding:const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.redAccent
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent
        ),
        child:const Text("leave",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
      ),
    );
  }
  void _onCallEnd(){
    _engine.leaveChannel().then((value) {
      Get.to(()=>const HomePage());
    });
  }
Widget sendTextfield(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.75,
            child: TextField(
              controller: _controller,
              style:const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: (){
                  String imgLink="https://firebasestorage.googleapis.com/v0/b/mooapp-a42ca.appspot.com/o/fjfjfk%40dhd.ru%2Fscaled_image_picker5405006539245286241.jpg%2F5vJvQlPKyXf1Uk0dUahffY00u8t1%2F%22profile%22?alt=media&token=ec9870c6-91bd-484d-b037-b026634083be";
                  String msg="${_controller.text.trim()}passWORD123$imgLink";
                  _sendMessage(msg);
                }, icon: const Icon(Icons.send_rounded,color: Colors.blueAccent,)),
                hintText: "Comment",
                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent),
                ),
              ),

            ),
          ),
          MaterialButton(
            onPressed: ()async{
              await _channel.sendMessage(AgoraRtmMessage.fromText("a1w3e3rt4YRTY"));
              popUp();
          },
          child: const Icon(
            Icons.favorite,
            color: Colors.lightBlueAccent,
            size: 30,
          ),
          )
        ],
      ),
    );
}
void _sendMessage(text)async{
    if(kDebugMode){
      print(text);
    }
    String img=text.split("passWORD123").last;
    String msg=text.split("passWORD123").first;
   try
       {
         setState(() {
           names.add(widget.userId);
           messages.add(msg);
           images.add(img);
         });
         _onScrollDown();
         await _channel.sendMessage(AgoraRtmMessage.fromText(text));
         _controller.clear();
       }catch(e){
      print("Error ${e.toString()}");
   }
}
  void _createClient() async{
    _client= await AgoraRtmClient.createInstance(appId);
    _client.onConnectionStateChanged=(int state,int reason){
      if(state==5){
        _client.logout();
      }
    };
    await _client.login(null, widget.userId);
    _channel=await _createChannel(widget.channelName);
    await _channel.join();
    if(kDebugMode){
      print("RTM Channel joined successfully by: ${widget.channelName}#");
    }
    _channel.onMessageReceived=(AgoraRtmMessage message,AgoraRtmMember member){

      if(message.text.contains("a1w3e3rt4YRTY"))
        {
          popUp();
        }
      else {
        String img = message.text
            .split("passWORD123")
            .last;
        String msg = message.text
            .split("passWORD123")
            .first;
        setState(() {
          names.add(member.userId);
          messages.add(msg);
          images.add(img);
        });
        _onScrollDown();
        if(kDebugMode){
          print("Message received: $msg");
        }
      }

    };
  }
  Future<AgoraRtmChannel> _createChannel(String channelName) async{
    AgoraRtmChannel? channel=await _client.createChannel(channelName);
    channel!.onMemberJoined=(AgoraRtmMember member){
      if(kDebugMode){
        print("Member joined: ${member.userId}");
      }
    };
    channel.onMemberLeft=(AgoraRtmMember member){
      if(kDebugMode){
        print("Member left: ${member.userId}");
      }
    };
    return channel;
  }
  void  popUp(){
    setState(() {
      heart=true;
    });
    Timer(const Duration(seconds: 3),()=>
    {
      _timer.cancel(),
      setState(() {
        heart = false;
      })
    });
    _timer=Timer.periodic(const Duration(milliseconds: 125), (Timer t) {
      setState(() {
        height+=_random.nextInt(20);
      });
    });
  }
  List<Widget> heartPop(){
    final size=MediaQuery.of(context).size;
    final hearts=<Widget>[];
    for(int i=0;i<10;i++){
      final h=_random.nextInt(size.height.floor());
      final w=_random.nextInt(70)+20;
      hearts.add(HeartAnim(top: h%200.0,left:w.toDouble(),opacity: 0.5,));
    }
    return hearts;
  }
}
