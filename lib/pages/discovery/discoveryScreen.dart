import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/function/function_class.dart';
import 'package:get/get.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/custom_text_styles.dart';
import 'discovery_controller.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  DiscoveryController discoveryController = Get.put(DiscoveryController());

  final TextEditingController _controller = TextEditingController();

  void filterSearchResults(String query) {
    discoveryController.filteredItems.clear();
    discoveryController.filteredItemsYou.clear();
    if (query.isNotEmpty) {
      setState(() {
        discoveryController.filteredItems.addAll(discoveryController.myFriends.where((item) => item.firstName!.toLowerCase().contains(query.toLowerCase())));
        discoveryController.filteredItemsYou.addAll(discoveryController.myFriendsForyou.where((item) => item.firstName!.toLowerCase().contains(query.toLowerCase())));

      });
    } else {
      setState(() {
        discoveryController.filteredItems.addAll(discoveryController.myFriends);
        discoveryController.filteredItemsYou.addAll(discoveryController.myFriendsForyou);

      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            title: const Text(
              "Discovery",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  'assets/icons/btn.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          body: Obx(
            () => discoveryController.isLoadingGetDiscoverUser.value &&discoveryController.isLoadingGetDiscoverUser.value
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 20, right: 18),
                    child: Column(children: [
                      Container(
                        height: 57,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: 50, // Adjusted height for better alignment
                                width: 50,  // Adjusted width for consistency
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Appcolor.Redpink,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.search_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Add your search action here
                                  },
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0), // Center text vertically
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width:MediaQuery.of(context).size.width/1,
                          child: TabBar(
                            unselectedLabelColor: Colors.grey,
                            dividerColor: Colors.grey.withOpacity(0.3),
                            indicatorColor: Colors.red,
                            onTap: (value) {
                              print("dsffsfs$value");
                            },
                            tabs: const [
                              Tab(
                                  icon: Text(
                                "Recently Active",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),

                              )),
                              Tab(
                                  icon: Text(
                                "For you",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            discoveryController.filteredItems.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    itemCount: discoveryController.filteredItems.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      var dataD = discoveryController.filteredItems[i];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Card(
                                          child: Row(
                                            children: [
                                               Column(
                                                children: [
                                                  Container(
                                                    width: 130,
                                                    height: 130,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(image: NetworkImage(dataD.images?.length== 0 ? "" :  dataD.images?[0].profileImages ?? ""),
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${dataD.firstName},",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          dataD.age.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 4.0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              discoveryController
                                                                  .filteredItems[
                                                                      i]
                                                                  .request = "Sent";
                                                              setState(() {});

                                                              bool sendrequest =
                                                                  await discoveryController
                                                                      .sendNotificationOnlyMatch(
                                                                          reciverId:
                                                                              '${dataD.id.toString()}',
                                                                          index:
                                                                              i);
                                                              if (sendrequest) {
                                                              } else {
                                                                discoveryController
                                                                        .filteredItems[
                                                                            i]
                                                                        .request =
                                                                    "Request";
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Appcolor
                                                                          .Redpink),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          .60),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              height: 35.ah,
                                                              width: 70.aw,
                                                              child: Center(
                                                                  child:
                                                                      customTextCommon(
                                                                text:
                                                                    "${discoveryController.filteredItems[i].request}",
                                                                fSize: 14
                                                                    .adaptSize,
                                                                fWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                lineHeight: 24,
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                        10.widthBox,
                                                      ],
                                                    ),

                                                    10.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 15,
                                                          color: Colors.red,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Expanded(
                                                          child: Text(
                                                            dataD.address
                                                                .toString(),
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 6),
// if (dataD?.interest.length != null)
/*
                                                  Container(
                                                    height: 35,
                                                    child: GridView.builder(
                                                        itemCount:
                                                            1,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,childAspectRatio: 2),
                                                        itemBuilder: (ctx, i) {
                                                          return Center(
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 0,
                                                                right: 20,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0x3CF65F51)),
                                                                  color: Color(
                                                                      0x3CF65F51),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              height: 35,
                                                              width: 100,
                                                              child: Center(
                                                                  child:
                                                                      customTextCommon(
                                                                text: dataD
                                                                        ?.interest ??
                                                                    "",
                                                                fSize: 14,
                                                                fWeight:
                                                                    FontWeight.w600,
                                                                lineHeight: 24,
                                                              )),
                                                            ),
                                                          );
                                                        }),
                                                  )
*/

                                                    Wrap(
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                dataD
                                                                    .hobbiesData!
                                                                    .length;
                                                            i++)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              width: 70,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0x3CF65F51)),
                                                                  color: const Color(
                                                                      0x3CF65F51),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Center(
                                                                    child:
                                                                        customTextCommon(
                                                                  text: dataD
                                                                      .hobbiesData![
                                                                          i]
                                                                      .toString(),
                                                                  fSize: 14
                                                                      .adaptSize,
                                                                  fWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  lineHeight:
                                                                      14,
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    10.heightBox,
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : const Center(child: Text("No Data Found")),
                            discoveryController.filteredItemsYou.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    itemCount: discoveryController
                                        .filteredItemsYou.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      var dataD = discoveryController
                                          .filteredItemsYou[i];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Card(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 130,
                                                    height: 130,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
                                                          image: NetworkImage(dataD
                                                              .images![0]
                                                              .profileImages!),
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${dataD.firstName},",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          dataD.age.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 4.0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              discoveryController
                                                                  .filteredItemsYou[
                                                                      i]
                                                                  .request = "Sent";
                                                              setState(() {});
                                                              bool sendrequest =
                                                                  await discoveryController
                                                                      .sendNotificationOnlyMatch(
                                                                          reciverId:
                                                                              '${dataD.id.toString()}',
                                                                          index:
                                                                              i);
                                                              if (sendrequest) {
                                                              } else {
                                                                discoveryController
                                                                        .filteredItemsYou[
                                                                            i]
                                                                        .request =
                                                                    "Request";
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Appcolor
                                                                          .Redpink),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          .60),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              height: 35.ah,
                                                              width: 70.aw,
                                                              child: Center(
                                                                  child:
                                                                      customTextCommon(
                                                                text:
                                                                    "${discoveryController.myFriendsForyou[i].request}",
                                                                fSize: 14
                                                                    .adaptSize,
                                                                fWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                lineHeight: 24,
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                        10.widthBox,
                                                      ],
                                                    ),

                                                    10.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 15,
                                                          color: Colors.red,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Expanded(
                                                          child: Text(
                                                            dataD.address
                                                                .toString(),
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 6),
                                                    // if (dataD?.interest.length != null)
/*
                                                  Container(
                                                    height: 35,
                                                    child: GridView.builder(
                                                        itemCount:
                                                            1,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,childAspectRatio: 2),
                                                        itemBuilder: (ctx, i) {
                                                          return Center(
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 0,
                                                                right: 20,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0x3CF65F51)),
                                                                  color: Color(
                                                                      0x3CF65F51),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              height: 35,
                                                              width: 100,
                                                              child: Center(
                                                                  child:
                                                                      customTextCommon(
                                                                text: dataD
                                                                        ?.interest ??
                                                                    "",
                                                                fSize: 14,
                                                                fWeight:
                                                                    FontWeight.w600,
                                                                lineHeight: 24,
                                                              )),
                                                            ),
                                                          );
                                                        }),
                                                  )
*/

                                                    Wrap(
                                                      children: [
                                                        for (int i = 0; i < dataD.hobbiesData!.length; i++)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              width: 70,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0x3CF65F51)),
                                                                  color: const Color(
                                                                      0x3CF65F51),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Center(
                                                                    child:
                                                                        customTextCommon(
                                                                  text: dataD
                                                                      .hobbiesData![
                                                                          i]
                                                                      .toString(),
                                                                  fSize: 14
                                                                      .adaptSize,
                                                                  fWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  lineHeight:
                                                                      14,
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    10.heightBox,
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : const Center(child: Text("No Data Found")),
                          ],
                        ),
                      ),
                    ]),
                  ),
          ),
        ));
  }
}
