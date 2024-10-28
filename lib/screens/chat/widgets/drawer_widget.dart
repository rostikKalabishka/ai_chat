import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Drawer(
          child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'History'),
              ),
            ),
            Divider(),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('dasdasdasdsa dsaads')
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
