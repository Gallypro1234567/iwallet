import 'package:flutter/material.dart';


import '../controllers/budget_controller.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({Key? key}) : super(key: key);

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  final controller = BudgetController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BudgetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BudgetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
