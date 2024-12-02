import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              controller: textEditingController,maxLines: 5,
              onSubmitted: (value) {},
            ),
            TextButton(
                onPressed: () {
                  if (textEditingController.text.trim().isEmpty) {
                    Get.snackbar("title", "message");
                  }
                },
                child: Text("abc"))
          ],
        )),
      ),
    );
  }
}
