import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../consts/app_colors.dart';
import 'custom_text_styles.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({Key? key, required this.btnText, required this.btnFun, this.btnclr, this.btntextclr, this.btnHW, this.loading}) : super(key: key);
  final String btnText;
  final VoidCallback btnFun;
  final Color? btnclr;
  final Color? btntextclr;
  final Size? btnHW;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return loading ?? false
        ? ElevatedButton(
            onPressed: () {},
            style: getBtnStyle(context),
            child: CircularProgressIndicator(color: colors.white),
          )
        : ElevatedButton(
            onPressed: btnFun,
            style: getBtnStyle(context),
            child: textMedium("$btnText", context, 16),
          );
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
        side: BorderSide(
          width: .7,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        backgroundColor: btnclr ?? colors.primary,
        fixedSize: btnHW ?? Size(239.w, 56.h),
      );
}

class PrimaryBtn2 extends StatelessWidget {
  const PrimaryBtn2({Key? key, required this.btnText, required this.btnFun, this.btnclr, this.btntextclr, this.btnHW, this.loading}) : super(key: key);
  final String btnText;
  final VoidCallback btnFun;
  final Color? btnclr;
  final Color? btntextclr;
  final Size? btnHW;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return loading ?? false
        ? Container(
            decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(13)),
            width: MediaQuery.of(context).size.width,
            height: 56.h,
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )))
        : ElevatedButton(
            onPressed: btnFun,
            style: getBtnStyle(context),
            child: textBold(
              "$btnText",
              context,
              14.sp,
              Colors.black,
            ),
          );
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
        side: BorderSide(
          width: .7,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(13), bottomRight: Radius.circular(13)),
        ),
        backgroundColor: btnclr ?? colors.white,
        fixedSize: btnHW ?? Size(200.w, 56.h),
      );
}

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  CustomElevatedButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        gradient: LinearGradient(
          colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class customPrimaryBtn2 extends StatelessWidget {
  const customPrimaryBtn2({Key? key, required this.btnText, required this.btnFun, this.btnclr, this.btntextclr, this.btnHW, this.loading}) : super(key: key);
  final String btnText;
  final VoidCallback btnFun;
  final Color? btnclr;
  final Color? btntextclr;
  final Size? btnHW;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return loading ?? false
        ? ElevatedButton(
            onPressed: btnFun,
            style: getBtnStyle(context),
            child: customTextCommon(
              text: '$btnText',
              fSize: 17,
              fWeight: FontWeight.w600,
              lineHeight: 17,
            ),
          )
        : ElevatedButton(
            onPressed: btnFun,
            style: getBtnStyle(context),
            child: customTextCommon(
              text: '$btnText',
              fSize: 17,
              fWeight: FontWeight.w600,
              lineHeight: 17,
            ),
          );
  }

  getBtnStyle(context) => ElevatedButton.styleFrom(
        side: BorderSide(
          width: .7,
          color: colors.primary,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(30),
        )),
        backgroundColor: btnclr ?? colors.primary,
        fixedSize: btnHW ?? Size(200.w, 56.h),
      );
}

class customPrimaryBtn extends StatelessWidget {
  const customPrimaryBtn({Key? key, required this.btnText, required this.btnFun, this.btnclr, this.btntextclr, this.width, this.height, this.loading})
      : super(key: key);

  final String btnText;
  final VoidCallback btnFun;
  final Color? btnclr;
  final Color? btntextclr;
  final double? width;
  final double? height;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return loading ?? false
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0)],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    btnclr ?? Color(0xffF65F51),
                    btnclr ?? Color(0xffFB4967),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(width ?? MediaQuery.of(context).size.width, height ?? 56)),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                // onPressed: btnFun,
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    btnclr ?? Color(0xffF65F51),
                    btnclr ?? Color(0xffFB4967),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(width ?? 350, height ?? 56)),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: btnFun,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    btnText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: btntextclr ?? Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class customPrimaryBtnBlk extends StatelessWidget {
  const customPrimaryBtnBlk({Key? key, required this.btnText, required this.btnFun, this.btnclr, this.btntextclr, this.width, this.height, this.loading})
      : super(key: key);

  final String btnText;
  final VoidCallback btnFun;
  final Color? btnclr;
  final Color? btntextclr;
  final double? width;
  final double? height;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return loading ?? false
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0)],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    btnclr ?? Color(0xff000000),
                    btnclr ?? Color(0xff000000),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(width ?? MediaQuery.of(context).size.width, height ?? 56)),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                // onPressed: btnFun,
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    btnclr ?? Color(0xff000000),
                    btnclr ?? Color(0xff000000),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(width ?? 350, height ?? 56)),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: btnFun,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    btnText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: btntextclr ?? Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
