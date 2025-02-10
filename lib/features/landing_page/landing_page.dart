import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/auth/services/auth_services.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/detail_page/post_detail_screen.dart';
import 'package:buddy_app/features/detail_page/services/comment_services.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/features/landing_page/post_provider.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:buddy_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isLoading = false;

  @override
  void initState() {
    var data = Provider.of<PostProvider>(context, listen: false);
    data.getAllPosts();
    data.getAllUsers();
    data.getComments();
    super.initState();
  }

  String? newpost;
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final posts = postProvider.allPosts ?? [];
    final users = postProvider.allUsers ?? [];
    String? loggeInUserId = Provider.of<AuthProvider>(context).loggeInUsers;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "BUDDY APP",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        fontFamily: AppTextStyles.arialRoundedMTBold),
                  ),
                  GestureDetector(
                    onTap: () async {
                      // final newPost = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         CreatePostScreen(userId: _currentUser!.id),
                      //   ),
                      // );

                      // if (newPost != null && newPost is Post) {
                      //   setState(() {
                      //     _userPosts.insert(0, newPost);
                      //   });
                      // }
                    },
                    child: const AppAssetImage(
                      imagePath: AppIcons.addIcon,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 130,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User user = users[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Provider.of<PostProvider>(context,listen: false)
                                      .getProfileUser(user.id);

                                  // Navigator.push (context, MaterialPageRoute(
                                  //     builder: (context) => ProfileScreen(

                                  // )));
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      users[index].id == loggeInUserId
                                          ? Colors.grey
                                          : const Color.fromARGB(255, 103, 131, 104),
                                  radius: 42,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 39,
                                    child: CustomAvatar(
                                      radius: 37,
                                      imgPath: user.profileUrl,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.name,
                                style: TextStyle(
                                  color: users[index].id == loggeInUserId
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppTextStyles.arialUniCodeMs,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        Post post = posts[index];
                        User? postUser = users.firstWhere(
                          (user) => user.id == post.userId,
                          orElse: () => User(
                            id: '',
                            name: 'Unknown',
                            email: '',
                            password: '',
                            followers: [],
                            following: [],
                            profileUrl: '',
                          ),
                        );

                        List<Post> userLikedPosts = posts
                            .where((post) => post.likes.contains(loggeInUserId))
                            .toList();

                        List<Comment>? comments =
                            postProvider.getCommentById(post.id);

                        return Consumer<PostProvider>(
                            builder: (context, postProvider, child) {
                          return PostWidget(
                            profileImage: postUser.profileUrl,
                            username: postUser.name,
                            time: post.createdAt.toString(),
                            likes: post.likes.length,
                            caption: post.text,
                            postImage: post.image,
                            comments: comments!.length,
                            isLikedByCurrentUser:
                                post.likes.contains(loggeInUserId),
                            onLikePressed: () => postProvider.toggleLike(
                                post.id, loggeInUserId!),
                            postDetailPressed: () async {
                              Provider.of<PostProvider>(context, listen: false)
                                  .setSelectedPost(post);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PostDetailScreen()));
                            },
                          );
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
