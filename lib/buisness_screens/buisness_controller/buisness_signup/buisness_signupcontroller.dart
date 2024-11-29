import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:realdating/buisness_screens/buisness_controller/buisness_login/buisness_login.dart';
import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';

class BuisnessSignUpController extends GetxController {
  TextEditingController buisnessnameController = TextEditingController();
  TextEditingController bphonenoController = TextEditingController();
  TextEditingController bpasswordcontroller = TextEditingController();
  TextEditingController bconfirmpasscontroller = TextEditingController();
  TextEditingController bemailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  clearDataUser(){return{
    buisnessnameController.clear(),
    bphonenoController.clear(),
    bpasswordcontroller.clear(),
    bconfirmpasscontroller.clear(),
    bemailController.clear(),

    cityController.clear(),
    stateController.clear(),
    countryController.clear(),
    categoryController.clear(),
    addressController.clear(),

  };}
  RxBool isLoadig = false.obs;
  RxBool seePassword = true.obs;
  RxBool seePassword1 = true.obs;
  RxBool loadAddress = false.obs;
  RxString select = "Pick Value".obs;

  String? countryValue;
  String stateValue = " ";
  String? cityValue;

  void setSelected(String value) {
    select.value = value;
  }

  @override
  void onReady() {
    super.onReady();
  }
  Position? currentPosition;
  String? currentAddress;
  getCurrentLocation() async {
    loadAddress(true);
    print("entry===");
    ;   addressController.clear();
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    // Replace with your actual address

    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {

        currentPosition = position;
        getAddress(currentPosition!.latitude, currentPosition!.longitude);
        // Address? streetAddress = await FlutterAddressFromLatLng().getStreetAddress(
        //   latitude: _currentPosition!.latitude,
        //   longitude: _currentPosition!.longitude,
        //   googleApiKey: googleApiKey,
        // );


      print("closeinggggggg");
      print(loadAddress)
      ;
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {

      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {


          Placemark firstPlacemark = placemarks[0];
          currentAddress =
          "${firstPlacemark.street} ${firstPlacemark.subLocality}, ${firstPlacemark.locality},${firstPlacemark.country}";
          print("Address: $currentAddress");
addressController.text = currentAddress!;
   update();
        // buisbnesssignUpController.loadAddress=false.obs;
      } else {
        print("No address found for the given coordinates");
      }
      loadAddress(false);
    } catch (e) {
      print("Error getting address: $e");
    }
  }
  var manualLatitude;
  var manualLongitude;
  Future<void> getCoordinates(String address) async {
    try {
    // loadAddress=true.obs;
      List<Location> locations = await locationFromAddress(address);

      if (locations != null && locations.isNotEmpty) {
        Location firstLocation = locations[0];
        manualLatitude = firstLocation.latitude;
        manualLongitude = firstLocation.longitude;

        print("Latitude: $manualLatitude, Longitude: $manualLongitude");
      } else {
        print("No coordinates found for the given address");
      }
    } catch (e) {
      print("Error getting coordinates: $e");
    }
// loadAddress=true.obs;
  }
  BuisnesssignUpfunction(lat,long) async {
    print(cityValue);

    print("signwithBuissEmail");
    isLoadig(true);

    final response = await BaseClient01().post(
      Appurls.buisnesssignUp,
      {
        'business_name': '${buisnessnameController.value.text}',
        'phone_number': '${bphonenoController.value.text}',
        'email': '${bemailController.value.text}',
        'password': '${bpasswordcontroller.value.text}',
        'city': '${cityValue ?? "not found"}',
        'state': '${stateValue}',
        'country': "${countryValue}",
        'category': '${categoryController.value.text}',
        'address': '${addressController.text}',
        'latitude': '${lat??""}',
        'longitude': '${long??""}',
      },
    );

    print(response);
    isLoadig(false);
    bool success = response["success"];
    var msg = response["message"];

    if (success) {
      Get.off(() => BuisnessLogin());
      buisnessnameController.clear();
      bphonenoController.clear();
      bemailController.clear();
      bpasswordcontroller.clear();
      cityValue = null;
      stateValue = "";
      countryValue = null;
      categoryController.clear();
    }
    print("msg ___$msg");
    Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
