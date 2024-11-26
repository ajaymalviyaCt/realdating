import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import 'mapeModel.dart';

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

  getAllUserMape(String search) async {
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
        (await NetworkAssetBundle(Uri.parse("https://fastly.picsum.photos/id/349/200/300.jpg?hmac=gEjHZbjuKtdD2GOM-qQtuaA95TCvDUs6iVvKraQ94nU")).load("https://fastly.picsum.photos/id/349/200/300.jpg?hmac=gEjHZbjuKtdD2GOM-qQtuaA95TCvDUs6iVvKraQ94nU"))
            .buffer
            .asUint8List();
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(37.7749, -122.4194),
        infoWindow: InfoWindow(
          title: 'San Francisco',
          snippet: 'An interesting city!',
        ),
        icon: await TextOnImage(
          bytes: bytes,
        ).toBitmapDescriptor(),
      ),
    );
    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(37.7749, -122.4194)));
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

class TextOnImage extends StatelessWidget {
  const TextOnImage({super.key, required this.bytes});

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
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "https://fastly.picsum.photos/id/349/200/300.jpg?hmac=gEjHZbjuKtdD2GOM-qQtuaA95TCvDUs6iVvKraQ94nU",
              width: 70,
              height: 70,
            ),
          ),
        )
      ],
    );
  }
}
