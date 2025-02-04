import 'package:buddy_app/constants/app_icons.dart';
import 'package:buddy_app/features/landing_page/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final double radius;
  final String imgPath;
  final Color color;
  final Widget child;

   const CustomAvatar(
      {super.key,
      this.imgPath = AppIcons.img2,
      required this.radius,
      this.color = Colors.white,
      this.child =const Center(),
      });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
      child:ClipOval(
        child: AppNetworkImage(imgPath: imgPath),
       
         
      ),
     
    );
  }
}
