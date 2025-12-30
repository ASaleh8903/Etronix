import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Modules/admin_dashboard/customers_page.dart';
import 'package:etronix/Modules/admin_dashboard/dashboard_page.dart';
import 'package:etronix/Modules/admin_dashboard/order_page.dart';
import 'package:etronix/Modules/admin_dashboard/products_page.dart';
import 'package:etronix/Modules/admin_dashboard/report_page.dart';
import 'package:etronix/Modules/admin_dashboard/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AdminDashboardCubit extends Cubit<AdminDashboardStates> {
  AdminDashboardCubit(AdminDashboardStates initialState,) : super(initialState);

  static AdminDashboardCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int previousIndex = 0;
  List<Widget> sidbarScreens = [
    DashboardPage(),
    OrderPage(),
    ProductsPage(),
    CustomersPage(),
    ReportPage(),
    SettingsPage()
  ];

  void changeIndex(int index) {
    if (index >= 0 && index < sidbarScreens.length) {
      previousIndex = currentIndex;
      currentIndex = index;
      emit((AdminInitialState()));
    }
  }


}