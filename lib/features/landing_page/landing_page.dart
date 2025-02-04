import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/model/user_model.dart';
import 'package:buddy_app/features/auth/services/auth_services.dart';
import 'package:buddy_app/features/detail_page/model/comments_model.dart';
import 'package:buddy_app/features/detail_page/post_detail_screen.dart';
import 'package:buddy_app/features/detail_page/services/comment_services.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:buddy_app/features/new_post/new_post_page.dart';
import 'package:buddy_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final User? loggedInUser;
  const LandingPage({super.key, this.loggedInUser});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late AuthService _authService;
  final CommentService _commentService = CommentService();
  User? _currentUser;
  List<User> _allUsers = [];
  List<Post> _userPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await Future.delayed(const Duration(seconds: 3)); 
    
    await _authService.loadUsers();
    await _authService.loadPosts();
    await _commentService.loadComments();

    _currentUser = widget.loggedInUser;

    if (_currentUser != null) {
      setState(() {
        _allUsers = _authService.getAllUsers();
        _allUsers.sort((a, b) => a.id == _currentUser!.id ? -1 : 1);
        _userPosts = _authService.getAllPosts();

        _isLoading = false;
      });
    }
  }

  void _toggleLike(Post post) {
    setState(() {
      if (post.likes.contains(_currentUser!.id)) {
        post.likes.remove(_currentUser!.id);
      } else {
        post.likes.add(_currentUser!.id);
      }
    });
  }

  void _onCommentAdded(Comment comment) {
    setState(() {
      _commentService.addComment(comment);
    });
  }

  String? newpost;
  @override
  Widget build(BuildContext context) {
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
                      final newPost = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreatePostScreen(userId: _currentUser!.id),
                        ),
                      );

                      if (newPost != null && newPost is Post) {
                        setState(() {
                          _userPosts.insert(0, newPost);
                        });
                      }
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
                      itemCount: _allUsers.length,
                      itemBuilder: (context, index) {
                        User user = _allUsers[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final selectedUser = _allUsers[index];
                                  List<Post> selectedUserPosts = _userPosts
                                      .where((post) => post.userId == selectedUser.id)
                                      .toList();
                                  final newPost = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          user: user,
                                          profileUser: _allUsers[index],
                                          currentUser: _currentUser,
                                          userPosts: selectedUserPosts),
                                    ),
                                  );
                                  if (newPost != null && newPost is Post) {
                                    setState(() {
                                      _userPosts.insert(0, newPost);
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      _allUsers[index].id == _currentUser?.id
                                          ? Colors.grey
                                          : Colors.green,
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
                                style:  TextStyle(
                                  color:  _allUsers[index].id == _currentUser?.id?Colors.grey:Colors.black,
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
                  ? const Center(child: const CircularProgressIndicator()) 
                  : ListView.builder(
                      itemCount: _userPosts.length,
                      itemBuilder: (context, index) {
                        Post post = _userPosts[index];
                        User? postUser = _allUsers.firstWhere(
                          (user) => user.id == post.userId,
                          orElse: () => User(
                            id: '',
                            name: 'Unknown',
                            email: '',
                            password: '',
                            followers: [],
                            following: [],
                            profileUrl: _currentUser!.profileUrl,
                          ),
                        );
                        List<Comment> comments =
                            _commentService.getCommentsForPost(post.id);
                        bool isLikedByCurrentUser =
                            post.likes.contains(_currentUser!.id);

                        return PostWidget(
                          profileImage: postUser.profileUrl,
                          username: postUser.name,
                          time: post.createdAt.toString(),
                          likes: post.likes.length,
                          caption: post.text,
                          postImage: post.image,
                          comments: comments.length,
                          isLikedByCurrentUser: isLikedByCurrentUser,
                          onLikePressed: () => _toggleLike(post),
                          postDetailPressed: () async {
                            final updatedPost = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  onCommentAdded: _onCommentAdded,
                                  allUsers: _allUsers,
                                  post: post,
                                  userProfileUrl: postUser.profileUrl,
                                  currentUser: _currentUser!,
                                  comments:
                                      _commentService.getCommentsForPost(post.id),
                                ),
                              ),
                            );
                            if (updatedPost != null) {
                              setState(() {
                                _userPosts[index] = updatedPost;
                              });
                            }
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
