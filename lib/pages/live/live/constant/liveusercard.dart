import 'package:flutter/material.dart';

class LiveUserCard extends StatelessWidget {

  final String image,broadcasterName;

  const LiveUserCard({Key? key,required this.image,required this.broadcasterName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.fromLTRB(2, 5,2,5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 0),
            )
          ]
        ),
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                  image: NetworkImage(image),
                  fit: BoxFit.fill
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5,top: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 10,right: 20),
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent,
                      ),
                      child: const Center(
                        child: Text("Live"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top:165 ),
                child: Text("  $broadcasterName",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))

          ],
        ),
      ),
    );
  }
}
