import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../setting/settings_page.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // profileController.profileDaitails();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ));
                },
                child: SvgPicture.asset('assets/icons/settings.svg')),
          ),
        ],
      ),
      body: Obx(
            () =>
        profileController.isLoadig.value
            ? const Center(
            child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            CachedNetworkImage(
              imageUrl: profileController.profileImage.value,
              imageBuilder: (context, imageProvider) =>
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: imageProvider,
                  ),
              placeholder: (context, url) =>
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: SvgPicture.asset(
                            "assets/icons/Profile_02.svg"),
                      ),
                    ),
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${profileController.firstName.value} ${profileController
                    .lastName.value}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Obx(
                    () =>
                    Text(
                      "@${profileController.username.value}",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFB4967)),
                    ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Unique Name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffAAAAAA)),
                ),
                const SizedBox(height: 8),
                Text(
                  profileController.username.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                /*const SizedBox(height: 15),
                      const Text(
                        "Email Address",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffAAAAAA)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profileController.email.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),*/
                const SizedBox(height: 15),
                const Text(
                  "Address",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffAAAAAA)),
                ),
                const SizedBox(height: 8),
                Text(profileController.profileModel?.userInfo.address == "0"
                    ? "33 street  United State"
                    : profileController.profileModel!.userInfo.address
                    .toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                const Text(
                  "Real Reveal",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffAAAAAA)),
                ),
                const SizedBox(height: 8),
                Text("Total Reveal = 10",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),


                const SizedBox(height: 8),
                Text("Remaining Reveal = 8",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Uploads Pictures",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffAAAAAA)),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 300,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileController
                          .profileModel?.userInfo.images.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 5),
                      itemBuilder: (ctx, index) {
                        final data = profileController
                            .profileModel?.userInfo.images[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: data?.profileImages ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.person_2_outlined),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }


  final speedNotifier = ValueNotifier<double>(1);
}