import 'package:flutter/material.dart';

class BillsDetailsScreen extends StatefulWidget {
  const BillsDetailsScreen({super.key});

  @override
  State<BillsDetailsScreen> createState() => _BillsDetailsScreenState();
}

class _BillsDetailsScreenState extends State<BillsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Bills Details ')));
  }
}
