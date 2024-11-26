import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import 'mapeModel.dart';
import 'nearby_bussiness_location.dart';

class MapeUserController extends GetxController implements GetxService {
  final RxSet<Marker> markers = RxSet();
  GoogleMapController? mapController;

  @override
  void onReady() {
    super.onReady();
    // print("onReady getAllUsersPost");
    getAllUserMape(search ?? "");
  }

  var search;
  var userProfileImage;

  void getAllUserMape(String search) async {
    Map<String, dynamic> apiData = await ApiCall.instance.callApi(
        url: "https://forreal.net:4000/users/nearByBussiness",
        headers: await authHeader(),
        method: HttpMethod.POST,
        body: {
          "user_id": await getUserId(),
          "search": search,
        },
        dismissKeyBoard: false);
    MapeBusinessModel mapeBusinessModel = MapeBusinessModel.fromJson(apiData);

    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(mapeBusinessModel.bussiness[0].profileImage)).load(mapeBusinessModel.bussiness[0].profileImage))
            .buffer
            .asUint8List();
    markers.clear();
    for (int i = 0; i < mapeBusinessModel.bussiness.length; i++) {  markers.add(
      Marker(
        markerId: MarkerId((mapeBusinessModel.bussiness.first.latitude,mapeBusinessModel.bussiness.first.longitude).toString()),
        position: LatLng(double.tryParse(mapeBusinessModel.bussiness[i].latitude) ?? 22.0,
            double.tryParse(mapeBusinessModel.bussiness[i].longitude) ?? 22.0),
        onTap: () {
          Get.to(const NearByBusinessList());
        },
        // infoWindow: InfoWindow(
        //   title: 'San Francisco',
        //   snippet: 'An interesting city!',
        // ),
        icon: await MarerWidget(
          bytes: bytes,
        ).toBitmapDescriptor(),
      ),
    );

    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(mapeBusinessModel.bussiness.first.latitude),double.parse(mapeBusinessModel.bussiness.first.longitude))));
      // Set<Marker>.from(mapeBusinessModel.bussiness.map((e) {
      //
      //   return markers.add(Marker(
      //     markerId: MarkerId((mapeBusinessModel.bussiness.first.latitude,mapeBusinessModel.bussiness.first..longitude).toString()),
      //     position: LatLng(double.tryParse(mapeBusinessModel.bussiness[i].latitude) ?? 22.0,
      //         double.tryParse(mapeBusinessModel.bussiness[i].longitude) ?? 22.0),
      //     icon: BitmapDescriptor.fromBytes(resizeImage(bytes, 300, 300)!), //Icon for Marker
      //   ));
      // }));
    }






  }

/*
  addMarkers() async {
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl)).buffer.asUint8List();

    Uint8List? smallimg = resizeImage(bytes, 150, 150);
    for (int i = 0; i < userMapeController.userBusinessMap.length; i++) {
      Set<Marker>.from(userMapeController.userBusinessMap.map((e) {
        return markers.add(Marker(
          markerId: MarkerId((_currentPosition?.latitude ?? 20.5937, _currentPosition?.longitude ?? 78.9629).toString()),
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

    setState(() {});
  }
  */
}

class MarerWidget extends StatelessWidget {
  const MarerWidget({super.key, required this.bytes});

  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/bg_profile.svg",
          width: 100,
          height: 100,
        ),
        Positioned(
          top: 8.5,
          left: 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.memory(
              fit: BoxFit.cover,
              bytes,
              width: 70,
              height: 70,
            ),
          ),
        )
      ],
    );
  }
}
