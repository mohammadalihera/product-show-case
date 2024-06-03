import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_show_case/core/cubits/app/app_cubit.dart';
import 'package:product_show_case/core/cubits/auth/auth_cubit.dart';
import 'package:product_show_case/core/services/navigation_service.dart';
import 'package:product_show_case/core/services/service_locator.dart';
import 'package:product_show_case/ui/pages/home/home_page.dart';
import 'package:product_show_case/ui/router.dart';

import 'ui/pages/login/login_page.dart';
import 'ui/theme/thems.dart';

class DokanApp extends StatelessWidget {
  const DokanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) => AppCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(appCubit: context.read<AppCubit>())),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: serviceLocator<NavigationService>().navigatorKey,
            title: 'Dokan',
            theme: Themes.jhLight,
            onGenerateRoute: RouteTo.generateRoute,
            home: state is LoadedAppState && state.isLoggedIn ? const HomePage() : const LoginPage(),
          );
        },
      ),
    );
  }
}
