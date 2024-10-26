import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Flexible(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('history $index'),
                );
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                child: ClipOval(
                  child: Image.asset(
                    AssetsManager.userImage,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('dasdasdasdsa dsaads')
            ],
          ),
        )
      ],
    ));
  }
}
