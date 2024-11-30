import 'package:flutter/material.dart';
import 'package:realdating/pages/swipcard/tinder_card_model.dart';

import '../discovery/discoveryModel.dart';

class TinderCard extends StatefulWidget {
  final MyFriendSwipe user;

  const TinderCard({super.key, required this.user});

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  Widget build(BuildContext context) => buildCard();

  Widget buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(widget.user.profileImage.toString()),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.transparent, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.7, 1])),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  height: 8,
                ),
                buildName(),
                // SizedBox(height: 8,),
                // buildSatus()
              ],
            ),
          ),
        ),
      );

  Widget buildName() {
    return Row(
      children: [
        Text(
          "${widget.user.firstName} ${widget.user.lastName} ,${widget.user.age}",
          style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 16,
        ),
        // Text(widget.user.age.toString(),
        //   style: TextStyle(
        //       fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
        // ),
      ],
    ); // Widget buildSatus(){
    //   return Row(
    //     children: [
    //       const Text("",style: TextStyle(color: Colors.white),),
    //     ],
    //   );
    // }
  }
}

//
//
// import 'package:flutter/material.dart';
//
// class TinderCard extends StatefulWidget {
//   final User user ;
//   const TinderCard({super.key,required this.user});
//
//   @override
//   State<TinderCard> createState() => _TinderCardState();
// }
//
// class _TinderCardState extends State<TinderCard> {
//   @override
//   Widget build(BuildContext context) => ClipRRect(
//     borderRadius: BorderRadius.circular(20),
//     child: Container(
//       decoration: BoxDecoration(
//         image :   DecorationImage(
//           image: NetworkImage(widget.user.urlImage,),
//           fit: BoxFit.cover,
//           // alignment: Alignment(-0.3,0)
//         ),
//       ),
//       child: Container(
//         decoration:  BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(20),
//
//             gradient: LinearGradient(
//                 colors: [Colors.transparent,Colors.black],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0.7,1]
//             )
//         ),
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Spacer(),
//             SizedBox(height: 8,),
//             buildName(),
//             SizedBox(height: 8,),
//             buildSatus()
//           ],
//         ),
//       ),
//     ),
//   );
//
//
//
//
//   Widget buildCard()=> ClipRRect(
//     borderRadius: BorderRadius.circular(20),
//
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         image :   DecorationImage(
//           invertColors: true,
//           image: NetworkImage(widget.user.urlImage),
//           fit: BoxFit.cover,
//
//           // alignment: Alignment(-0.3,0)
//         ),
//       ),
//       child: Container(
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [Colors.transparent,Colors.black],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0.7,1]
//             )
//         ),
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Spacer(),
//             SizedBox(height: 8,),
//             buildName(),
//             SizedBox(height: 8,),
//             buildSatus()
//           ],
//         ),
//       ),
//     ),
//   );
//   Widget buildName(){
//     return Row(
//       children: [
//         Text(widget.user.name,
//           style: TextStyle(
//               fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
//         ),
//         SizedBox(width: 16,),
//         Text(widget.user.age,
//           style: TextStyle(
//               fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
//         ),
//
//
//       ],
//     );
//   }
//   Widget buildSatus(){
//     return Row(
//       children: [
//         const Text("resent",style: TextStyle(color: Colors.white),),
//       ],
//     );
//   }
//
//
// }
// class User{
//   final String name;
//   final String age;
//   final String urlImage;
//
//   const User({
//     required  this.name,
//     required  this.age,
//     required  this.urlImage,
//   });
//
// }
