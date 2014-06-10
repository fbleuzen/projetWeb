var MapController = function() {

    var map;
    var pointMe;
    var maMap = {};
    var offset = 1;


    this.getLocation = function() {
        var demo=document.getElementById("coord");
        var position;
        function showPosition(position) {
            demo.innerHTML = "Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude + "<br>Accuracy: " + position.coords.accuracy;
        }

        if (navigator.geolocation) {
            position = navigator.geolocation.getCurrentPosition(showPosition, null, {enableHighAccuracy : true});
        }
        else {
            demo.innerHTML="Geolocation is not supported by this browser.";
        }
        return position;
    };

    this.updatePosition = function(position) {
        //map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
        pointMe.setPosition(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
    };

    this.addMarker = function(name, interest, lat, long) {

        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(lat+offset, long+offset),
            map: map,
            title: name
        });

        maMap[name] = marker;

        var contentMarker = "Hello my name is "+name+" and I'm interested in : "+interest;
        var infoWindow = new google.maps.InfoWindow({
            content  : contentMarker,
            position : new google.maps.LatLng(lat+offset, long+offset)
        });

        google.maps.event.addListener(marker, 'click', function() {
            infoWindow.open(map,contentMarker);
        });
        offset = offset +1;
    }

    this.updateMarker = function(name, interest, lat, long) {
        var marker = maMap[name];
        marker.setPosition(new google.maps.LatLng(lat, long));
    }

    this.addListenerToMarker = function(func) {
        google.maps.event.addListener(pointMe, 'position_changed', func);
    }

    this.getMyPosition = function() {
        return [pointMe.getPosition().lat(), pointMe.getPosition().lng()];
    }

    this.initialize = function() {
        //var position = this.getLocation();
        //var latitude = position.coords.latitude
        //var longitude = position.coords.longitude

        var mapOptions = {
          center: new google.maps.LatLng(0.00, 0.00),
          zoom: 12
        };

        map = new google.maps.Map(document.getElementById("map"), mapOptions);

        pointMe = new google.maps.Marker({
            position: new google.maps.LatLng(0.00, 0.00),
            map: map,
            title: "Me"
        });

        maMap[name] = pointMe;

        navigator.geolocation.watchPosition(this.updatePosition);
    };
};

