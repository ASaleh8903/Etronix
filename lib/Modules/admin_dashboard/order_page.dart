import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Center(
        child: Text(
          'Orders',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
