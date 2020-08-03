import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transportservice/ScrollingText.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  Set<Marker> _markers = HashSet<Marker>();

  GoogleMapController _mapController ;
  BitmapDescriptor _markerIcon;
  Completer<GoogleMapController> _controller = Completer();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  Timer timer;
  bool loading = false;
  String _address = "";
  TextEditingController _textController;
  bool _isTextEditing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController(text: _address);
    _textController.addListener(() {
      setState(() {

      });
    });
    timer = Timer.periodic(Duration(seconds: 15), (timer) {
      _getCurrentLocation();
      _setMarkerIcon();
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    _textController.dispose();
  }


  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/car.png');

  }
  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;

    setState(() {
      _markers.add(
          Marker(
            position: LatLng( _currentPosition.latitude, _currentPosition.longitude),
            infoWindow: InfoWindow(
              title: 'hdvfgvf',
              snippet: 'vdghcvgsvchvf',
            ),
            icon: _markerIcon,
            markerId: MarkerId("0"),
          ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Map'),
//      ),
      body: _currentPosition == null ? Center(child: CircularProgressIndicator(),) : Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            mapToolbarEnabled: false,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            trafficEnabled: true,
            compassEnabled: true,
            indoorViewEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  _currentPosition.latitude, _currentPosition.longitude),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Text('Transport project'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Container(
              height: 100,
              alignment: Alignment.topCenter,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.cyan,
                        size: 24,
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Container(
                            width: 250,
                            height: 30,
                            child: TextField(
                              controller: _textController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Meet me at ...',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                  ),
                  const Divider(
                    color: Colors.grey,
                    indent: 35,
                    thickness: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.deepOrangeAccent,
                        size: 25,
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              width: 250,
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'I\'am going to ....',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formAddress( String HintText){
    if( _isTextEditing && HintText=='Meet me at ...'){

    }

  }



  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(position);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(position) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      String name = place.name;
      String subLocality = place.subLocality;
      String locality = place.locality;
      String administrativeArea = place.administrativeArea;
      String postalCode = place.postalCode;
      String country = place.country;
      String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
      setState(() {
        _address = address;
        print(address);

      });
    } catch (e) {
      print(e);
    }
  }
}
