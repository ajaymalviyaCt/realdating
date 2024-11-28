import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:realdating/buisness_screens/buisness_home/deals/edit_deal.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_text_styles.dart';
import '../controller/business_home_controller.dart';

class BuiusnessTopDeals extends StatefulWidget {
  const BuiusnessTopDeals({Key? key}) : super(key: key);

  @override
  State<BuiusnessTopDeals> createState() => _BuiusnessDealsState();
}

class _BuiusnessDealsState extends State<BuiusnessTopDeals> {
  MyDealController myDealController = Get.put(MyDealController());

  bool _onFillunfillStar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() {
    //   myDealController.MYDeal();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("All Top Deals", context),
      body: Obx(
        () => myDealController.isLoadig.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  await myDealController.MYDeal();
                },
                child: myDealController.myDealsModel?.myDeals.length == null  ?
                Center(child: Text("No Deals Found"),) :
                GridView.builder(
                    padding: const EdgeInsets.all(18),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 20 / 28,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 8.0),
                    itemCount: myDealController.myDealsModel?.myDeals.length,
                    itemBuilder: (BuildContext context, int index) {
                      String result = '';
                      int value1 = int.tryParse(myDealController
                              .myDealsModel!.myDeals[index].price
                              .toString()) ??
                          0;
                      int value2 = int.tryParse(myDealController
                              .myDealsModel!.myDeals[index].discount
                              .toString()) ??
                          0;

                      int subtractionResult = value1 - value2;

                      result = 'Result: $subtractionResult';
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Card(
                          // color: Colors.white.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2.0,
                          child: InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, '/route-name');
                                Get.to(
                                  () => EDIT_deal(),
                                  arguments:
                                      index, // Replace with your index value
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: CachedNetworkImage(
                                      imageUrl: myDealController.myDealsModel
                                              ?.myDeals[index].roomImage ??
                                          "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.network(
                                                myDealController
                                                        .myDealsModel
                                                        ?.myDeals[index]
                                                        .roomImage ??
                                                    "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734",
                                                fit: BoxFit.fill,
                                                alignment: Alignment.center,
                                                height: 125,
                                                width: double.infinity,
                                              )
                                              //Image.asset('assets/images/feed_img.png', fit:BoxFit.none,),
                                              ),
                                      placeholder: (context, url) {
                                        return Center(
                                            child: Image.network(
                                          "https://raw.githubusercontent.com/prafful98/vue3-shimmer/HEAD/assets/card.gif",
                                          fit: BoxFit.fill,
                                          alignment: Alignment.center,
                                          height: 120,
                                          width: double.infinity,
                                        ));
                                      },
                                      errorWidget: (context, url, error) =>
                                          Center(
                                              child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          myDealController.myDealsModel
                                                  ?.myDeals[index].roomImage ??
                                              "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734",
                                          fit: BoxFit.fill,
                                          alignment: Alignment.center,
                                          height: 125,
                                          width: double.infinity,
                                        ),
                                        //Image.asset('assets/images/feed_img.png', fit:BoxFit.none,),
                                      )),
                                    ),
                                    /*    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                //NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.tripadvisor.in%2FHotel_Review-g494941-d23860464-Reviews-Essentia_Luxury_Hotel_Indore-Indore_Indore_District_Madhya_Pradesh.html&psig=AOvVaw3RojIVr60VX-N-4vLDy8uL&ust=1694505815534000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCICd85uMooEDFQAAAAAdAAAAABAD'),
                                                NetworkImage(
                                              myDealController
                                                      .myDealsModel
                                                      ?.myDeals[index]
                                                      .roomImage ??
                                                  "",
                                            ),
                                            // AssetImage('assets/images/Rectangle 1179.png'),
                                            fit: BoxFit.fill)),*/
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0,right: 5),
                                        child: Text(
                                          myDealController.myDealsModel
                                                  ?.myDeals[index].title ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),

                                          customTextCommon(
                                            text:
                                            "\$${subtractionResult.toString() ?? ""}",
                                            fSize: 14,
                                            fWeight: FontWeight.w600,
                                            lineHeight: 0,
                                            color: const Color(0xffFB4967),
                                          ),

                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "\$${myDealController.myDealsModel?.myDeals[index].price}",
                                            style: TextStyle(
                                              decoration:
                                              TextDecoration.lineThrough,
                                              decorationColor: Colors.grey,
                                              decorationThickness: 2,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xffAAAAAA),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
