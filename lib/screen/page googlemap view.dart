import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/screen/page%20details.dart';
import 'package:syriaonline/service/ServiceApi.dart';

const kGoogleApiKey = "AIzaSyDELVyIyOWK-s4frDfUmU81fBESRMsEkRE";

class Googlemaps extends StatefulWidget {
  @override
  _GooglemapsState createState() => _GooglemapsState();
}

class _GooglemapsState extends State<Googlemaps> {
  GoogleMapController mapController;
//-------------------------------get markers------------------------------------
  List<Marker> markers = [];
  List<ServicesModel> allserv;
  allServiceMarker() async {
    GetServiceApi getServiceApi = new GetServiceApi();
    List<ServicesModel> servLst = await getServiceApi.getserv();
    setState(() {
      allserv = servLst;
    });
    for (ServicesModel item in allserv) {
      markers.add(Marker(
          markerId: MarkerId(item.serviceId.toString()),
          position: LatLng(double.parse(item.x), double.parse(item.y)),
          infoWindow: InfoWindow(
              title: "${item.serviceName}",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Detailes()));
              })));
      print('************************************************');
      print(item.x);
    }
  }
  //----------------------------map type----------------------------------------

  var maptype = MapType.normal;
  //-----------------------------for marker-------------------------------------

//---------------------for current location-------------------------------------
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  void currentlocatorPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngposition, zoom: 18);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.51396767600139, 36.27581804468471),
    zoom: 15,
  );
  @override
  void initState() {
    super.initState();

    allServiceMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: maptype,

          onMapCreated: (controller) {
            setState(() {
              bottomPaddingOfMap = 300;
              mapController = controller;
            });
            currentlocatorPosition();
          },
          markers: markers.toSet(),
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          //------------------------------marker-------------------------------
          initialCameraPosition: _cameraPosition,
        ),
        Positioned(
          bottom: 10,
          right: 100,
          child: RawMaterialButton(
            onPressed: () {
              setState(() {
                maptype == MapType.normal
                    ? maptype = MapType.hybrid
                    : maptype = MapType.normal;
              });
            },
            padding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            child: Container(
              height: 70,
              width: 150,
              decoration: BoxDecoration(
                  gradient: kgradientColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(80.0),
                  )),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                'Change Map Type',
                textAlign: TextAlign.center,
                style: kTextButton,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
