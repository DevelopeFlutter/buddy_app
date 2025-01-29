import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String profileImage;
  final String username;
  final String time;
  final int likes;
  final String caption;
  final String postImage;
  final int comments;

  const PostWidget({
    required this.profileImage,
    required this.username,
    required this.time,
    required this.likes,
    required this.caption,
    required this.postImage,
    required this.comments,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    // backgroundImage: AssetImage(profileImage),
                  ),
                   const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('$time  •  $likes Likes'),
                ],
              ),
                ],
              ),

                           const Row(
                             children: [
                               Icon(Icons.more_vert),
                             ],
                           ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(caption),
          ),
          // const SizedBox(height: 10),
          // Image.asset(postImage, fit: BoxFit.cover),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             
                AppAssetImage(imagePath:AppIcons.likeIcon ),
               
               Text('Liked'),
              const SizedBox(width: 10),
             
               AppAssetImage(imagePath: AppIcons.commentIcon),
               
              Text('$comments Comments'),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
