import 'package:angular/angular.dart';

void routeInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'connect': ngRoute(
        path: '/connect',
        view: 'view/connect.html'),
    'map': ngRoute(
        path: '/map',
        view: 'view/map.html'),
    'disconnect': ngRoute(
            path: '/disconnect',
            view: 'view/disconnect.html')
  });
}