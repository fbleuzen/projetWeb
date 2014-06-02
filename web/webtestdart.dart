library webProject.main;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:webTestDart/routes/router.dart';
import 'package:webTestDart/connect_controller.dart';

class MyAppModule extends Module {
    MyAppModule() {
        bind(ConnectController);
        value(RouteInitializerFn, routeInitializer);
        factory(NgRoutingUsePushState,
            (_) => new NgRoutingUsePushState.value(false));
    }
}

void main() {
    applicationFactory()
          .addModule(new MyAppModule())
          .run();
}