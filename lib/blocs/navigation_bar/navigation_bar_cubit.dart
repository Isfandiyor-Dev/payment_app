import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/ui/screens/pages/history_screen.dart';
import 'package:payment_app/ui/screens/pages/home_screen.dart';
import 'package:payment_app/ui/screens/pages/transfer_screen.dart';

class NavigationBarCubit extends Cubit<int> {
  NavigationBarCubit() : super(0);

  List<Widget> pages = [
    const HomeScreen(),
    TransferScreen(),
    const HistoryScreen(),
  ];

  void goToScreen(int index) {
    emit(index);
  }
}
