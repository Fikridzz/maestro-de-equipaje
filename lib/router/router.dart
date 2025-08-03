import 'package:go_router/go_router.dart';
import 'package:test_master_bagasi/view/home_page.dart';
import 'package:test_master_bagasi/view/product_page.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/product/:product_id',
      builder: (context, state) {
        final id = state.pathParameters['product_id'];
        return ProductPage(id ?? '');
      },
    ),
  ],
);
