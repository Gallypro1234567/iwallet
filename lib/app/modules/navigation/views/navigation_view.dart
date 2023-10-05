// ignore_for_file: dead_code

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iwallet/app/common/help_function.dart';
import 'package:iwallet/app/modules/budget/views/budget_view.dart';
import 'package:iwallet/app/modules/home/views/home_view.dart';
import 'package:iwallet/app/modules/profile/views/profile_view.dart';
import 'package:iwallet/app/modules/transaction/views/transaction_view.dart';
import 'package:iwallet/app/modules/transaction_submit/views/transaction_submit_view.dart';
import 'package:iwallet/app/routes/app_pages.dart';
import 'package:iwallet/app/widgets/app_button.dart';
import 'package:iwallet/app/widgets/app_input.dart';
import 'package:iwallet/app/widgets/app_list_tile.dart';
import 'package:iwallet/app/widgets/app_picker_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final controller = NavigationController();
  bool checkChangeIndex = false;
  int _exportIndexed(String route) {
    checkChangeIndex = true;

    switch (route) {
      // case Routes.HOME:
      //   return 0;
      case Routes.TRANSACTION:
        return 0;
      // case Routes.BUDGET:
      //   return 2;
      case Routes.PROFILE:
        return 1;
      default:
        return 0;
    }
  }

  Widget _buildMenuItem(String route) {
    String title = '';
    String svgIcon = '';
    IconData? activeIcon;
    IconData? unActiveIcon;
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.light;
    bool isActive = false;
    Color color = Get.isDarkMode ? Colors.white : Colors.black;

    if (route == controller.selected.value) {
      isActive = true;
    } else {
      isActive = false;
    }
    switch (route) {
      case Routes.HOME:
        title = 'Home';
        svgIcon = 'assets/icons/tabs/tab-home.svg';
        activeIcon = Icons.home;
        unActiveIcon = Icons.home_outlined;
        //systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        break;
      case Routes.TRANSACTION:
        title = 'Transactions';
        svgIcon = 'assets/icons/tabs/tab-transactions.svg';
        activeIcon = Icons.account_balance_wallet;
        unActiveIcon = Icons.account_balance_wallet_outlined;
        //systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        break;
      case Routes.BUDGET:
        title = 'Budgets';
        svgIcon = 'assets/icons/tabs/tab-budgets.svg';
        systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        activeIcon = Icons.account_balance_wallet;
        unActiveIcon = Icons.account_balance_wallet_outlined;
        break;
      case Routes.PROFILE:
        title = 'Accounts';
        svgIcon = 'assets/icons/tabs/tab-account.svg';
        activeIcon = Icons.person;
        unActiveIcon = Icons.person_outline;
        //systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        break;
      default:
        title = 'Home';
        svgIcon = 'assets/icons/tabs/tab-home.svg';
        break;
    }

    if (isActive) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Get.isDarkMode ? Colors.grey : const Color(0xff666666);
    }
    return InkWell(
      onTap: () {
        controller.selected(route);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 10),
        child: Opacity(
          opacity: isActive ? 1 : 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                        height: 25, width: 40, child: Icon(activeIcon)),
                  ),
                ],
              ),
              SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomMenu(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: BottomAppBar(
            color: Theme.of(context).cardColor,
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: -20,
                    blurRadius: 10,
                    offset: const Offset(1, -10),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Expanded(child: _buildMenuItem(Routes.HOME)),
                  Expanded(child: _buildMenuItem(Routes.TRANSACTION)),
                  Expanded(child: Container()),
                  //Expanded(child: _buildMenuItem(Routes.BUDGET)),
                  Expanded(child: _buildMenuItem(Routes.PROFILE)),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => onShowBottomSheet(context),
            onLongPress: () {},
            child: Ink(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        body: Obx(() => IndexedStack(
              index: _exportIndexed(controller.selected.value),
              children: const <Widget>[
                //HomeView(),
                TransactionView(),
                //BudgetView(),
                ProfileView(),
              ],
            )),
        bottomNavigationBar: Obx(() => _buildBottomMenu(context)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void onShowBottomSheet(BuildContext context) async {
    Widget widgets = Container();
    final mediaQuery = MediaQuery.of(context);
    widgets = Padding(
        padding: EdgeInsets.only(top: mediaQuery.padding.top),
        child: const TransactionSubmitView());

    if (Platform.isAndroid && false) {
      CupertinoScaffold.showCupertinoModalBottomSheet(
          context: context, builder: (context) => widgets);
    } else {
      await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0), // Border radius for the top corners
          ),
        ),
        builder: (context) => widgets,
      );
    }
  }
}
