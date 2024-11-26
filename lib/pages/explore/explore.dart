import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realdating/pages/discovery/discoveryScreen.dart';
import 'package:realdating/pages/explore/trainding/trandingController.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/app_colors.dart';
import '../../function/function_class.dart';
import '../../reel/common_import.dart';
import 'matches/allDateInvites/my_all_dates_pages.dart';
import 'matches/matches_controller.dart';
import 'matches/matches_page.dart';
import 'trainding/treading_page.dart';
import 'events/events_controller.dart';
import 'events/events_pages.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: customTextCommon(
          text: 'Explore',
          fSize: 24.adaptSize,
          fWeight: FontWeight.w600,
          lineHeight: 24,
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const DiscoveryPage());
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 8, right: 8, top: 8, bottom: 8),
              margin: const EdgeInsets.only(
                right: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE8E6EA),
                    width: 1.0,
                  )),
              child: Image.asset("assets/images/discovery.png",width: 25,height: 25,),
            ),
          ),
          10.widthBox,
        ],
      ),

      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   flexibleSpace: Container(height: 50),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   shadowColor: Colors.white,
      //   title: customTextCommon(
      //       text: "Explore",
      //       fSize: 24.adaptSize,
      //       fWeight: FontWeight.w600,
      //       lineHeight: 24
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20,),
            MatchesWidget(),
             32.ah.heightBox,
            TrendingWidget(),
            32.ah.heightBox,
            EventsWidget(),
            32.ah.heightBox,
          ]),
        ),
      ),
    );
  }
}

class MatchesWidget extends StatefulWidget {
  MatchesWidget({super.key});

  @override
  State<MatchesWidget> createState() => _MatchesWidgetState();
}

class _MatchesWidgetState extends State<MatchesWidget> {
  final MatchessController matchessController = Get.put(MatchessController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matchessController.matches();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customTextCommon(
                  text: " Matches",
                  fSize: 24.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 24),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MatchesPage()));
                },
                child: customTextCommon(
                  text: "See All",
                  fSize: 22.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 24,
                  color: const Color(0xffAAAAAa),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(() => matchessController.isLoadig.value
            ? SizedBox(
            height: 360.ah,
            child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                )))
            :  matchessController.matchessModel!.myFriends!.isEmpty ? SizedBox( height: 360.ah,
            child: const Center(child: Text("No Matches Found"),)) : SizedBox(
          height: 360.ah,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: matchessController.matchessModel!.myFriends!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchesPage()));
                              },
                  child: ClipRRect(
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
                              imageUrl: matchessController.matchessModel!
                                  .myFriends![index].profileImage
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
                              fit: BoxFit.cover,
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${matchessController.matchessModel!.myFriends![index].friendFirstName} ${matchessController.matchessModel!.myFriends![index].friendLastName},',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.adaptSize,
                                    overflow: TextOverflow.ellipsis,

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
          ),
        )),

      ],
    );
  }
}

class TrendingWidget extends StatelessWidget {
  TrendingWidget({super.key});

  final TreadingController treadingController = Get.put(TreadingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customTextCommon(
                  text: "Trending",
                  fSize: 24.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 24),
              InkWell(
                onTap: () {
                  Get.to(
                    () => TrendingPage(),
                    // arguments:
                    // index, // Replace with your index value
                  );
                },
                child: customTextCommon(
                  text: "See All",
                  fSize: 22.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 24,
                  color: const Color(0xffAAAAAa),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 360.ah,
            child: Obx(() => treadingController.isLoadingTreandingUser.value
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,

                    ),
                  )
                :   treadingController.treadingModel!.trendingUser!.isEmpty ? SizedBox( height: 360.ah,
                child: const Center(child: Text("No Trending User Found"),))  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: treadingController.treadingModel!.trendingUser?.length,
                    itemBuilder: (context, index) {
                      // return Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: Container(
                      //       width: 240.ah,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         image: DecorationImage(
                      //           image: NetworkImage(treadingController
                      //               .treadingModel!
                      //               .trendingUser![index]
                      //               .profileImage
                      //               .toString()),
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //       child: Container(
                      //         decoration: const BoxDecoration(
                      //             gradient: LinearGradient(
                      //                 colors: [
                      //                   Colors.transparent,
                      //                   Colors.black
                      //                 ],
                      //                 begin: Alignment.topCenter,
                      //                 end: Alignment.bottomCenter,
                      //                 stops: [0.7, 1])),
                      //         padding: EdgeInsets.all(20),
                      //         child: Column(
                      //           children: [
                      //             Spacer(),
                      //             Row(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   '${treadingController.treadingModel!.trendingUser![index].firstName} ${treadingController.treadingModel!.trendingUser![index].lastName},  ${treadingController.treadingModel!.trendingUser![index].age}',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 20.adaptSize,
                      //                     fontFamily: 'Inter',
                      //                     fontWeight: FontWeight.w600,
                      //                     height: 0.06,
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 10.ah,
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                   return   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
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
                                    fit: BoxFit.cover,
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
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${treadingController.treadingModel!.trendingUser![index].firstName} ${treadingController.treadingModel!.trendingUser![index].lastName}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.adaptSize,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )))
      ],
    );
  }
}

class EventsWidget extends StatelessWidget {
  EventsWidget({super.key});

  final EventsController eventsController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customTextCommon(
                  text: "Events",
                  fSize: 24.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 24),
              InkWell(
                onTap: () {
                  Get.to(
                    () => EventsPage(),
                    // arguments:
                    // index, // Replace with your index value
                  );
                },
                child: customTextCommon(
                  text: "See All",
                  fSize: 22.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 24,
                  color: const Color(0xffAAAAAa),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => eventsController.isLoadig.value
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : eventsController.matchessModel?.getEvents.length != 0
                  ? SizedBox(
                      height: 324,
                      child: ListView.builder(
                        itemCount: eventsController.matchessModel?.getEvents.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Stack(children: [


                              SizedBox(
                                height: 400,
                                width: 262,
                                child: Container(
                                  height: 400,
                                  width: 262,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            eventsController
                                                    .matchessModel
                                                    ?.getEvents[index]
                                                    .eventImage ??
                                                "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),

                              Positioned(
                                top: 17,
                                left: 17,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.60),
                                      borderRadius: BorderRadius.circular(30)),
                                  height: 32,
                                  width: 90,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 0,
                                      ),
                                      customTextCommon(
                                        text: eventsController.matchessModel
                                                ?.getEvents[index].eventType ??
                                            "",
                                        fSize: 12,
                                        fWeight: FontWeight.w500,
                                        lineHeight: 24,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  height: 70,
                                  width: 262,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF65F51)
                                          .withOpacity(.60),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )),
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                left: 17,
                                child: customTextCommon(
                                  text:
                                      "${eventsController.matchessModel?.getEvents[index].eventTitle}",
                                  fSize: 16,
                                  fWeight: FontWeight.w600,
                                  lineHeight: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 21,
                                left: 17,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/clender.svg"),
                                    const SizedBox(
                                      width: 3.5,
                                    ),
                                    customTextCommon(
                                      text:
                                          "${eventsController.matchessModel?.getEvents[index].startDate} to ${eventsController.matchessModel?.getEvents[index].endDate}",
                                      fSize: 12,
                                      fWeight: FontWeight.w500,
                                      lineHeight: 12,
                                      color: const Color(0xffEBEBF5)
                                          .withOpacity(.70),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        },
                      ))
                  : Container(
                      height: 120,
                      child: Center(child: Text("No Events Found !!"))),
        )
      ],
    );
  }
}
