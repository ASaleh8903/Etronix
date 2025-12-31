import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Modules/admin_dashboard/customers_page.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/dashboard_page.dart';
import 'package:etronix/Modules/admin_dashboard/order_page.dart';
import 'package:etronix/Modules/admin_dashboard/products_page.dart';
import 'package:etronix/Modules/admin_dashboard/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardStates> {
  AdminDashboardCubit() : super(AdminInitialState());

  static AdminDashboardCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  final List<Widget> sidebarScreens = [
    DashboardScreen(),
    OrderPage(),
    ProductsPage(),
    CustomersPage(),
    SettingsPage(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AdminChangeSidebarState());
  }
}
