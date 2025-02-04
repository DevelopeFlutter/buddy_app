import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:buddy_app/features/landing_page/widgets/app_network_image.dart';
import 'package:buddy_app/features/landing_page/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String profileImage;
  final String username;
  final String time;
  final int likes;
  final String caption;
  final String postImage;
  final int comments;
  final bool isLikedByCurrentUser;
  final VoidCallback onLikePressed;
  final VoidCallback postDetailPressed;

  PostWidget({
    required this.profileImage,
    required this.username,
    required this.time,
    required this.likes,
    required this.caption,
    required this.postImage,
    required this.comments,
    required this.isLikedByCurrentUser,
    required this.onLikePressed,
    required this.postDetailPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomAvatar(
                    radius: 33,
                    color: Colors.blue,
                    imgPath: profileImage,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 210,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          username,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 22,
                                fontFamily: AppTextStyles.arialRoundedMTBold)),
                      ),
                      const SizedBox(height: 5),
                      Text('$time  •  $likes Likes',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.withOpacity(0.6),
                              fontSize: 14,
                              fontFamily: AppTextStyles.arialUniCodeMs)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  AppAssetImage(
                    height: 24,
                    width: 24,
                    imagePath: AppIcons.menuIcon,
                    color: Colors.grey.withOpacity(0.3),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 12, left: 2),
            child: GestureDetector(
              onTap: postDetailPressed,
              child: Text(caption,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: AppTextStyles.arialUniCodeMs)),
            ),
          ),
          GestureDetector(
            onTap: postDetailPressed,
            child: postImage.startsWith('http') || postImage.startsWith('https')
                ? SizedBox(child: AppNetworkImage(imgPath: postImage))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Image.asset(postImage, fit: BoxFit.cover))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: onLikePressed,
                    child: AppAssetImage(
                      imagePath: AppIcons.likeIcon,
                      color: isLikedByCurrentUser ? Colors.blue : Colors.black,
                    )),
                const SizedBox(width: 3),
                Text('Liked',
                    style: TextStyle(
                        color:
                            isLikedByCurrentUser ? Colors.blue : Colors.black,
                        fontSize: 14,
                        fontFamily: AppTextStyles.arialUniCodeMs)),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: postDetailPressed,
                  child: Row(
                    children: [
                      AppAssetImage(
                        imagePath: AppIcons.commentIcon,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 3),
                      Text('$comments Comments',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: AppTextStyles.arialUniCodeMs)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Divider(
            color: Colors.grey.withOpacity(0.3),
            thickness: 3,
            endIndent: 60,
            indent: 80,
          ),
                    const SizedBox(height: 30),

        ],
      ),
    );
  }
}
