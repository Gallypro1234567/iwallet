import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/widgets/app_cached_network_image.dart';
import 'package:iwallet/app/widgets/app_list_tile.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = ProfileController();
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                    width: .5, color: Theme.of(context).dividerColor),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  AppCachedNetworkImage(
                    size: const Size(60, 60),
                    url: controller.user?.photoURL ?? '',
                    shape: BoxShape.circle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    controller.user?.displayName ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    controller.user?.email ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            AppListTitle(
              title: 'My account',
              subtitle: 'Free account',
              leading: const Icon(Icons.person),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context).iconTheme.color!.withOpacity(0.2),
              ),
              border: false,
            ),
            const SizedBox(height: 40.0),
            ...[
              {
                'title': 'Dark Mode',
                'icon': Icons.dark_mode,
                'trailing': Obx(
                  () => CupertinoSwitch(
                    value: controller.isDarkMode.value,
                    onChanged: (v) => controller.onChangeModeTheme(),
                  ),
                ),
                'action': () {
                  controller.onChangeModeTheme();
                },
              },
              {'title': 'Help & Support', 'icon': Icons.help},
              {'title': 'Settings', 'icon': Icons.settings},
              {'title': 'About', 'icon': Icons.info}
            ]
                .map((e) => AppListTitle(
                      title: e['title'] as String,
                      leading: Icon(e['icon'] as IconData),
                      trailing: (e['trailing'] as Widget?) ??
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.2),
                          ),
                      onPressed: e['action'] as Function()?,
                    ))
                .toList(),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: controller.onLogOut,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Đăng xuất',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14, color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
