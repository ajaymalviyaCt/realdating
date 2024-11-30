import 'package:flutter/material.dart';

import '../function/function_class.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({super.key, required this.btnText, required this.btnFun});
  final String btnText;
  final VoidCallback btnFun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btnFun,
      style: getBtnStyle(context),
      child: Text(btnText),
    );
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      backgroundColor: Appcolor.primery,
      fixedSize: Size(MediaQuery.of(context).size.width - 35, 49),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black));
}

class SmallBut extends StatelessWidget {
  const SmallBut({super.key, required this.btText, required this.btFun});
  final String btText;
  final VoidCallback btFun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: btFun, style: getBtStyle(context), child: Text(btText));
  }

  getBtStyle(context) => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: Appcolor.primery,
      fixedSize: Size(MediaQuery.of(context).size.width - 5, 1),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Appcolor.white));
}
