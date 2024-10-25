import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StyledSwitch extends StatefulWidget {
  final void Function(bool isToggled) onToggled;
  AlignmentGeometry alignment;
  Color? toggleColor;
   StyledSwitch({Key? key, required this.onToggled,required this.alignment,this.toggleColor}) : super(key: key);

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool isToggled = true;
  double size = 30;
  double innerPadding = 0;
  Color? toggleColor;

var alignment;
  @override
  void initState() {
    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      child: AnimatedContainer(
        height: size,
        width: size * 2,
        padding: EdgeInsets.all(innerPadding),
        alignment: alignment,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // color: isToggled==true ? HexColor('#AAAAAA') : HexColor('#FB4967'),
          color: toggleColor
        ),
        child: Container(
          width: size - innerPadding * 2,
          height: size - innerPadding * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isToggled ? Colors.grey.shade600 : HexColor('#FFFFFF'),
          ),
        ),
      ),
    );
  }
}
