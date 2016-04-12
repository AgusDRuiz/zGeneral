<!DOCTYPE html>
<html>
    <head>
        <title>Simple Map</title>
        <meta name="viewport" content="initial-scale=1.0">
        <meta charset="utf-8">
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            #map {
                height: 90%;
            }
        </style>
    </head>
    <body>
        <div id="map"></div>
        <footer>
            <input type="text" id="idBusqueda" class="controls" placeholder="Buscar..."/>
            <a onclick="Localizame()">Mi ubicación</a><br/>
            <a onclick="changeView()">Cambio de Vista</a><br/>
            <a onclick="paintCircles()">Pinta la Ruta</a><br/>
            <a onclick="clearLayer()">Limpia</a><br/>
            <a onclick="showTraffic()">Trafico</a><br/>
            <a onclick="showKML()">KML</a><br/>
            <a onclick="showTransit()">Transporte publico</a><br/>
            <a onclick="showBike()">Bicicleta</a><br/>
            <input type="checkbox" id="idHebilita" onclick="Habilitar()"/>
        </footer>
        <script>

            var map;            
            var miUbicacion ={};
            var zocalo = {
                lat: 19.432658, 
                lng: -99.133171
            };
            var miCasa = {
                lat: 19.290246,
                lng: -98.918178
            };             
            var playas = {
                lat : 40.7127837,
                lng: -74.00594130000002
            };
            var toggleMarkerStatus = false;
            var listener;
            var markerCount = 1;
            
            function initMap() {
                map = new google.maps.Map(document.getElementById('map'), {
                    center: zocalo,
                    zoom: 10,
                    //disableDefaultUI: true
                    zoomControl: true,
                    //mapTypeControl: false,
                    //mapTypeId: google.maps.MapTypeId.ROADMAP,
                    /*mapTypeId: google.maps.MapTypeId.TERRAIN,
                    /*mapTypeId: google.maps.MapTypeId.SATELLITE
                    mapTypeId: google.maps.MapTypeId.HYBRID*/
                    disableDoubleClickZoom: true,
                    backgroundColor: "#000",
                    //draggable: false,
                    //minZoom: 4,
                    //maxZoom: 24,
                    scaleControl: true,
                    mapTypeControlOptions:{
                        //style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
                        style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
                        mapTypeIds:[
                            google.maps.MapTypeId.ROADMAP,
                            google.maps.MapTypeId.TERRAIN,
                            google.maps.MapTypeId.SATELLITE
                        ],
                        position: google.maps.ControlPosition.BOTTOM_CENTER
                    },
                    zoomControlOptions:{
                        position: google.maps.ControlPosition.LEFT_CENTER
                    },
                    streetViewControlOptions:{
                        position: google.maps.ControlPosition.RIGHT_CENTER
                    }
                });
                searchPlace();
                //Localizame();
                
            }
            Habilitar = function(){
                if(toggleMarkerStatus){
                    toggleMarkerStatus = false
                    google.maps.event.removeListener(listener);
                }
                else{
                    toggleMarkerStatus = true;
                    listener = map.addListener('click',addMarkerAtMouse);
                }
            }
            
            addMarkerAtMouse = function(e){
                addMarker(e.latLng);
                console.log("Latitud: "+e.latLng.lat());
                console.log("Longitud: "+e.latLng.lng());
            }
            function Localizame(){
                navigator.geolocation.getCurrentPosition(
                    function(pos){
                        miUbicacion.lat = pos.coords.latitude;
                        miUbicacion.lng = pos.coords.longitude;
                        
                        map.setCenter(miUbicacion);
                        map.setZoom(18);
                        addMarker(miUbicacion);
                        /*addMarker(playas);
                        addMarker(zocalo);*/
                    },
                    function(error){
                        alert({
                            title:'Error de localización',
                            template : error.message,
                            okType: 'button-assertive'
                        });
                    }
                )
            }
            addMarker = function(ubicacion){
                var marker = new google.maps.Marker({
                    map: map,
                    position: ubicacion,
                    draggable: true,
                    icon: 'img/pin.png',
                    //animation: google.maps.Animation.DROP
                    animation: google.maps.Animation.BOUNCE
                    //label: "B"
                    //label: String(markerCount)
                });
                markerCount++;
                marker.addListener('dblclick',deleteMarker);
                //marker.addListener('click',addAnimation);
                marker.addListener('click',addInfoWindow);
                marker.addListener('dragend',addInfoCoords);
            }
            
            addInfoCoords = function(e){                
                console.log("Fin Latitud: "+e.latLng.lat());
                console.log("Fin Longitud: "+e.latLng.lng());                
            }
            
            addInfoWindow = function(e){
                var geoCoder = new google.maps.Geocoder;
                var infoWindo = new google.maps.InfoWindow({
                    maxWidth: 100
                });
                var self = this;
                //infoWindo.setContent('Mensaje de prueba');
                //infoWindo.open(map, this);
                geoCoder.geocode({'location': e.latLng}, function(res,status){
                    if(status == google.maps.GeocoderStatus.OK){
                        console.log(res);
                        var placeName = res[1].address_components[0].short_name;
                        var placeAddress = res[1].formatted_address;
                        var infoContent = placeName +"<hr>"+placeAddress;
                        infoWindo.setContent(infoContent);
                        infoWindo.open(map, self);
                    }
                })
            }
            
            addAnimation = function(){
                this.setAnimation(google.maps.Animation.BOUNCE)
            }
            deleteMarker = function(){
                this.setMap(null);
            }
            
            searchPlace = function(){
                var search = document.getElementById("idBusqueda");
                var searchBox = new google.maps.places.SearchBox(search);
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(search);
                
                searchBox.addListener('places_changed', function(){
                    
                    var places = searchBox.getPlaces();
                    
                    places.forEach(function(a){
                        var ubicacion = a.geometry.location;//ASDSBNADLGSALKDHSAKLDHSAKLSDHA
                        addMarker(ubicacion);
                        map.setCenter(ubicacion);
                        traceRoute(ubicacion);
                    })
                })
            }
            
            traceRoute = function(ubiDestino){
                var directionsDisplay = new google.maps.DirectionsRenderer({
                    map: map
                });
                
                var  request = {
                    destination: ubiDestino,
                    origin: zocalo,
                    travelMode: google.maps.TravelMode.WALKING
                };
                
                var directionService = new google.maps.DirectionsService();
                directionService.route(request, function(response,status){
                    if(status==google.maps.DirectionsStatus.OK){
                        directionsDisplay.setDirections(response);
                    }
                });
            }
            
            changeView = function(){
                var panorama = new google.maps.StreetViewPanorama(
                document.getElementById("map"),{
                        position: miCasa                    
                    }
                )
            }
            painRoute = function(){
                var routeCoords=[miUbicacion, zocalo, miCasa, playas, miUbicacion];
                
                /*var routePath = new google.maps.Polyline({
                    path: routeCoords,
                    strokeColor: '#0066ff',
                    strokeOpacity: 1.0,
                    strokeWeight: 2,
                    geodesic: true,
                    editable: true,
                    draggable: true
                })*/
                var routePath = new google.maps.Polygon({
                    path: routeCoords,
                    strokeColor: '#0066ff',
                    strokeOpacity: 1.0,
                    strokeWeight: 2,
                    fillColor: '#3385ff',
                    fillOpacity: 0.3,
                    geodesic: true,
                    editable: true,
                    draggable: true
                })
                
                routePath.setMap(map);
            }
            
            paintCircles = function(){
                var myPlaces=[miUbicacion, zocalo, miCasa, playas];
                var color = "#"+Math.random().toString(16).slice(2, 8);
                var randomRadius = Math.floor(Math.random()*1000000);
                var randomPlace = Math.floor(Math.random() * 5);
                
                var routePath = new google.maps.Circle({
                    strokeColor: '#0066ff',
                    strokeOpacity: 1.0,
                    strokeWeight: 2,
                    fillColor: '#3385ff',
                    //fillColor: color,
                    fillOpacity: 0.3,
                    radius: 2000
                })
                
                //routePath.setRadius(randomRadius)
                routePath.setCenter(miUbicacion);
                routePath.setMap(map);
            }
            
            painSquare = function(){
        //SUR           OESTE
        //19.374681, -99.173734
        //NORTE         ESTE
        //19.380226, -99.165743
        
                var routePath = new google.maps.Rectangle({
                    strokeColor: '#0066ff',
                    strokeOpacity: 1.0,
                    strokeWeight: 2,
                    fillColor: '#3385ff',
                    fillOpacity: 0.3,
                    editable: true,
                    draggable: true
                })
                var bounds = {
                    south: 19.374681,
                    west: -99.173734,
                    north: 19.380226,
                    east: -99.165743
                }
                routePath.setBounds(bounds);
                routePath.setMap(map);
            }
            
            paintImage = function(){
                
                var bounds = {
                    south: 19.374681,
                    west: -99.173734,
                    north: 19.380226,
                    east: -99.165743
                }
                
                var christmasOverlay = new google.maps.GroundOverlay('img/apoyoton.png', bounds);
                christmasOverlay.setMap(map);
                
            }
            var layer;
            
            clearLayer = function(){
                if(typeof layer !== 'undefined'){
                    layer.setMap(null);
                }
            }
            showTraffic = function(){
                clearLayer();
                layer = new google.maps.TrafficLayer();
                layer.setMap(map);
            }
            showTransit = function(){
                clearLayer();
                layer = new google.maps.TransitLayer();
                layer.setMap(map);
            }
            showBike = function(){
                clearLayer();
                layer = new google.maps.BicyclingLayer();
                layer.setMap(map);
            }
            showKML = function(){
                clearLayer();
                layer = new google.maps.KmlLayer();
                layer.setUrl('http://mexicometro.org/Mexico-Metro.kml');                
                layer.setMap(map);
            }
            
            
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdIj14REhPucq-tWI8snMD3DgYjAAwBVI&signed_in=true&libraries=places&callback=initMap"async defer></script>
    </body>
</html>