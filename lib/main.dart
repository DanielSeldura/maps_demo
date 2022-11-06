import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.title});

  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;
  Set<Marker> markers = {};
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GoogleMap(
              mapType: MapType.hybrid,
              markers: markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                if (mounted) {
                  setState(() {
                    _controller = controller;
                  });
                }
              },
            ),
          ),
          TextButton(
              onPressed: () {
                if (markers.isEmpty) {
                  if (mounted) {
                    setState(() {
                      markers.add(const Marker(
                          markerId: MarkerId('lake'),
                          position:
                              LatLng(37.43296265331129, -122.08832357078792)));
                    });
                  }
                } else {
                  if (mounted) {
                    setState(() {
                      markers = <Marker>{};
                    });
                  }
                }
              },
              child: Container(
                  padding: const EdgeInsets.all(32),
                  color: Colors.redAccent,
                  child:
                      Text(markers.isEmpty ? 'Add a marker' : 'Remove marker')))
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: const Text('To the lake!'),
            icon: const Icon(Icons.directions_boat),
          ),
        ],
      ),
    );
  }

  _goToTheLake() {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
