import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/components/app_button.dart';
import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/auth/services/auth_services.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/detail_page/services/comment_services.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final User? currentUser;
  final User profileUser;
  final List<Post> userPosts;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.profileUser,
    required this.currentUser,
    required this.userPosts,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CommentService _commentService = CommentService();
  late AuthProvider _authService;
  List<Post> _userPosts = [];
  bool isFollowing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _commentService.getCommentsForPost(widget.user.id);
    loadComments();

    _authService = AuthProvider();
    _loadUserPosts();

    setState(() {
      isFollowing = widget.user.followers.contains(widget.currentUser!.id);
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void loadComments() async {
    await _commentService.loadComments();
  }

  Future<void> _loadUserPosts() async {
    // await _authService.loadPosts();
    setState(() {
      _userPosts = widget.userPosts;
    });
  }

  void _toggleLike(Post post) {
    setState(() {
      if (post.likes.contains(widget.user.id)) {
        post.likes.remove(widget.user.id);
      } else {
        post.likes.add(widget.user.id);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child:
                        const AppAssetImage(imagePath: AppIcons.backArrowIcon),
                  ),
                ),
                CustomAvatar(
                  radius: 35,
                  imgPath: widget.user.profileUrl,
                ),
                const SizedBox()
              ],
            ),
            Text(
              widget.user.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontFamily: AppTextStyles.arialRoundedMTBold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Followers: ${widget.user.followers.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(' | '),
                Text(
                  'Following: ${widget.user.following.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppButton(
              height: 30,
              onTap: () {
                setState(() {
                  if (widget.currentUser!.id != widget.profileUser.id) {
                    isFollowing = !isFollowing;
                    if (isFollowing) {
                      widget.currentUser!.following.add(widget.profileUser.id);
                      widget.profileUser.followers.add(widget.currentUser!.id);
                    } else {
                      widget.currentUser!.following
                          .remove(widget.profileUser.id);
                      widget.profileUser.followers
                          .remove(widget.currentUser!.id);
                    }
                  }
                });
              },
              text: isFollowing ? 'UnFollow' : 'FOLLOW',
              width: 135,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: AppTextStyles.arialRoundedMTBold,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 50),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _userPosts.length,
                      itemBuilder: (context, index) {
                        Post post = _userPosts[index];
                        List<Comment> comments =
                            _commentService.getCommentsForPost(post.id);
                        bool isLikedByCurrentUser =
                            post.likes.contains(widget.currentUser!.id);
                        return PostWidget(
                          profileImage: widget.user.profileUrl,
                          username: post.title,
                          time: post.createdAt.toString(),
                          likes: post.likes.length,
                          caption: post.text,
                          postImage: post.image,
                          comments: comments.length,
                          isLikedByCurrentUser: isLikedByCurrentUser,
                          onLikePressed: () => _toggleLike(post),
                          postDetailPressed: () {},
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
