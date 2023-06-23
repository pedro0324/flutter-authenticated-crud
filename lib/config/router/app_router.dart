import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Auth Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.subloc; //a que ruta entra
      final authStatus = goRouterNotifier.authStatus; //estado de auth

      if (isGoingTo == '/splash' &&
          authStatus == AuthStatus.checking) //se esta validando el token
        return null;

      if (authStatus == AuthStatus.noAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login'; // si no esta autenticado, se manda al login
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') return '/';
      }

      //en esta parte se haria la redireccion
      return null;
    },
  );
});
