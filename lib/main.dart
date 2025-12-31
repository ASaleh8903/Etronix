import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Layout/admin_dashboard/admin_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/cubit/cubit/app_cubit.dart';
import 'Shared/cubit/states/states.dart';
import 'Shared/network/local/cache_helper.dart';
import 'Shared/network/remote/dio_helper.dart';
import 'Shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  print(token);

  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = AdminLayout();
  //   else
  //     widget = AdminLayout();
  // }
  //  else {
  //   widget = AdminLayout();
  // }
  widget = AdminLayout();

  runApp(Etronix(isDark: isDark, startWidget: widget));
}

class Etronix extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  Etronix({this.isDark, this.startWidget});
  // final shopCubit =
  //     ShopCubit(cacheHelper: CacheHelper(), dioHelper: DioHelper());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark ?? false),
        ),
        BlocProvider(
          create: (BuildContext context) => AdminDashboardCubit(),
          // ..GetAdDetails()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
