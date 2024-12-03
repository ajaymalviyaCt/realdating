// class CategoryModel {
//   int id;
//   String name;
//   String coverImage;
//
//   CategoryModel({
//     required this.name,
//     required this.id,
//     required this.coverImage,
//   });
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//         name: json["name"],
//         id: json["id"],
//         coverImage: json["imageUrl"] ?? '',
//       );
// }
//
// class TvCategoryModel extends CategoryModel {
//   // int id;
//   // String name;
//
//   // String logo;
//   // String coverImage;
//
//   // List<CategoryModel> subCategories = [];
//
//   TvCategoryModel({
//     required String name,
//     required int id,
//     // required this.logo,
//     required String coverImage,
//
//     // required this.subCategories,
//   }) : super(name: name, id: id, coverImage: coverImage);
//
//   factory TvCategoryModel.fromJson(Map<String, dynamic> json) => TvCategoryModel(
//         name: json["name"],
//         id: json["id"],
//         // logo: json["logoUrl"] ?? 'https://images.unsplash.com/photo-1662286844552-81c31af1416c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
//         coverImage: json["imageUrl"],
//       );
// }
//
// class OffersCategoryModel extends CategoryModel {
//   int totalBusinesses;
//   int totalOffers;
//
//   OffersCategoryModel({
//     required String name,
//     required int id,
//     required String coverImage,
//     required this.totalBusinesses,
//     required this.totalOffers,
//   }) : super(name: name, id: id, coverImage: coverImage);
//
//   factory OffersCategoryModel.fromJson(Map<String, dynamic> json) => OffersCategoryModel(
//         name: json["name"],
//         id: json["id"],
//         coverImage: json["imageUrl"],
//         totalBusinesses: json["total_business"],
//         totalOffers: json["total_coupon"],
//       );
// }
//
// class FundRaisingCampaignCategoryModel extends CategoryModel {
//   FundRaisingCampaignCategoryModel({
//     required String name,
//     required int id,
//     required String coverImage,
//   }) : super(name: name, id: id, coverImage: coverImage);
//
//   factory FundRaisingCampaignCategoryModel.fromJson(Map<String, dynamic> json) => FundRaisingCampaignCategoryModel(
//         name: json["name"],
//         id: json["id"],
//         // logo: json["logoUrl"] ?? 'https://images.unsplash.com/photo-1662286844552-81c31af1416c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
//         coverImage: json["imageUrl"],
//       );
// }
