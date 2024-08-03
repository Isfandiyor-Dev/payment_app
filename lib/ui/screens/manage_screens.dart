import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/blocs/navigation_bar/navigation_bar_cubit.dart';

class ManageScreens extends StatefulWidget {
  const ManageScreens({super.key});

  @override
  State<ManageScreens> createState() => _ManageScreensState();
}

class _ManageScreensState extends State<ManageScreens> {
  @override
  Widget build(BuildContext context) {
    final pageController = context.read<NavigationBarCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlueAccent,
        currentIndex: pageController.state,
        iconSize: 30,
        unselectedLabelStyle: const TextStyle(fontSize: 15),
        selectedLabelStyle: const TextStyle(fontSize: 17),
        selectedIconTheme: const IconThemeData(size: 33),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made_rounded),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
        ],
        onTap: (value) {
          pageController.goToScreen(value);
        },
      ),
      body: pageController.pages[context.watch<NavigationBarCubit>().state],
    );
  }
}
