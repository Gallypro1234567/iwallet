import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Thêm Giao dịch',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
      ),
    );
  }
}
