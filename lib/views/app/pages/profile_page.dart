import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/helpers/xlist.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Sizes.pageMargins,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Palette.seedColor,
                ),
                Text(
                  UserController().loggedInUser!.username,
                  style: Styles.titleAg25Semi(color: Palette.seedColor),
                ),
                Text(
                  UserController().loggedInUser!.email,
                  style: Styles.ag16Medium(),
                ),
              ].addSpacing(Sizes.spacingTiny),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
