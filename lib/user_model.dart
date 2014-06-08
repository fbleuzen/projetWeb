library myuser;

import 'package:exportable/exportable.dart';

class MyUser extends Object with Exportable {
    @export String name;
    @export String interests;
    @export String latitude;
    @export String longitude;

    MyUser({this.name, this.interests, this.latitude, this.longitude});

    setCoordinates(String latitude, String longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }
}