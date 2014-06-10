library webProject.connect_controller;

import 'dart:html';
import 'dart:async';
import 'dart:js';

import 'package:angular/angular.dart';
import 'package:angular/core/module.dart';
import 'package:webTestDart/user_model.dart';

@Controller(
    selector: '[connect-controller]',
    publishAs: 'ctrl')
class ConnectController {
    String name;
    String interests;
    bool connected = false;
    MyUser user;
    Map<String, MyUser> users = new Map<String, MyUser>();

    String websocketmessage;
    WebSocket ws;
    final Http _http;
    final Router router;
    String serverURL = "http://127.0.0.1:8080/WebSocketsServer";

    var mapController;
    var eventHandler;

    ConnectController(this.router, this._http);

    createUser() {
        user = new MyUser(name : name, interests : interests, latitude : "0.00", longitude : "0.00");

        var url = serverURL + "/connect";
        print("JSON : " + user.toJson());
        _http.post(url, user.toJson()).then((HttpResponse response) {
           print("Connect OK");
//           initWebSocket();
           connected = true;
           router.go('map', {});
        }).catchError((e) {
            print("Erreur ${e}");
        });
    }

    disconnect() {
        var url = serverURL + "/disconnect";
        _http.post(url, user.toJson()).then((HttpResponse response) {
           print("Disconnect OK");
           connected = false;
           ws.close();
           user = null;
        }).catchError((e) {
            print("Erreur ${e}");
        });
    }

    updateCoordinates(String latitude, String longitude) {
        user.setCoordinates(latitude, longitude);
        ws.sendString(user.toJson());
    }


    initWebSocket([int retrySeconds = 2]) {
      var reconnectScheduled = false;
      print("Connecting to websocket");
      ws = new WebSocket('ws://127.0.0.1:8080/WebSocketsServer/websocket/map');

      scheduleReconnect() {
        if (!reconnectScheduled) {
          new Timer(new Duration(milliseconds: 1000 * retrySeconds), () => initWebSocket(retrySeconds * 2));
        }
        reconnectScheduled = true;
      }

      ws.onOpen.listen((e) {
        print('Connected');
      });

      ws.onClose.listen((e) {
        print('Websocket closed');
      });

      ws.onError.listen((e) {
        print("Error connecting to ws");
        scheduleReconnect();
      });

      ws.onMessage.listen((MessageEvent e) {
          print('Received message: ${e.data}');
        MyUser userReceived = new MyUser()
            ..initFromJson(e.data);
        if (users.containsKey(userReceived.name)) {
            users[userReceived.name].setCoordinates(userReceived.latitude, userReceived.longitude);
            mapController.callMethod('updateMarker', [userReceived.name, userReceived.interests, double.parse(userReceived.latitude), double.parse(userReceived.longitude)]);
        } else {
            users[userReceived.name] = userReceived;
            mapController.callMethod('addMarker', [userReceived.name, userReceived.interests, double.parse(userReceived.latitude), double.parse(userReceived.longitude)]);
        }
        websocketmessage = e.data;
      });
    }

    sendTest() {
        ws.sendString(user.toJson());
    }

    positionChanged() {
        print("position changed");
        var position = mapController.callMethod('getMyPosition');
        print(position);
        user.setCoordinates('${position[0]}', '${position[1]}');
        sendTest();
    }

    loadMap() {
        print("LOADING MAP");
        mapController = new JsObject(context['MapController']);
        mapController.callMethod('initialize');
        //eventHandler = context['google']['maps']['event'];
        mapController.callMethod('addListenerToMarker', [positionChanged]);
        //context.callMethod('google.maps.event.addListener', [mapController.pointMe, 'position_changed', () {}]);
        initWebSocket();
        print("LOADED");
    }

}