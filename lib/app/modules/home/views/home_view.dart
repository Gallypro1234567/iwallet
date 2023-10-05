import 'package:flutter/material.dart';
import 'package:iwallet/app/common/help_function.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    thousandSeparator('0', unit: 'đ'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.notifications),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    'Total balance',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
