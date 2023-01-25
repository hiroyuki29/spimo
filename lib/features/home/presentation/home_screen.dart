import 'package:flutter/material.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: 'home'),
      body: const SafeArea(
        child: Text('home'),
      ),
    );
  }
}
