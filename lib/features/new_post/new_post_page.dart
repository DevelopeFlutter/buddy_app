import 'dart:io';

import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/components/app_button.dart';
import 'package:buddy_app/features/auth/services/auth_provider.dart';
import 'package:buddy_app/features/landing_page/model/post_model.dart';
import 'package:buddy_app/features/landing_page/post_provider.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  File? _image;
  bool _isPosting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _createPost(String text, BuildContext context) async {
    if (text.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter text or select an image')),
      );
      return;
    }

    String formattedTime =
        "${DateTime.now().hour % 12 == 0 ? 12 : DateTime.now().hour % 12}:${DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}";
    String imageUrl = _image?.path ?? '';
    String loggedInUserId =
        Provider.of<AuthProvider>(context, listen: false).loggeInUsers!;

    Post newPost = Post(
      id: DateTime.now().toString(),
      title: 'New Post',
      text: text,
      image: imageUrl,
      userId: loggedInUserId,
      createdAt: formattedTime,
      likes: [],
    );

    await Provider.of<PostProvider>(context, listen: false).addNewPost(newPost);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const AppAssetImage(
                            imagePath: AppIcons.backArrowIcon,
                            color: Colors.black),
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        "Create a Post",
                        style: TextStyle(
                          fontFamily: AppTextStyles.arialRoundedMTBold,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppButton(
                        height: 35,
                        width: 85,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: AppTextStyles.arialRoundedMTBold,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        onTap: () {
                          _createPost(_controller.text, context);
                        },
                        text: 'POST',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write a post ....",
                        contentPadding: EdgeInsets.only(right: 90),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Image.asset(AppIcons.imgIcon)),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Provider.of<PostProvider>(context).createPostLoading
                ? const Center(child: Align(child: CircularProgressIndicator()))
                : const Center(),
            _image != null
                ? Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(_image!.path)),
                        ),
                        Positioned(
                          right: 10,
                          top: 3,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _image = null;
                              });
                            },
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(),
          ],
        ),
      ),
    );
  }
}
