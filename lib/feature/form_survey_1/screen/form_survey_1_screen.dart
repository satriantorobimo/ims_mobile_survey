import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/utility/network_util.dart';
import '../widget/button_next_1_widget.dart';
import '../widget/form_info_1_widget.dart';

class FormSurvey1Screen extends StatefulWidget {
  const FormSurvey1Screen({super.key, required this.taskList});
  final TaskList taskList;
  @override
  State<FormSurvey1Screen> createState() => _FormSurvey1ScreenState();
}

class _FormSurvey1ScreenState extends State<FormSurvey1Screen> {
  late String date;
  late String address = '', area = '', location = '', postal = '';
  bool isConnect = false;
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  @override
  void initState() {
    DateTime now = DateTime.now();
    setState(() {
      date = DateFormat('dd/MM/yyyy').format(now);
    });
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      if (value) {
        setState(() {
          isConnect = true;
        });
        getAddress();
      } else {
        setState(() {
          isConnect = false;
        });
      }
    });

    super.initState();
  }

  void getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(widget.taskList.latitude),
        double.parse(widget.taskList.longitude));

    Placemark place = placemarks[0];
    setState(() {
      address = place.street!;
      area = place.administrativeArea!;
      location = place.locality!;
      postal = place.postalCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Form Survey',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 20),
            child: Text(
              '1 dari 4',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF575551),
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.white, Color(0xFFf9f9f9)],
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Informasi Pelanggan',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2D2A26),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 24),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Cabang',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: widget.taskList.branchName),
                          const SizedBox(height: 16),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Agreement No.',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: widget.taskList.agreementNo),
                          const SizedBox(height: 16),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Nama Pelanggan',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: widget.taskList.clientName),
                          const SizedBox(height: 16),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'No. Telp',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: widget.taskList.mobileNo),
                          const SizedBox(height: 16),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Type',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: widget.taskList.type),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: Colors.grey.withOpacity(0.06),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Field 1',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: 'Isi Field 1'),
                          const SizedBox(height: 16),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Field 2',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: 'Isi Field 2'),
                          const SizedBox(height: 16),
                          FormInfo1Widget(
                              widthTitle: MediaQuery.of(context).size.width,
                              title: 'Field 3',
                              heightContent: 45,
                              widthContent: MediaQuery.of(context).size.width,
                              content: 'Isi Field 3'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: Colors.grey.withOpacity(0.06),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Tanggal Survey',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF575551),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        border: Border.all(
                                            width: 1.0,
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(date,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: const Color(0xFF2D2A26)
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Pelaksana',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF575551),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Container(
                                        height: 45,
                                        padding: const EdgeInsets.all(8),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          border: Border.all(
                                              width: 1.0,
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(widget.taskList.picName,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: const Color(0xFF2D2A26)
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
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
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Column(
                                    children: [
                                      !isConnect
                                          ? Image.asset(
                                              'assets/maps_placeholder.png')
                                          : SizedBox(
                                              height: 150,
                                              width: double.infinity,
                                              child: AbsorbPointer(
                                                absorbing: true,
                                                child: FlutterMap(
                                                  options: MapOptions(
                                                    center: LatLng(
                                                        double.parse(widget
                                                            .taskList.latitude),
                                                        double.parse(widget
                                                            .taskList
                                                            .longitude)),
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
                                                        subdomains: [
                                                          'a',
                                                          'b',
                                                          'c'
                                                        ]),
                                                    MarkerLayerOptions(
                                                      markers: [
                                                        Marker(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          point: LatLng(
                                                              double.parse(widget
                                                                  .taskList
                                                                  .latitude),
                                                              double.parse(widget
                                                                  .taskList
                                                                  .longitude)),
                                                          builder: (ctx) =>
                                                              Image.asset(
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
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(!isConnect ? '-' : address,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF2D2A26),
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            !isConnect
                                                ? '-'
                                                : '$area, $location, $postal',
                                            style: const TextStyle(
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
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ButtonNext1Widget(taskList: widget.taskList))
          ],
        ),
      ),
    );
  }
}
