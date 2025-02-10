import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/auth/services/auth_services.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/landing_page/post_provider.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({
    super.key,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController _commentController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? loggedInUserId = Provider.of<AuthProvider>(context).loggeInUsers;

    var post = Provider.of<PostProvider>(context).selectedPost;
    var user = Provider.of<PostProvider>(context).selectedUser;

    List<Comment>? comments;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(AppIcons.backArrowIcon),
                        ),
                      ),
                      const Text(
                        'Post',
                        style: TextStyle(
                            fontFamily: AppTextStyles.arialRoundedMTBold,
                            fontSize: 22,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Consumer<PostProvider>(
                          builder: (context, postPrvider, child) {
                          comments = postPrvider.getCommentById(post!.id);
                          return PostWidget(
                            profileImage: user!.profileUrl,
                            username: post.title,
                            time: post.createdAt.toString(),
                            likes: post.likes.length,
                            caption: post.text,
                            postImage: post.image,
                            comments: comments!.length,
                            isLikedByCurrentUser:
                                post.likes.contains(loggedInUserId),
                            onLikePressed: () {
                              postPrvider.toggleLike(post.id, loggedInUserId!);
                            },
                            postDetailPressed: () {},
                          );
                        }),
                  Expanded(
                    child: _isLoading
                        ? const SizedBox.shrink()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Consumer<PostProvider>(
                                    builder: (context, postProvider, child) {
                                  final comments =
                                      postProvider.getCommentById(post!.id);
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: comments!.length,
                                    itemBuilder: (context, index) {
                                      final comment = comments[index]; 
                                  final user =
                                          Provider.of<PostProvider>(context)
                                              .getUserById(comment.userId);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            CustomAvatar(
                                                radius: 15,
                                                imgPath: user!.profileUrl),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline:
                                                    TextBaseline.ideographic,
                                                children: [
                                                  Text(user.name,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: AppTextStyles
                                                              .arialUniCodeMs)),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 10),
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.start,
                                                      comment.text,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: AppTextStyles
                                                              .arialUniCodeMs),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                hintText: "Add a comment...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (_commentController.text.isNotEmpty) {
                              Provider.of<PostProvider>(context, listen: false)
                                  .addComment(post!.id, loggedInUserId!,
                                      _commentController.text);
                              _commentController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ]))),
      ),
    );
  }
}
