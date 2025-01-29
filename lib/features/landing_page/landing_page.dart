import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/landing_page/widgets/app_asset_image.dart';
import 'package:buddy_app/features/landing_page/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BUDDY APP",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: AppTextStyles.arialRoundedMTBold),
                  ),
                  AppAssetImage(imagePath: AppIcons.addIcon),
                  
                ],
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.green,
                                          radius: 43,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                                          radius: 40,
                            child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 38,
                                          // backgroundImage: AssetImage(['image']!),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Name', style: TextStyle(fontSize: 12)),
                       
                      ],
                    ),
                  );
                },
              ),
            ),
         const PostWidget(
  profileImage: 'assets/bebe.jpg',
  username: 'Bebe Rexha',
  time: '12:23AM',
  likes: 21,
  caption: 'Enjoyed my day and a very historic castle',
  postImage: 'assets/castle.jpg',
  comments: 10,
)

          ],

        ),
      ),
    );
  }
}
