import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/components/app_button.dart';
import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/detail_page/post_detail_screen.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/features/landing_page/post_provider.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/services/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? loggedInUser = Provider.of<AuthProvider>(context).loggeInUsers;
    List<Post>? allPosts = Provider.of<PostProvider>(context).allPosts;
    User? user = Provider.of<PostProvider>(context).profileUser;
    bool isFollow = user!.followers.contains(loggedInUser);
    List<Post>? userPosts = allPosts!.where((post) {
      return post.userId == user.id;
    }).toList();
    return Provider.of<PostProvider>(context).profileLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const AppAssetImage(
                              imagePath: AppIcons.backArrowIcon),
                        ),
                      ),
                      CustomAvatar(
                        radius: 35,
                        imgPath: user.profileUrl,
                      ),
                      const SizedBox()
                    ],
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        fontFamily: AppTextStyles.arialRoundedMTBold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Followers: ${user.followers.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(' | '),
                      Text(
                        'Following: ${user.following.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    height: 30,
                    onTap: () {
                      Provider.of<PostProvider>(context, listen: false)
                          .toggleFollow(user.id, loggedInUser!);
                    },
                    text: isFollow ? 'UNFOLLOW' : 'FOLLOW',
                    width: 135,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: AppTextStyles.arialRoundedMTBold,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userPosts.length,
                      itemBuilder: (context, index) {
                        Post post = userPosts[index];
                        final List<Comment>? countComment =
                            Provider.of<PostProvider>(context)
                                .getCommentById(post.id);

                        return PostWidget(
                          profileImage: user.profileUrl,
                          username: post.title,
                          time: post.createdAt.toString(),
                          likes: post.likes.length,
                          caption: post.text,
                          postImage: post.image,
                          comments: countComment!.length,
                          isLikedByCurrentUser:
                              post.likes.contains(loggedInUser),
                          onLikePressed: () {
                            Provider.of<PostProvider>(context, listen: false)
                                .toggleLike(post.id, loggedInUser!);
                          },
                          postDetailPressed: () {
                            Provider.of<PostProvider>(context, listen: false)
                                .setSelectedPost(post);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDetailScreen()));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
