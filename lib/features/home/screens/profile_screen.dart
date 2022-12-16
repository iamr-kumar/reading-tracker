import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/profile_list_tile.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/theme/pallete.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          user.photoURL != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: NetworkImage(user.photoURL!),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ))
              : CircleAvatar(
                  backgroundColor: Pallete.primaryBlue,
                  minRadius: 50,
                  child: Text(
                    user.name[0] + user.name.split(' ')[1][0],
                    style: const TextStyle(color: Pallete.white),
                  ),
                ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
                color: Pallete.primaryBlue,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ProfileListTile(
              title: 'My Account', leading: FeatherIcons.user, onTap: () {}),
          const SizedBox(height: 16),
          ProfileListTile(
              title: 'Settings', leading: FeatherIcons.settings, onTap: () {}),
          const SizedBox(height: 16),
          ProfileListTile(
              title: 'Log Out',
              leading: FeatherIcons.logOut,
              onTap: () => logout(ref),
              isLogout: true),
          const SizedBox(height: 16),
        ],
      ),
    )));
  }
}
