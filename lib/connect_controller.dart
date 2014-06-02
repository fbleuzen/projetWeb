library webProject.connect_controller;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webTestDart/user_model.dart';

@Controller(
    selector: '[connect-controller]',
    publishAs: 'ctrl')
class ConnectController {
    String name;
    String interests;
    bool connected = false;
    MyUser user;

    createUser() {
        //print(name);
        //print(interests);
        user = new MyUser(name, interests);
        connected = true;
        sendUser();
    }

    sendUser() {
        var url = "http://127.0.0.1:8080/connect";
        HttpRequest.getString(url).then(processResponse);
    }

    processResponse(String responseText) {
        print(responseText);
    }

    disconnect() {
        var url = "http://127.0.0.1:8080/disconnect";
        HttpRequest.getString(url).then(processResponse);
        connected = false;
        user = null;
    }
}