import 'package:flutter/material.dart';

import '../function/function_class.dart';

class PrimaryBtn extends StatelessWidget {
  PrimaryBtn({Key? key, required this.btnText, required this.btnFun}) : super(key: key);
  final String btnText;
  final VoidCallback btnFun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btnFun,
      child: Text(btnText),
      style: getBtnStyle(context),
    );
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      backgroundColor: Appcolor.primery,
      fixedSize: Size(MediaQuery.of(context).size.width - 35, 49),
      textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black));
}

class SmallBut extends StatelessWidget {
  SmallBut({Key? key, required this.btText, required this.btFun}) : super(key: key);
  final String btText;
  final VoidCallback btFun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: btFun, child: Text(btText), style: getBtStyle(context));
  }

  getBtStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: Appcolor.primery,
      fixedSize: Size(MediaQuery.of(context).size.width - 5, 1),
      textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Appcolor.white));
}
