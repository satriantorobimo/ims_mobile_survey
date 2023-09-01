import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lokasi Survey',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF575551),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1.0, color: Colors.grey.withOpacity(0.5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: AbsorbPointer(
                              absorbing: true,
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(51.5, -0.09),
                                  zoom: 17.0,
                                  keepAlive: false,
                                ),
                                layers: [
                                  // TileLayerOptions(
                                  //   urlTemplate:
                                  //       "https://api.tiles.mapbox.com/v4/"
                                  //       "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                                  //   additionalOptions: {
                                  //     'accessToken':
                                  //         '31232956-93ac-41b1-aa98-c048527f8ea0',
                                  //     'id': 'mapbox.streets',
                                  //   },
                                  // ),
                                  TileLayerOptions(
                                      urlTemplate:
                                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      subdomains: ['a', 'b', 'c']),
                                  MarkerLayerOptions(
                                    markers: [
                                      Marker(
                                        width: 30.0,
                                        height: 30.0,
                                        point: LatLng(51.5, -0.09),
                                        builder: (ctx) => Image.asset(
                                          'assets/icon/pin.png',
                                          scale: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('JL. Majapahit no 45 RT 08 RW 09',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2D2A26),
                                    fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 8),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Kel. Gayamsari, Kec. Gayamsari, Kota Semarang',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2D2A26),
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
