import 'package:flutter_svg/flutter_svg.dart';
import 'package:realdating/Choose_subscription_plan/spark.dart';
import 'package:realdating/reel/common_import.dart';
import 'package:realdating/widgets/size_utils.dart';

class Monthly extends StatefulWidget {
  const Monthly({super.key});

  @override
  State<Monthly> createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  bool Switch = true;
  int taps = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F0),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: ListView(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      'assets/images/crrros.svg',
                      height: 30.ah,
                      width: 30.ah,
                    ))),
            SizedBox(height: 15.ah),
            SvgPicture.asset(
              'assets/images/real_reveal.svg',
            ),
            SvgPicture.asset(
              "assets/images/daimond.svg",
              height: 100,
            ),
            SizedBox(height: 15.ah),
            Container(
              child: Switch
                  ? Column(
                      children: [
                        Container(
                          //width: MediaQuery.of(context).size.width,
                          width: 289.5.aw,
                          height: 40.ah,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26.5),
                            border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 140.aw,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF65F51),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Monthly',
                                    style: TextStyle(
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    print('false_yearly');
                                    Switch = false;
                                  });
                                },
                                child: Container(
                                  width: 140.aw,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Yearly',
                                      style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500, fontFamily: 'Roboto', color: Colors.black, height: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.ah),
                        Text(
                          'Choose subscription plan',
                          style: TextStyle(
                            fontSize: 14.fSize,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15.ah),
                        Container(
                          //width: MediaQuery.of(context).size.width,
                          width: 328.aw,
                          height: 106.ah,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9505F).withOpacity(0.21),
                            borderRadius: BorderRadius.circular(26.5),
                            border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 280.8.aw,
                                height: 40.ah,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Standard',
                                        style: TextStyle(
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFFE20A00),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '\$9.99/month',
                                        style: TextStyle(
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.ah),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '* ',
                                      style: TextStyle(
                                        fontSize: 14.fSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '25 set number of Real Reveals per month',
                                      style: TextStyle(
                                        fontSize: 13.fSize,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25.ah),
                        Container(
                          //width: MediaQuery.of(context).size.width,
                          width: 328.aw,
                          height: 200.ah,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26.5),
                            border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 33, right: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 15.ah),
                                Container(
                                  width: 279.aw,
                                  height: 40.ah,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F3F3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Premium',
                                          style: TextStyle(
                                            fontSize: 14.fSize,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Roboto',
                                            color: const Color(0xFFE20A00),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '\$19.99/month',
                                          style: TextStyle(
                                            fontSize: 14.fSize,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Roboto',
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.ah),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '* ',
                                        style: TextStyle(
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Unlimited Real Reveals per month',
                                      style: TextStyle(
                                        fontSize: 13.fSize,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '* ',
                                      style: TextStyle(
                                        fontSize: 14.fSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                    Text(
                                      'Ad-free experience',
                                      style: TextStyle(
                                        fontSize: 13.fSize,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '* ',
                                        style: TextStyle(
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Priority customer support',
                                        style: TextStyle(
                                          fontSize: 13.fSize,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '* ',
                                        style: TextStyle(
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Exclusive access to new features or events',
                                        style: TextStyle(
                                          fontSize: 13.fSize,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.ah),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SparkScreen()));
                          },
                          child: Container(
                            width: 106.8.aw,
                            height: 32.ah,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF65F51),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                            ),
                            child: Center(
                              child: Text(
                                'Go to Sparks',
                                style: TextStyle(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.ah),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45.ah,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF65F51),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 17.fSize,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(children: [
                      Container(
                        width: 289.5.aw,
                        height: 40.ah,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.5),
                          border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  print('true_Monthly');
                                  Switch = true;
                                });
                              },
                              child: Container(
                                width: 140.8.aw,
                                decoration: BoxDecoration(
                                  //color:Color(0xFFF65F51),
                                  borderRadius: BorderRadius.circular(24),
                                  // border: Border.all(width: 2,color:Color(0xFFF65F51)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Monthly',
                                    style: TextStyle(
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 144.aw,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF65F51),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                              ),
                              child: Center(
                                child: Text(
                                  'Yearly',
                                  style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500, fontFamily: 'Roboto', color: Colors.white, height: 1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.ah),
                      Text(
                        'Choose subscription plan',
                        style: TextStyle(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 15.ah),
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        width: 328.aw,
                        height: 106.ah,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9505F).withOpacity(0.21),
                          borderRadius: BorderRadius.circular(26.5),
                          border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 280.8.aw,
                              height: 40.ah,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Standard',
                                      style: TextStyle(
                                        fontSize: 14.fSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFFE20A00),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$9.99/month',
                                          style: TextStyle(
                                            fontSize: 14.fSize,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Roboto',
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                        SizedBox(width: 3.aw),
                                        Text(
                                          '(16%off)',
                                          style: TextStyle(
                                            fontSize: 9.fSize,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.ah),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    '* ',
                                    style: TextStyle(
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '25 set number of Real Reveals per month',
                                    style: TextStyle(
                                      fontSize: 13.fSize,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.ah),
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        width: 328.aw,
                        height: 200.ah,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.5),
                          border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 33, right: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 15.ah),
                              Container(
                                width: 279.aw,
                                height: 40.ah,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F3F3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Premium',
                                        style: TextStyle(
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          color: const Color(0xFFE20A00),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '\$180.99/month',
                                            style: TextStyle(
                                              fontSize: 14.fSize,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Roboto',
                                              color: const Color(0xFF000000),
                                            ),
                                          ),
                                          SizedBox(width: 3.aw),
                                          Text(
                                            '(16%off)',
                                            style: TextStyle(
                                              fontSize: 9.fSize,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.ah),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '* ',
                                      style: TextStyle(
                                        fontSize: 14.fSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Unlimited Real Reveals per month',
                                    style: TextStyle(
                                      fontSize: 13.fSize,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '* ',
                                    style: TextStyle(
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                  Text(
                                    'Ad-free experience',
                                    style: TextStyle(
                                      fontSize: 13.fSize,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '* ',
                                      style: TextStyle(
                                        fontSize: 14.fSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Priority customer support',
                                      style: TextStyle(
                                        fontSize: 13.fSize,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '* ',
                                      style: TextStyle(
                                        fontSize: 14.fSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Exclusive access to new features or events',
                                      style: TextStyle(
                                        fontSize: 13.fSize,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.ah),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SparkScreen()));
                        },
                        child: Container(
                          width: 106.8.aw,
                          height: 42.ah,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF65F51),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                          ),
                          child: Center(
                            child: Text(
                              'Go to Sparks',
                              style: TextStyle(
                                fontSize: 14.fSize,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.ah),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45.ah,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF65F51),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(width: 2, color: const Color(0xFFF65F51)),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 17.fSize,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
            ),
          ],
        ),
      ),
    );
  }
}
