import 'package:realdating/reel/common_import.dart';

import '../../../function/function_class.dart';
import '../../../home_page_new/home_page_new_controller.dart';
import 'homepage_bussiness_controller.dart';

class BCommentPage extends StatefulWidget {
  final String postId;
  final String userId;
  final int indexxx;
  const BCommentPage({super.key, required this.postId,required this.userId,required this.indexxx});

  @override
  State<BCommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<BCommentPage> {

  HomepageBusinessController BhomepageBusinessController =Get.put(HomepageBusinessController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BhomepageBusinessController.getAllCommentBYpostID(postID: widget.postId, indexx: widget.indexxx, alreadlyLoad: true );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Comments"),
          centerTitle: true,
          backgroundColor: Colors.white),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 0, bottom: 0, top: 0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey)),
                    child: TextField(
                      controller: BhomepageBusinessController.commentsController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: ' Add a comment...',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: TextButton(
                  onPressed: () async {
                    // postsC.homePageModel.posts[1].totalComments=333;
                    // postsC.homePagetModelNOTUSE.value.posts[widget.indexxx].totalComments=234;
                    // print("totalComments${postsC.homePagetModelNOTUSE.value.posts[1].totalComments}");
                    // postsC.homePagetModelNOTUSE.refresh();

                    FocusScope.of(context).unfocus();
                    EasyLoading.show(status: "Post Comment");
                    BhomepageBusinessController.postComments(widget.postId, BhomepageBusinessController.commentsController.text,widget.userId,widget.indexxx);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      fontSize: 18,
                      color: Appcolor.Redpink,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Aboshi",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Obx(
          () => BhomepageBusinessController.isLoadingCommentList.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: BhomepageBusinessController.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "${BhomepageBusinessController.comments[index].commentOwnerName}"),
                      subtitle: Text(
                          "${BhomepageBusinessController.comments[index].postComment}"),
                      leading: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(35)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: CachedNetworkImage(
                              imageUrl: BhomepageBusinessController
                                  .comments[index].profileImage
                                  .toString(),
                              placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ))),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person_2_outlined),
                              filterQuality: FilterQuality.low,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // leading: ClipRRect(
                      //   borderRadius: BorderRadius.circular(45),
                      //     child: SizedBox(
                      //         height: 45,width: 45,
                      //         child: Image.network("${homePageNewController.posts[widget.index22].comments![index].profileImage}",fit: BoxFit.cover,))),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
