

import 'package:realdating/widgets/custom_appbar.dart';

import '../../reel/common_import.dart';

import 'package:flutter/material.dart';

import 'mapeModel.dart';


class BusinessDetailsPage extends StatelessWidget {
  final Bussiness business;

  const BusinessDetailsPage({Key? key, required this.business}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(business.businessName.toString(), context),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: business.allDeals!.length,
        itemBuilder: (context, index) {
          final deal = business.allDeals![index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width/1,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Deal Image
                  deal.roomImage != null
                      ? Container(
                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                      child: Image.network(deal.roomImage.toString(), width: double.infinity, fit: BoxFit.cover))
                      : Image.network('${deal.roomImage}', width: double.infinity, fit: BoxFit.cover),
                  const SizedBox(height: 16),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           deal.title.toString(),
                           style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold),
                         ),
                         const SizedBox(height:2),
                         Text(
                           'Price: ${deal.price}',
                           style: const TextStyle(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.w500),
                         ),
                         const SizedBox(height:5),
                         const Text(
                           'Discount:',
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                         ),
                         const SizedBox(height: 4),
                         Text(
                           '${deal.discount}',
                           style: const TextStyle(fontSize: 16),
                         ),
                         const SizedBox(height: 16),
                       ],
                     )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


