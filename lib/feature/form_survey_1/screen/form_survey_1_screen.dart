import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

import '../../../components/color_comp.dart';

class FormSurvey1Screen extends StatefulWidget {
  const FormSurvey1Screen({super.key});

  @override
  State<FormSurvey1Screen> createState() => _FormSurvey1ScreenState();
}

class _FormSurvey1ScreenState extends State<FormSurvey1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
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
                                        'Cabang',
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
                                        child: Text('Semarang',
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
                                        'Agreement No.',
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
                                          child: Text('97934793532',
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
                                    'Nama Pelanggan',
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Dimas',
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
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'No. Telp',
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('081232357382',
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
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Kategori Lokasi',
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Tempat Kerja',
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Field 1',
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Isi Field 1',
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
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Field 2',
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Isi Field 2',
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
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Field 3',
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Isi Field 3',
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
                                        child: Text('07/07/2023',
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
                                          child: Text('Surveyor',
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
                                      Image.asset(
                                          'assets/maps_placeholder.png'),
                                      const SizedBox(height: 16),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'JL. Majapahit no 45 RT 08 RW 09',
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
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, StringRouterUtil.form2ScreenRoute);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                          child: Text('Berikutnya',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
