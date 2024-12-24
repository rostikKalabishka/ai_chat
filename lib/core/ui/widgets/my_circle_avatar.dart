import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({
    super.key,
    required this.userImage,
    this.radius,
    this.width,
    this.height,
  });

  final String userImage;
  final double? radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: SizedBox.expand(
          child: userImage != ''
              ? Image.network(
                  userImage,
                  fit: BoxFit.cover,
                  width: width,
                  height: width,
                )
              : Image.asset(
                  AssetsManager.userImage,
                  fit: BoxFit.cover,
                  width: width,
                  height: width,
                ),
        ),
      ),
    );
  }
}
