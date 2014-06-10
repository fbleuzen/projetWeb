import 'package:angular/angular.dart';

void routeInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'home': ngRoute(
        path: '/home',
        view: 'view/home.html'),
    'connect': ngRoute(
        path: '/connect',
        view: 'view/connect.html'),
    'map': ngRoute(
        path: '/map',
        view: 'view/map.html',
        enter: (RouteEnterEvent e) => (print("TOTO ENTERED"))),
    'disconnect': ngRoute(
        path: '/disconnect',
        view: 'view/disconnect.html'),
    'about': ngRoute(
        path: '/about',
        view: 'view/about.html'),
    'contact': ngRoute(
        path: '/contact',
        view: 'view/contact.html'),
    'view_default': ngRoute(
        defaultRoute: true,
        enter: (RouteEnterEvent e) =>
            router.go('home', {},
            replace: true))
  });
}