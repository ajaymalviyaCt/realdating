

import '../../reel/common_import.dart';

import 'package:flutter/material.dart';

import 'mapeModel.dart';
import 'model.dart';


// class NearByBusinessList extends StatefulWidget {
//   MapeBusinessModel? businessDeal;
//   NearByBusinessList({super.key,this.businessDeal});
//
//   @override
//   State<NearByBusinessList> createState() => _NearByBusinessListState();
// }
//
// class _NearByBusinessListState extends State<NearByBusinessList> {
//   late Future<GetNearByBusinessListModel> futureBusinessList;
//
//   @override
//   void initState() {
//     super.initState();
//     futureBusinessList = fetchBusinessList();
//   }
//
//   Future<GetNearByBusinessListModel> fetchBusinessList() async {
//     var headers = {
//       'Authorization': 'Bearer your_token',
//       'content-type': 'application/json',
//     };
//     var data = json.encode({"user_id": 94, "search": ""});
//     var dio = Dio();
//     var response = await dio.request(
//       'https://forreal.net:4000/users/nearByBussiness',
//       options: Options(
//         method: 'POST',
//         headers: headers,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       return GetNearByBusinessListModel.fromJson(response.data);
//     } else {
//       throw Exception('Failed to load business list');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Nearby Businesses')),
//       body: FutureBuilder<GetNearByBusinessListModel>(
//         future: futureBusinessList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final businessList = snapshot.data!.bussiness;
//             return ListView.builder(
//               itemCount: businessList.length,
//               itemBuilder: (context, index) {
//                 final business = businessList[index];
//                 return ListTile(
//                   leading: Image.network(business.profileImage, width: 50, height: 50, fit: BoxFit.cover),
//                   title: Text(business.businessName),
//                   subtitle: Text(business.category),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BusinessDetailsPage(business: business),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }


// class BusinessDetailsPage extends StatelessWidget {
//   final MapeBusinessModel business;
//
//   const BusinessDetailsPage({Key? key, required this.business}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(business.bussiness!.first.allDeals!.first.title.toString()),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Cover Photo or Profile Image
//             business.coverPhoto != null
//                 ? Image.network(business.coverPhoto!, width: double.infinity, fit: BoxFit.cover)
//                 : Image.network('${business.profileImage.toString()}', width: double.infinity, fit: BoxFit.cover),
//             const SizedBox(height: 16),
//
//             // Business Name
//             Text(
//               business.businessName,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//
//             // Business Category
//             Text(
//               'Category: ${business.category}',
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 16),
//
//             // Address
//             const Text(
//               'Address:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '${business.address}, ${business.city}, ${business.state}, ${business.country}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//
//             /// Description
//             if (business.description != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Description:',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     business.description!,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//
//             // Social Media Links
//             if (business.instagramLink != null ||
//                 business.twitterLink != null ||
//                 business.facebookLink != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Social Links:',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   if (business.instagramLink != null)
//                     TextButton(
//                       onPressed: () {
//                         // Handle Instagram link
//                       },
//                       child: Text('Instagram: ${business.instagramLink}'),
//                     ),
//                   if (business.twitterLink != null)
//                     TextButton(
//                       onPressed: () {
//                         // Handle Twitter link
//                       },
//                       child: Text('Twitter: ${business.twitterLink}'),
//                     ),
//                   if (business.facebookLink != null)
//                     TextButton(
//                       onPressed: () {
//                         // Handle Facebook link
//                       },
//                       child: Text('Facebook: ${business.facebookLink}'),
//                     ),
//                 ],
//               ),
//
//             // Website
//             if (business.website != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Website:',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   TextButton(
//                     onPressed: () {
//                       // Open website link
//                     },
//                     child: Text(business.website!),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

