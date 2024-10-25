import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image/image.dart' as IMG;

import '../../buisness_screens/buisness_home/controller/business_home_controller.dart';
import '../../buisness_screens/buisness_home/model/myDealModel.dart';
import '../../function/function_class.dart';
import '../../widgets/custom_text_styles.dart';
import 'mapeController.dart';
import 'mapeModel.dart';

class NearByBusiness extends StatefulWidget {
  @override
  _NearByBusinessState createState() => _NearByBusinessState();
}

class _NearByBusinessState extends State<NearByBusiness> {
  MapeUserController userMapeController = Get.put(MapeUserController());

  GoogleMapController? mapController;
  Set<Marker> markers = {};

  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  LatLng endLocation = const LatLng(27.6599592, 85.3102498);

  @override
  void initState() {
    addMarkers();
    super.initState();
    _getCurrentLocation();
  }

  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  String address = '';
  Position? _currentPosition;

  Future<void> getAddressFromLatLng(lat, long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String formattedAddress =
            "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        setState(() {
          address = formattedAddress;
        });
      } else {
        setState(() {
          address = 'No address available';
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    // Replace with your actual address

    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        addMarkers();
        print(_currentPosition);
        // getAddressFromLatLng(_currentPosition?.latitude,_currentPosition?.longitude);
        // Address? streetAddress = await FlutterAddressFromLatLng().getStreetAddress(
        //   latitude: _currentPosition!.latitude,
        //   longitude: _currentPosition!.longitude,
        //   googleApiKey: googleApiKey,
        // );
      });
    }).catchError((e) {
      print(e);
    });
  }

  bool? loadData;

  addMarkers() async {
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();

    Uint8List? smallimg = resizeImage(bytes, 150, 150);
    for (int i = 0; i < userMapeController.userBusinessMap.length; i++) {
      Set<Marker>.from(userMapeController.userBusinessMap.map((e) {
        return markers.add(Marker(
          markerId: MarkerId((
            _currentPosition?.latitude ?? 20.5937,
            _currentPosition?.longitude ?? 78.9629
          ).toString()),
          position: LatLng(
              double.tryParse(userMapeController.userBusinessMap[i].latitude) ??
                  22.0,
              double.tryParse(
                      userMapeController.userBusinessMap[i].longitude) ??
                  22.0),
          icon: BitmapDescriptor.fromBytes(
              resizeImage(bytes, 300, 300)!), //Icon for Marker
        ));
      }));
    }

    Uint8List? bigimg = resizeImage(bytes, 300, 300);
    markers.add(Marker(
      markerId: MarkerId(endLocation.toString()),
      position: endLocation,
      icon: BitmapDescriptor.fromBytes(bigimg!), //Icon for Marker
    ));

    setState(() {
      //refresh UI
    });
  }

  final TextEditingController _searchController = TextEditingController();

  void changeCameraPosition(lat, long) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(double.tryParse(lat) ?? 0, double.tryParse(long) ?? 0),
          // New target coordinates
          zoom: 15.0, // New zoom level
        ),
      ),
    );
  }

  MyDealController myDealController = Get.put(MyDealController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true,

          //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: LatLng(_currentPosition?.latitude ?? 20.5937,
                _currentPosition?.longitude ?? 78.9629), //initial position
            zoom: 20.0, //initial zoom level
          ),
          markers: Set<Marker>.from(
            userMapeController.userBusinessMap.map((location) {
              Future<void> fetchData() async {
                // Replace this with your actual API call logic
                await   myDealController.MYDealUserMap(location.id);
                print("API call completed!");
              }
              return Marker(
                  // icon: BitmapDescriptor.fromBytes(resizeImage(bytes, 300, 300)!),
                  markerId: MarkerId(location.city.toString()),
                  position: LatLng(
                double.tryParse(location.latitude)??22,
                    double.tryParse(location.longitude)??22,
                  ),
                  infoWindow: InfoWindow(
                    title: location.businessName,
                    /* snippet:
                        "${location.address} ${location.city} ${location.country}",*/
                  ),
                  onTap: () async {
                    loadData = true;

                    print("location=====");
                    print(location);
                    print(location.address);
                    print(location.city);
                    print(location.country);
                    print(location.state);
                    print(location.latitude);
                    print(location.longitude);
                    myDealController.refresh();
                    myDealController.myDealsModel?.myDeals.clear();
                    getAddressFromLatLng(location.latitude, location.longitude);




                    setState(() {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext bc) {
                            // myDealController.MYDealUserMap(location.id);
                            return FutureBuilder(
                              future: fetchData(),
                              builder: (context, snapshot) {
                                return Obx(
                                  () => myDealController.isLoadig.value
                                      ? const Center(child: CircularProgressIndicator())
                                      : Column(
                                          children: [
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            const Text(
                                              "All Deals",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Text(
                                              location.businessName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            /*     Text(
                                        "Address: ${address}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),*/
                                            Expanded(
                                              child:
                                                  myDealController
                                                              .myDealsModel?.myDeals !=
                                                          null
                                                      ? myDealController
                                                      .myDealsModel
                                                      ?.myDeals
                                                      .length==0 ? Expanded(child: Center(child: Text("No Deals Founds"))) : GridView.builder(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18),
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount: 2,
                                                                  childAspectRatio:
                                                                      20 / 24,
                                                                  crossAxisSpacing:
                                                                      4.0,
                                                                  mainAxisSpacing:
                                                                      8.0),
                                                          itemCount:
                                                              myDealController
                                                                  .myDealsModel
                                                                  ?.myDeals
                                                                  .length,
                                                          itemBuilder: (BuildContext
                                                                  context,
                                                              int index) {
                                                            String result = '';
                                                            int value1 = int.tryParse(
                                                                    myDealController
                                                                        .myDealsModel!
                                                                        .myDeals[
                                                                            index]
                                                                        .price
                                                                        .toString()) ??
                                                                0;
                                                            int value2 = int.tryParse(
                                                                    myDealController
                                                                        .myDealsModel!
                                                                        .myDeals[
                                                                            index]
                                                                        .discount
                                                                        .toString()) ??
                                                                0;

                                                            int subtractionResult =
                                                                value1 - value2;

                                                            result =
                                                                'Result: $subtractionResult';
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 4.0),
                                                              child: Card(
                                                                // color: Colors.white.withOpacity(0.5),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                elevation: 2.0,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      // Navigator.pushNamed(context, '/route-name');
                                                                      /*  Get.to(
                                                            () => EDIT_deal(),
                                                        arguments:
                                                        index, // Replace with your index value
                                                      );*/
                                                                    },
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              100,
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                myDealController.myDealsModel?.myDeals[index].roomImage ??
                                                                                    "",
                                                                            imageBuilder: (context, imageProvider) => Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                child: Image.network(
                                                                                  myDealController.myDealsModel?.myDeals[index].roomImage ?? "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734",
                                                                                  fit: BoxFit.fill,
                                                                                  alignment: Alignment.center,
                                                                                  height: 125,
                                                                                  width: double.infinity,
                                                                                )
                                                                                //Image.asset('assets/images/feed_img.png', fit:BoxFit.none,),
                                                                                ),
                                                                            placeholder:
                                                                                (context,
                                                                                    url) {
                                                                              return Center(
                                                                                  child: Image.network(
                                                                                "https://raw.githubusercontent.com/prafful98/vue3-shimmer/HEAD/assets/card.gif",
                                                                                fit:
                                                                                    BoxFit.fill,
                                                                                alignment:
                                                                                    Alignment.center,
                                                                                height:
                                                                                    120,
                                                                                width:
                                                                                    double.infinity,
                                                                              ));
                                                                            },
                                                                            errorWidget: (context,
                                                                                    url,
                                                                                    error) =>
                                                                                Center(
                                                                                    child: Container(
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(10),
                                                                              ),
                                                                              child:
                                                                                  Image.network(
                                                                                myDealController.myDealsModel?.myDeals[index].roomImage ??
                                                                                    "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734",
                                                                                fit:
                                                                                    BoxFit.fill,
                                                                                alignment:
                                                                                    Alignment.center,
                                                                                height:
                                                                                    125,
                                                                                width:
                                                                                    double.infinity,
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
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceEvenly,
                                                                          children: [
                                                                            Padding(
                                                                              padding:
                                                                                  const EdgeInsets.only(left: 20.0),
                                                                              child:
                                                                                  Text(
                                                                                myDealController.myDealsModel?.myDeals[index].title ??
                                                                                    "",
                                                                                style:
                                                                                    const TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                                height:
                                                                                    8),
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 20,
                                                                                ),
                                                                                customTextCommon(
                                                                                  text: "₹${subtractionResult.toString() ?? ""}",
                                                                                  fSize: 14,
                                                                                  fWeight: FontWeight.w600,
                                                                                  lineHeight: 0,
                                                                                  color: const Color(0xffFB4967),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  "₹${myDealController.myDealsModel?.myDeals[index].price}",
                                                                                  style: const TextStyle(
                                                                                    decoration: TextDecoration.lineThrough,
                                                                                    decorationColor: Colors.grey,
                                                                                    decorationThickness: 2,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    color: Color(0xffAAAAAA),
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
                                                          })
                                                      : Container(
                                                          width: double.infinity,
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: const Center(
                                                              child: Text(
                                                                  "No deals found !!"))),
                                            ),
                                          ],
                                        ),
                                );
                              }
                            );
                          });
                    });
                    // myDealController.myDealsModel?.myDeals.clear();
                  },
                  visible: true);
            }),
          ),
          onTap: (LatLng position) {
            // Show a dialog or perform any action when the map is tapped
          },
          //markers to show on map
          mapType: MapType.normal,
          //map type
          onMapCreated: (controller) {
            //method called when map is created
            setState(() {
              mapController = controller;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
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
              const Text(
                "Find Deals",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Container(
            height: 57,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    offset: const Offset(0, 10),
                    blurRadius: 15,
                    // spreadRadius: 2,
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
// Add padding around the search bar
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: TextField(
              onChanged: (value) {
                userMapeController.getAllUserMape(value ?? "");
              },
              controller: _searchController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15.0),
                  hintText: 'Search...',
                  suffixIcon: Container(
                    margin: const EdgeInsets.only(right: 5, top: 5),
                    height: 20,
                    width: 50,
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
                        userMapeController
                            .getAllUserMape(_searchController.text);
                        changeCameraPosition(
                            userMapeController.userBusinessMap[0].latitude,
                            userMapeController.userBusinessMap[0].longitude);
                      },
                    ),
                  ),
// Add a search icon or button to the search bar

                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    ));
  }
}
