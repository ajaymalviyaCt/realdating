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

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Location permissions are denied.");
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied.");
        await Geolocator.openAppSettings();
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );
      setState(() {
        _currentPosition = position;
        addMarkers(); // Call your method to add markers on the map
      });

      print("Current Position: $_currentPosition");
    } catch (e) {
      print("Error fetching location: $e");
    }
  }


  bool? loadData;

  addMarkers() async {
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl)).buffer.asUint8List();

    Uint8List? smallimg = resizeImage(bytes, 150, 150);
    for (int i = 0; i < userMapeController.userBusinessMap.length; i++) {
      Set<Marker>.from(userMapeController.userBusinessMap.map((e) {
        return markers.add(Marker(
          markerId: MarkerId((
            _currentPosition?.latitude ?? 20.5937,
            _currentPosition?.longitude ?? 78.9629
          ).toString()),
          position: LatLng(double.tryParse(userMapeController.userBusinessMap[i].latitude) ?? 22.0,
              double.tryParse(userMapeController.userBusinessMap[i].longitude) ?? 22.0),
          icon: BitmapDescriptor.fromBytes(resizeImage(bytes, 300, 300)!), //Icon for Marker
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
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              _currentPosition?.latitude ?? 20.5937,
              _currentPosition?.longitude ?? 78.9629,
            ),
            zoom: 20.0,
          ),
          markers: Set<Marker>.from(
            userMapeController.userBusinessMap.map((location) {
              Future<void> fetchData() async {
                await myDealController.MYDealUserMap(location.id);
                print("API call completed!");
              }

              return Marker(
                markerId: MarkerId(location.city.toString()),
                position: LatLng(
                  double.tryParse(location.latitude) ?? 22,
                  double.tryParse(location.longitude) ?? 22,
                ),
                infoWindow: InfoWindow(
                  title: location.businessName,
                ),
                onTap: () async {
                  loadData = true;
                  print("Location details:");
                  print("Address: ${location.address}");
                  print("City: ${location.city}");
                  print("Country: ${location.country}");
                  print("State: ${location.state}");
                  print("Latitude: ${location.latitude}");
                  print("Longitude: ${location.longitude}");

                  myDealController.refresh();
                  myDealController.myDealsModel?.myDeals.clear();
                  getAddressFromLatLng(location.latitude, location.longitude);

                  setState(() {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            return Obx(() => myDealController.isLoadig.value
                                ? const Center(child: CircularProgressIndicator())
                                : Column(
                              children: [
                                const SizedBox(height: 60),
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
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: myDealController.myDealsModel?.myDeals?.isEmpty ?? true
                                      ? const Center(child: Text("No Deals Found"))
                                      : GridView.builder(
                                    padding: const EdgeInsets.all(18),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 20 / 24,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    itemCount: myDealController.myDealsModel?.myDeals.length ?? 0,
                                    itemBuilder: (BuildContext context, int index) {
                                      final deal = myDealController.myDealsModel!.myDeals[index];
                                      final price = int.tryParse(deal.price.toString()) ?? 0;
                                      final discount = int.tryParse(deal.discount.toString()) ?? 0;
                                      final discountedPrice = price - discount;

                                      return Padding(
                                        padding: const EdgeInsets.only(right: 4.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          elevation: 2.0,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Column(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: deal.roomImage ?? "",
                                                  placeholder: (context, url) => Center(
                                                    child: Image.network(
                                                      "https://raw.githubusercontent.com/prafful98/vue3-shimmer/HEAD/assets/card.gif",
                                                      fit: BoxFit.fill,
                                                      height: 120,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, error) => Center(
                                                    child: Image.network(
                                                      "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734",
                                                      fit: BoxFit.fill,
                                                      height: 125,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                  fit: BoxFit.fill,
                                                  height: 125,
                                                  width: double.infinity,
                                                ),
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20.0),
                                                  child: Text(
                                                    deal.title ?? "",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 20),
                                                    customTextCommon(
                                                      text: "₹$discountedPrice",
                                                      fSize: 14,
                                                      fWeight: FontWeight.w600,
                                                      color: const Color(0xffFB4967), lineHeight: 1,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      "₹${deal.price}",
                                                      style: const TextStyle(
                                                        decoration: TextDecoration.lineThrough,
                                                        fontSize: 14,
                                                        color: Color(0xffAAAAAA),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ));
                          },
                        );
                      },
                    );
                  });
                },
                visible: true,
              );
            }),
          ),
          onTap: (LatLng position) {},
          mapType: MapType.normal,
          onMapCreated: (controller) {
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
                        userMapeController.getAllUserMape(_searchController.text.trim());
                        changeCameraPosition(userMapeController.userBusinessMap[0].latitude, userMapeController.userBusinessMap[0].longitude);
                      },
                    ),
                  ),
                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    ));
  }
}
