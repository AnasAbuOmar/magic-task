import 'package:flutter/material.dart';
import 'package:magic_task/pages/homepage/view/home_view.dart';
import 'package:magic_task/pages/homepage/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
