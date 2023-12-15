import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myproject_app/models/user.dart';
import 'package:myproject_app/ui/products/product_manager_screen.dart';
import 'package:myproject_app/ui/users/user_manager.dart';
import 'package:provider/provider.dart';

import '../auth/auth_manager.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile(this.user, {super.key});

  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userManager = UsersManager();
    return Consumer<UsersManager>(builder: (context, userManager, child) {
      return Scaffold(
        body: Center(
            child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 16)),
            Container(
              width: 200,
              height: 200,
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(
                      side: BorderSide(
                    width: 2,
                    color: Color(0xff242f60),
                  ))),
              child: ClipOval(
                child: Image.network(userManager.users[0].avatarUrl),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              userManager.users[0].fullname,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              width: 220,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProfile.routeName,
                        arguments: userManager.users[0].id);
                  },
                  child: const Text(
                    'Chỉnh sửa hồ sơ',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  )),
            ),
            Container(
              width: 220,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ProductManagerScreen.routeName);
                  },
                  child: const Text(
                    'Quản lý sản phẩm',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  )),
            ),
            Container(
              width: 220,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                      .pushReplacementNamed('/');
                    context.read<AuthManager>().logout();
                  },
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Color(0xfff64c72),
                      fontSize: 20,
                    ),
                  )),
            ),
          ],
        )),
      );
    });
  }
}
