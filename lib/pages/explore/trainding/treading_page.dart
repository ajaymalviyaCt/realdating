import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realdating/consts/app_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:realdating/widgets/size_utils.dart';
import '../matches/matchDetsils.dart';
import 'trandingController.dart';

class TrendingPage extends StatefulWidget {
 const TrendingPage({super.key,});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  TreadingController treadingController = Get.find<TreadingController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: preferredSizeAppBar("Trending", "sff", () {}),
        // body: Obx(() => treadingController.isLoadingTreandingUser.value
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : GridView.builder(
        //         itemCount:
        //             treadingController.treadingModel!.trendingUser!.length,
        //         padding: const EdgeInsets.all(18),
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             crossAxisSpacing: 10,
        //             mainAxisSpacing: 10),
        //         itemBuilder: (BuildContext context, int index) {
        //           return InkWell(
        //             onTap: () {
        //               Get.to(() => TraindingDetailScreeen(
        //                     id: treadingController
        //                             .treadingModel?.trendingUser![index].id
        //                             .toString()
        //                             .toString() ??
        //                         "1",
        //                   ));
        //             },
        //             child: Card(
        //               elevation: 0,
        //               color: Colors.white.withOpacity(.20),
        //               child: Stack(children: [
        //                 CachedNetworkImage(
        //                   imageUrl: treadingController.treadingModel
        //                           ?.trendingUser![index].profileImage ??
        //                       "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
        //                   imageBuilder: (context, imageProvider) {
        //                     // matchessController.matches();
        //                     return Container(
        //                       height: 200,
        //                       width: 200,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(8),
        //                           image: DecorationImage(
        //                             image: NetworkImage(
        //                               treadingController
        //                                       .treadingModel
        //                                       ?.trendingUser![index]
        //                                       .profileImage ??
        //                                   "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
        //                             ),
        //                             fit: BoxFit.cover,
        //                           )),
        //                     );
        //                   },
        //                   placeholder: (context, url) {
        //                     return Center(
        //                         child: Image.network(
        //                             "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg"));
        //                   },
        //                   errorWidget: (context, url, error) => Container(
        //                     width: MediaQuery.of(context).size.width,
        //                     height: 415,
        //                     decoration: const BoxDecoration(
        //                       image: DecorationImage(
        //                         image: NetworkImage(
        //                             "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg"),
        //                         fit: BoxFit.fill,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Positioned(
        //                   top: 12,
        //                   left: 10,
        //                   child: Container(
        //                     padding: const EdgeInsets.only(
        //                         left: 5, right: 10, top: 5, bottom: 5),
        //                     decoration: BoxDecoration(
        //                         color: Colors.white.withOpacity(.60),
        //                         borderRadius: BorderRadius.circular(30)),
        //                     // height: 32,width: 105,
        //                     child: const Center(
        //                         child: Row(
        //                       children: [
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                         Icon(
        //                           Icons.location_on_outlined,
        //                           color: Colors.black,
        //                           size: 14,
        //                         ),
        //                         SizedBox(
        //                           width: 3,
        //                         ),
        //                       ],
        //                     )),
        //                   ),
        //                 ),
        //                 Positioned(
        //                     bottom: 0,
        //                     child: Container(
        //                       decoration: const BoxDecoration(
        //                           // color: Colors.red.withOpacity(.60),
        //                           borderRadius: BorderRadius.only(
        //                               bottomLeft: Radius.circular(15),
        //                               bottomRight: Radius.circular(15))),
        //                       height: 54,
        //                       width: 160,
        //                     )),
        //                 Positioned(
        //                   bottom: 10,
        //                   left: 8,
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(8),
        //                         color: Colors.white.withOpacity(.60)),
        //                     padding: const EdgeInsets.all(5),
        //                     child: customTextCommon(
        //                       text: treadingController.treadingModel
        //                               ?.trendingUser![index].username ??
        //                           "",
        //                       fSize: 15,
        //                       fWeight: FontWeight.w600,
        //                       lineHeight: 24,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                 ),
        //               ]),
        //             ),
        //           );
        //         },
        //       )));

        body: Obx(() => treadingController.isLoadingTreandingUser.value? const Center(child: CircularProgressIndicator(strokeWidth: 2,)) :treadingController.treadingModel!.trendingUser!.isEmpty ? const SizedBox( height: double.infinity,
            child: Center(child: Text("No Trending User Found"),))  :
    GridView.builder(
      itemCount: treadingController.treadingModel!.trendingUser!.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
          ,childAspectRatio: 85/100
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:InkWell(
            onTap: (){
              Get.to(() => MatchDetails(
                id: treadingController.treadingModel?.trendingUser![index].id.toString() ?? "",isfriend:treadingController.treadingModel?.trendingUser?[index].friend == 0 ? false : true ,
              ));
            },
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 240.ah,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black12,
                      height: 360.ah,
                      width: 240.ah,
                      child: CachedNetworkImage(
                        imageUrl: treadingController
                            .treadingModel!
                            .trendingUser![index]
                            .profileImage
                            .toString(),
                        placeholder: (context, url) => const Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ))),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.person_2_outlined),
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.fill,
                        height: 300,
                      ),
                    ),
                    Container(
                      width: 240.ah,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.7, 1])),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${treadingController.treadingModel!.trendingUser![index].firstName} ${treadingController.treadingModel!.trendingUser![index].lastName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.adaptSize,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis, // Optional: Show ellipsis (...) when text is truncated
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    )
    ));
  }

  PreferredSize preferredSizeAppBar(
      String title, String icon, Function()? onTap) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.ah), // preferred height for the app bar
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color(0xFFE8E6EA),
                    // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
                    width: 1.0, // Border width
                  ),
                  color: const Color(
                      0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
                ),
                child: const Icon(Icons.arrow_back_ios_outlined,
                    color: colors.primary, size: 18),
              ).paddingOnly(
                left: 16.w,
              ),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 20.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 54.08.ah * .90,
                height: 52.ah * .90,
              ).paddingOnly(right: 16.w),
            )
          ],
        ).paddingOnly(top: 20.ah, bottom: 14.ah),
      ),
    );
  }
}
