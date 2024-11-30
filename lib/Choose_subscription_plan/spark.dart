import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/widgets/size_utils.dart';

class SparkScreen extends StatefulWidget {
  const SparkScreen({super.key});

  @override
  State<SparkScreen> createState() => _SparkScreenState();
}

class _SparkScreenState extends State<SparkScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F0),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
        child: ListView(
          children: [
            SizedBox(height: 30.ah),
            Center(
              child: Text(
                'Choose your need of extra -',
                style: TextStyle(
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  color: Color(0xFFF9505F),
                ),
              ),
            ),
            SizedBox(height: 20.ah),
            SvgPicture.asset(
              'assets/images/real_reveal.svg',
            ),
            SizedBox(height: 15.ah),
            SvgPicture.asset(
              "assets/images/daimond.svg",
              height: 120,
            ),
            SizedBox(height: 15.ah),
            selected == 1
                ? InkWell(
                    onTap: () {
                      selected = 1;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9505F).withOpacity(0.21),
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Color(0xFFF65F51)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '1 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$5',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      selected = 1;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '1 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$5',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 15.ah),
            selected == 2
                ? InkWell(
                    onTap: () {
                      selected = 2;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9505F).withOpacity(0.21),
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Color(0xFFF65F51)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '3 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$15',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      selected = 2;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '3 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$15',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 15.ah),
            selected == 3
                ? InkWell(
                    onTap: () {
                      selected = 3;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9505F).withOpacity(0.21),
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Color(0xFFF65F51)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '5 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$25',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      selected = 3;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '5 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$25',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 15.ah),
            selected == 4
                ? InkWell(
                    onTap: () {
                      selected = 2;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9505F).withOpacity(0.21),
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Color(0xFFF65F51)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '10 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$50',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      selected = 4;
                      setState(() {});
                    },
                    child: Container(
                      //width: MediaQuery.of(context).size.width,
                      width: 328.aw,
                      height: 90.ah,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.5),
                        border: Border.all(width: 2, color: Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                                  '10 Real Reveal',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFE20A00),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '\$50',
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 30.ah),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'Payment feature coming soon...');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45.ah,
                decoration: BoxDecoration(
                  color: Color(0xFFF65F51),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(width: 2, color: Color(0xFFF65F51)),
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
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: const Color(0xFFFFF0F0),
    //   body: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               InkWell(
    //                   onTap: () {
    //                     Navigator.pop(context);
    //                   },
    //                   child: SvgPicture.asset('assets/images/crrros.svg',height: 30.ah,width: 30.ah,)
    //               )
    //             ],
    //           ),
    //
    //           SizedBox(height: 15.ah),
    //           Center(
    //             child: Text('Spark',
    //               style: TextStyle(fontSize: 50.fSize,fontWeight: FontWeight.w400,
    //                 fontFamily: 'Kaushan Script',color: const Color(0xFFF94F60),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 15.ah),
    //           Image.asset('assets/images/teenstar.png',height:80.ah,width:80.aw,fit: BoxFit.fill,),
    //           SizedBox(height:30.ah),
    //           Container(
    //             //width: MediaQuery.of(context).size.width,
    //             width: 328.aw,
    //             height: 106.ah,
    //             decoration: BoxDecoration(
    //               color: const Color(0xFFF9505F).withOpacity(0.21),
    //               borderRadius: BorderRadius.circular(26.5),
    //               border: Border.all(width: 2,color:Color(0xFFF65F51)),
    //             ),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Container(
    //                   width:280.8.aw,
    //                   height: 40.ah,
    //                   decoration: BoxDecoration(
    //                     color:Colors.white,
    //                     borderRadius: BorderRadius.circular(8),
    //                   ),
    //                   child:  Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Center(
    //                         child: Text('250 Sparks',
    //                           style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                             fontFamily: 'Roboto',color: Color(0xFFE20A00),
    //                           ),
    //                         ),
    //                       ),
    //                       Center(
    //                         child: Text('\$90.99',
    //                           style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                             fontFamily: 'Roboto',color: Color(0xFF000000),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //
    //                 ),
    //                 SizedBox(height: 15.ah),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Center(
    //                       child: Text('* ',
    //                         style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                           fontFamily: 'Roboto',color: Color(0xFF000000),
    //                         ),
    //                       ),
    //                     ),
    //                     Center(
    //                       child: Text('Get more attention than before',
    //                         style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //                           fontFamily: 'Roboto',color: Color(0xFF000000),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //
    //
    //
    //           SizedBox(height: 25.ah),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Center(
    //                 child: Text('* ',
    //                   style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                     fontFamily: 'Roboto',color: Color(0xFF000000),
    //                   ),
    //                 ),
    //               ),
    //               Text('Unlimited Real Reveals per month',
    //                 style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text('* ',
    //                 style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //                 ),
    //               ),
    //               Text('Ad-free experience',
    //                 style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Center(
    //                 child: Text('* ',
    //                   style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                     fontFamily: 'Roboto',color: Color(0xFF000000),
    //                   ),
    //                 ),
    //               ),
    //               Center(
    //                 child: Text('Priority customer support',
    //                   style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //                     fontFamily: 'Roboto',color: Color(0xFF000000),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Center(
    //                 child: Text('* ',
    //                   style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //                     fontFamily: 'Roboto',color: Color(0xFF000000),
    //                   ),
    //                 ),
    //               ),
    //               Center(
    //                 child: Text('Exclusive access to new features or events',
    //                   style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //                     fontFamily: 'Roboto',color: Color(0xFF000000),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //
    //           SizedBox(height: 25.ah),
    //           Container(
    //             width: 135.aw,
    //             height: 32.ah,
    //             decoration: BoxDecoration(
    //               color:Color(0xFFF65F51),
    //               borderRadius: BorderRadius.circular(24),
    //               border: Border.all(width: 2,color:Color(0xFFF65F51)),
    //             ),
    //             child: Center(
    //               child: Text('Go to Real Reveal',
    //                 style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //                   fontFamily: 'Roboto',color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //
    //           Spacer(),
    //           Container(
    //             width: MediaQuery.of(context).size.width,
    //             height: 45.ah,
    //             decoration: BoxDecoration(
    //               color:Color(0xFFF65F51),
    //               borderRadius: BorderRadius.circular(24),
    //               border: Border.all(width: 2,color:Color(0xFFF65F51)),
    //             ),
    //             child: Center(
    //               child: Text('Continue',
    //                 style: TextStyle(fontSize: 17.fSize,fontWeight: FontWeight.w600,
    //                   fontFamily: 'Roboto',color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 30)
    //
    //         ],
    //       ),
    //     ),
    //   ),
    //
    //   // body: SafeArea(
    //   //   child: Padding(
    //   //     padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
    //   //     child: Column(
    //   //       mainAxisAlignment: MainAxisAlignment.start,
    //   //       crossAxisAlignment: CrossAxisAlignment.center,
    //   //       children: [
    //   //
    //   //         Row(
    //   //           crossAxisAlignment: CrossAxisAlignment.center,
    //   //           mainAxisAlignment: MainAxisAlignment.end,
    //   //           children: [
    //   //             InkWell(
    //   //                 onTap: () {
    //   //                   Navigator.pop(context);
    //   //                 },
    //   //                 child: SvgPicture.asset('assets/images/crrros.svg',height: 30.ah,width: 30.ah,)
    //   //             )
    //   //           ],
    //   //         ),
    //   //
    //   //         SizedBox(height: 15.ah),
    //   //         Center(
    //   //           child: Text('Spark',
    //   //             style: TextStyle(fontSize: 50.fSize,fontWeight: FontWeight.w400,
    //   //               fontFamily: 'Kaushan Script',color: const Color(0xFFF94F60),
    //   //             ),
    //   //           ),
    //   //         ),
    //   //
    //   //         SizedBox(height: 15.ah),
    //   //         Image.asset('assets/images/teenstar.png',height:80.ah,width:80.aw,fit: BoxFit.fill,),
    //   //
    //   //
    //   //         SizedBox(height:30.ah),
    //   //         Container(
    //   //           //width: MediaQuery.of(context).size.width,
    //   //           width: 328.aw,
    //   //           height: 106.ah,
    //   //           decoration: BoxDecoration(
    //   //             color: const Color(0xFFF9505F).withOpacity(0.21),
    //   //             borderRadius: BorderRadius.circular(26.5),
    //   //             border: Border.all(width: 2,color:Color(0xFFF65F51)),
    //   //           ),
    //   //           child: Column(
    //   //             mainAxisAlignment: MainAxisAlignment.center,
    //   //             crossAxisAlignment: CrossAxisAlignment.center,
    //   //             children: [
    //   //               Container(
    //   //                 width:280.8.aw,
    //   //                 height: 40.ah,
    //   //                 decoration: BoxDecoration(
    //   //                   color:Colors.white,
    //   //                   borderRadius: BorderRadius.circular(8),
    //   //                 ),
    //   //                 child:  Row(
    //   //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   //                   crossAxisAlignment: CrossAxisAlignment.center,
    //   //                   children: [
    //   //                     Center(
    //   //                       child: Text('250 Sparks',
    //   //                         style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                           fontFamily: 'Roboto',color: Color(0xFFE20A00),
    //   //                         ),
    //   //                       ),
    //   //                     ),
    //   //                     Center(
    //   //                       child: Text('\$90.99',
    //   //                         style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                           fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                         ),
    //   //                       ),
    //   //                     ),
    //   //                   ],
    //   //                 ),
    //   //
    //   //               ),
    //   //               SizedBox(height: 15.ah),
    //   //               Row(
    //   //                 mainAxisAlignment: MainAxisAlignment.center,
    //   //                 crossAxisAlignment: CrossAxisAlignment.center,
    //   //                 children: [
    //   //                   Center(
    //   //                     child: Text('* ',
    //   //                       style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                         fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                       ),
    //   //                     ),
    //   //                   ),
    //   //                   Center(
    //   //                     child: Text('Get more attention than before',
    //   //                       style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //   //                         fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                       ),
    //   //                     ),
    //   //                   ),
    //   //                 ],
    //   //               ),
    //   //             ],
    //   //           ),
    //   //         ),
    //   //
    //   //
    //   //
    //   //         SizedBox(height: 25.ah),
    //   //         Row(
    //   //           mainAxisAlignment: MainAxisAlignment.center,
    //   //           crossAxisAlignment: CrossAxisAlignment.center,
    //   //           children: [
    //   //             Center(
    //   //               child: Text('* ',
    //   //                 style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //             Text('Unlimited Real Reveals per month',
    //   //               style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //   //                 fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //               ),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //         Row(
    //   //           mainAxisAlignment: MainAxisAlignment.center,
    //   //           crossAxisAlignment: CrossAxisAlignment.center,
    //   //           children: [
    //   //             Text('* ',
    //   //               style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                 fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //               ),
    //   //             ),
    //   //             Text('Ad-free experience',
    //   //               style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //   //                 fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //               ),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //         Row(
    //   //           mainAxisAlignment: MainAxisAlignment.center,
    //   //           crossAxisAlignment: CrossAxisAlignment.center,
    //   //           children: [
    //   //             Center(
    //   //               child: Text('* ',
    //   //                 style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //             Center(
    //   //               child: Text('Priority customer support',
    //   //                 style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //   //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //         Row(
    //   //           mainAxisAlignment: MainAxisAlignment.center,
    //   //           crossAxisAlignment: CrossAxisAlignment.center,
    //   //           children: [
    //   //             Center(
    //   //               child: Text('* ',
    //   //                 style: TextStyle(fontSize: 14.fSize,fontWeight: FontWeight.w600,
    //   //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //             Center(
    //   //               child: Text('Exclusive access to new features or events',
    //   //                 style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //   //                   fontFamily: 'Roboto',color: Color(0xFF000000),
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //
    //   //         SizedBox(height: 25.ah),
    //   //         Container(
    //   //           width: 135.aw,
    //   //           height: 32.ah,
    //   //           decoration: BoxDecoration(
    //   //             color:Color(0xFFF65F51),
    //   //             borderRadius: BorderRadius.circular(24),
    //   //             border: Border.all(width: 2,color:Color(0xFFF65F51)),
    //   //           ),
    //   //           child: Center(
    //   //             child: Text('Go to Real Reveal',
    //   //               style: TextStyle(fontSize: 13.fSize,fontWeight: FontWeight.w500,
    //   //                 fontFamily: 'Roboto',color: Colors.white,
    //   //               ),
    //   //             ),
    //   //           ),
    //   //         ),
    //   //
    //   //         Spacer(),
    //   //         Container(
    //   //           width: MediaQuery.of(context).size.width,
    //   //           height: 45.ah,
    //   //           decoration: BoxDecoration(
    //   //             color:Color(0xFFF65F51),
    //   //             borderRadius: BorderRadius.circular(24),
    //   //             border: Border.all(width: 2,color:Color(0xFFF65F51)),
    //   //           ),
    //   //           child: Center(
    //   //             child: Text('Continue',
    //   //               style: TextStyle(fontSize: 17.fSize,fontWeight: FontWeight.w600,
    //   //                 fontFamily: 'Roboto',color: Colors.white,
    //   //               ),
    //   //             ),
    //   //           ),
    //   //         ),
    //   //         SizedBox(height: 30)
    //   //
    //   //       ],
    //   //     ),
    //   //   ),
    //   // ),
    // );
  }
}
