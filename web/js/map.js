function getLocation() {
    var demo=document.getElementById("coord");
    function showPosition(position) {
        var demo=document.getElementById("coord");
        demo.innerHTML = "Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude + "<br>Accuracy: " + position.coords.accuracy;
    }

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, null, {enableHighAccuracy : true});
    }
    else {
        demo.innerHTML="Geolocation is not supported by this browser.";
    }
}

function updatePosition(position) {
    //map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
    pointMe.setPosition(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
}

var map;
var pointMe;
function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(0.00, 0.00),
      zoom: 12
    };
    map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    pointMe = new google.maps.Marker({
        position: new google.maps.LatLng(0.00, 0.00),
        map: map,
        title: "Me"
    });
}

initialize();
navigator.geolocation.watchPosition(updatePosition);
