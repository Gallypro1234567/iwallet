import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/common/firebase_provider.dart';
import 'package:iwallet/app/common/help_function.dart';
import 'package:iwallet/app/models/expenses_model.dart';
import 'package:iwallet/app/routes/app_pages.dart';
import 'package:iwallet/app/widgets/app_list_tile.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView>
    with TickerProviderStateMixin {
  final controller = TransactionController();
  late TabController _tabController;
  late ScrollController _scrollController;
  List<DateTime> monthsList = [];

  int initialIndex = 0;
  var currentIndex = 0.obs;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 14, vsync: this);
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var now = DateTime.now();
      var index = monthsList
          .indexWhere((e) => e.year == now.year && e.month == now.month);
      _tabController.animateTo(index);
      _scrollController.jumpTo(index * 70);
      setState(() {
        initialIndex = index;
      });
      _tabController.addListener(() {
        currentIndex.value = _tabController.index;
      });
    });
    controller.onInit();
  }

  List<DateTime> getItem() {
    // ignore: no_leading_underscores_for_local_identifiers
    List<DateTime> _monthsList = [];
    DateTime now = DateTime.now();

    var future = DateTime(now.year, now.month + 1, now.day);
    for (int i = 0; i <= 12; i++) {
      late DateTime monthAgo;
      if (i == 0) {
        monthAgo = now;
      } else {
        monthAgo = DateTime(now.year, now.month - i, now.day);
      }
      _monthsList.add(monthAgo);
    }
    _monthsList.sort(
        (a, b) => b.difference(now).abs().compareTo(a.difference(now).abs()));
    //
    _monthsList.insert(_monthsList.length, future);
    setState(() {
      monthsList.assignAll(_monthsList);
    });
    return _monthsList;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản Lý Chi Tiêu',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        child: Stack(
          children: [
            _buildContent(context),
            Obx(() {
              if (currentIndex.value == initialIndex) {
                return Container();
              }
              return Positioned(
                top: 40,
                right: 16,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _tabController.animateTo(initialIndex);
                      _scrollController.animateTo(initialIndex * 70,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).disabledColor),
                    ),
                    child: RotatedBox(
                      quarterTurns: currentIndex > initialIndex ? 2 : 0,
                      child: const Icon(Icons.fast_forward),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          color: Theme.of(context).cardColor,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).textTheme.titleSmall!.color,
              indicatorColor: Get.isDarkMode ? Colors.white : Colors.black,
              tabs: getItem().map((e) {
                var item = e;
                String? specialName;
                DateTime now = DateTime.now();
                if (e.year == now.year && e.month == now.month) {
                  specialName = 'Tháng này'.toUpperCase();
                } else if (e.isAfter(now)) {
                  specialName = 'Tương lai'.toUpperCase();
                } else if (e.year == now.year && e.month == now.month - 1) {
                  specialName = 'Tháng trước'.toUpperCase();
                }
                return Tab(
                    text: specialName ??
                        '${item.month.toString().padLeft(2, '0')}/${item.year}');
              }).toList(),
              onTap: (index) {
                currentIndex.value = _tabController.index;
              },
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream:
                FireStoreProvider.getUserExpenses(Application.user?.uid ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('not found'));
              }

              Map<DateTime, List<Expenses>> groups = {};

              for (DocumentSnapshot document in (snapshot.data?.docs ?? [])) {
                Map<String, dynamic> map =
                    document.data()! as Map<String, dynamic>;

                var item = Expenses.fromJson(map);
                item.id = document.id.toString();

                //
                final dateTime =
                    DateTime(item.date!.year, item.date!.month, item.date!.day);
                if (!groups.containsKey(dateTime)) {
                  groups[dateTime] = [];
                }
                groups[dateTime]!.add(item);
              }

              return _mapToTabView(groups, context);
            },
          ),
        ),
      ],
    );
  }

  TabBarView _mapToTabView(
      Map<DateTime, List<Expenses>> groups, BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: monthsList.map(
        (e) {
          Map<DateTime, List<Expenses>> mapList = {};
          List<DateTime> keysList = groups.keys.toList();
          for (var i = 0; i < keysList.length; i++) {
            var key = keysList[i];
            if (e.year == key.year && e.month == key.month) {
              if (!mapList.containsKey(key)) {
                mapList[key] = [];
              }
              mapList[key]!.addAll(groups[key]!);
            }
          }
          var now = DateTime.now();
          List<MapEntry<DateTime, List<Expenses>>> entries =
              mapList.entries.toList();
          entries.sort((a, b) => a.key
              .difference(now)
              .abs()
              .compareTo(b.key.difference(now).abs()));
          Map<DateTime, List<Expenses>> sortedMap = Map.fromEntries(entries);
          return _buildExpenseWithMonth(sortedMap, context);
        },
      ).toList(),
    );
  }

  Widget _buildExpenseWithMonth(
      Map<DateTime, List<Expenses>> groups, BuildContext context) {
    var input = 0.0.obs;
    var output = 0.0.obs;
    if (groups.isEmpty) {
      return Center(
        child: Text(
          'Không có giao dịch',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.4),
              ),
        ),
      );
    }
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tiền vào',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                    Obx(
                      () => Text(
                        thousandSeparator(input.value, unit: 'đ'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tiền ra',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                    Obx(
                      () => Text(
                        thousandSeparator(output.value, unit: 'đ'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Divider(
                        height: 1.0,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => Text(
                        thousandSeparator((input.value + output.value),
                            unit: 'đ'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 22),
          ...groups.keys.map(
            (e) {
              var list = groups[e];
              if ((list ?? []).isEmpty) {
                return Container();
              }
              double totalItem = 0.0;
              var now = DateTime.now();
              list!.sort((a, b) => a.date!
                  .difference(now)
                  .abs()
                  .compareTo(b.date!.difference(now).abs()));
              for (var item in list) {
                if (item.categoryType == '1') {
                  totalItem = totalItem + (item.amount ?? 0.0);
                  input.value = input.value + (item.amount ?? 0.0);
                } else {
                  totalItem = totalItem - (item.amount ?? 0.0);
                  output.value = output.value - (item.amount ?? 0.0);
                }
              }
              var title = getTime(e);
              return Padding(
                padding: const EdgeInsets.only(bottom: 22.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Theme.of(context).cardColor,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  title['date'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 32),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title['day_name'],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  '${title['month_name']} ${title['year']}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              thousandSeparator(totalItem),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(width: 8.0)
                          ],
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: list.map((Expenses data) {
                        return AppListTitle(
                          title: data.categoryName.toString(),
                          trailing: Text(
                            thousandSeparator(data.amount.toString()),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: data.categoryType == '0'
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                          ),
                          leading: Container(
                            width: 48,
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.indigo.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.content_paste,
                              color: Colors.indigo,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.TRANSACTION_DETAIL,
                                arguments: data);
                          },
                          border: list.indexOf(data) == list.length,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          ).toList()
        ],
      ),
    );
  }
}
