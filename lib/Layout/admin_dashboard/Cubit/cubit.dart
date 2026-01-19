import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Models/admin_dashboard/product_model.dart';
import 'package:etronix/Modules/admin_dashboard/customers_page.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/dashboard_page.dart';
import 'package:etronix/Modules/admin_dashboard/Orders/order_page.dart';
import 'package:etronix/Modules/admin_dashboard/Products/product_screen.dart';
import 'package:etronix/Modules/admin_dashboard/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum OrderFilterCategory { date, payment, status, products }

class AdminDashboardCubit extends Cubit<AdminDashboardStates> {
  AdminDashboardCubit() : super(AdminInitialState());

  static AdminDashboardCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  final List<Widget> sidebarScreens = [
    const DashboardScreen(),
    const OrdersScreen(),
    const ProductsPage(),
    const CustomersPage(),
    const SettingsPage(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AdminChangeSidebarState());
  }

  OrderFilterCategory? activeFilterCategory;

  String? dateFilter;
  String? paymentMethod;
  String? orderStatus;
  List<String> selectedProducts = [];

  void resetCategoryOnly() {
    activeFilterCategory = null;
    emit(FilterCategorySelectedstate());
  }

  void selectFilterCategory(OrderFilterCategory category) {
    activeFilterCategory = activeFilterCategory == category ? null : category;
    emit(FilterCategorySelectedstate());
  }

  void setDateFilter(String value) {
    dateFilter = value;
    emit(FilterDateSelectedstate());
  }

  void setPaymentMethod(String value) {
    paymentMethod = value;
    emit(FilterPaymentSelectedstate());
  }

  void setOrderStatus(String value) {
    orderStatus = value;
    emit(FilterOrderStateSelectedstate());
  }

  void toggleProduct(String product) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
    emit(FilterProductsSelectedstate());
  }

  void removeFilter(String key) {
    switch (key) {
      case 'date':
        dateFilter = null;
        break;
      case 'payment':
        paymentMethod = null;
        break;
      case 'status':
        orderStatus = null;
        break;
      case 'products':
        selectedProducts.clear();
        break;
    }
    emit(RemoveSingleFilterstate());
  }

  void clearAllFilters() {
    activeFilterCategory = null;
    dateFilter = null;
    paymentMethod = null;
    orderStatus = null;
    selectedProducts.clear();
    emit(FilterClearAllstate());
  }

  final List<String> productCategories = const [
    'Phones',
    'Tablets',
    'Laptops',
    'Monitors',
    'Headphones',
    'Speakers',
    'Cameras',
    'Smart Watches',
    'Accessories',
  ];

  int selectedProductCategoryIndex = 0;

  String get selectedProductCategory =>
      productCategories[selectedProductCategoryIndex];

  void changeProductCategory(int index) {
    selectedProductCategoryIndex = index;
    emit(ProductCategoryChangedState());
  }

  Map<String, dynamic>? selectedProduct;
  bool isProductDrawerOpen = false;

  void openProductDrawer(Map<String, dynamic> product) {
    selectedProduct = product;
    isProductDrawerOpen = true;
    emit(OpenProductDrawerState());
  }

  void closeProductDrawer() {
    selectedProduct = null;
    isProductDrawerOpen = false;
    emit(CloseProductDrawerState());
  }

  final List<ProductModel> products = [];

  void addProduct(ProductModel product) {
    products.add(product);
    emit(ProductsUpdated());
  }

  void updateProduct(ProductModel updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
      emit(ProductsUpdated());
    }
  }

  void toggleAvailability(String productId) {
    final index = products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      products[index] = products[index].copyWith(
        isAvailable: !products[index].isAvailable,
      );
      emit(ProductsUpdated());
    }
  }

  bool isProductDialogEdit = false;

}
