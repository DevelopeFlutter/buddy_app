import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  final String userProfileUrl;
  final User currentUser;
  final List<Comment> comments;
  final List<User> allUsers;
  final Function(Comment) onCommentAdded;

  const PostDetailScreen({
    super.key,
    required this.post,
    required this.userProfileUrl,
    required this.currentUser,
    required this.comments,
    required this.allUsers,
    required this.onCommentAdded,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController _commentController = TextEditingController();

  late Post post;
  late bool isLiked;
  bool _isLoading = true; 

  @override
  void initState() {
    super.initState();
    post = widget.post;
    isLiked = post.likes.contains(widget.currentUser.id);

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false; 
      });
    });
  }

  User getUserById(String userId) {
    return widget.allUsers.firstWhere((user) => user.id == userId,
        orElse: () => User(
            id: '',
            name: 'Unknown',
            profileUrl: '',
            email: '',
            password: '',
            followers: [],
            following: []));
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        post.likes.remove(widget.currentUser.id);
      } else {
        post.likes.add(widget.currentUser.id);
      }
      isLiked = !isLiked;
    });
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      String commentText = _commentController.text.trim();
      Comment newComment = Comment(
        id: DateTime.now().toString(),
        text: commentText,
        parentPostId: widget.post.id,
        userId: widget.currentUser.id,
      );

      setState(() {
        widget.comments.add(newComment);
      });

      widget.onCommentAdded(newComment);

      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Post post = widget.post;
    return Scaffold(
          resizeToAvoidBottomInset: true,

      bottomNavigationBar: Padding(
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
              onPressed: _addComment,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:ConstrainedBox(
             constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
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
                    : PostWidget(
                        profileImage: widget.userProfileUrl,
                        username: post.title,
                        time: post.createdAt.toString(),
                        likes: post.likes.length,
                        caption: post.text,
                        postImage: post.image,
                        comments: widget.comments.length,
                        isLikedByCurrentUser: isLiked,
                        onLikePressed: _toggleLike,
                        postDetailPressed: () {},
                      ),
                Expanded(
                  child: _isLoading
                      ? const SizedBox.shrink()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.comments.length,
                                itemBuilder: (context, index) {
                                  Comment comment = widget.comments[index];
                                  User commentUser = getUserById(comment.userId);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      children: [
                                        CustomAvatar(
                                          radius: 15,
                                          imgPath: commentUser.profileUrl,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.ideographic,
                                            children: [
                                              Text(commentUser.name,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: AppTextStyles.arialUniCodeMs)),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(left: 5, right: 10),
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  textAlign: TextAlign.start,
                                                  comment.text,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: AppTextStyles.arialUniCodeMs),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
