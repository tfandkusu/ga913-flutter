import 'package:auto_route/auto_route.dart';
import 'package:ga913_flutter/screen/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
      ];

  @override
  RouteType get defaultRouteType => const RouteType.material();
}
