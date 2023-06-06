import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/assignment/widget/card_widget.dart';
import 'package:provider/provider.dart';

import '../provider/assignment_provider.dart';

class ListViewAssignmentWidget extends StatefulWidget {
  const ListViewAssignmentWidget({super.key});

  @override
  State<ListViewAssignmentWidget> createState() =>
      _ListViewAssignmentWidgetState();
}

class _ListViewAssignmentWidgetState extends State<ListViewAssignmentWidget> {
  void _showDetail() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 80,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xFFBBB9B5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Assignment Detail',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D2A26)),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Customer',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dimas',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF575551)),
                          ),
                          Text(
                            'Jl Badak no. 3, Kel. Gayamsari, Kec. Gayamsari, Semarang',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF575551)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Agreement No:',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const Text(
                        '992746583',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF575551)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    GestureDetector(
                      onTap: _showActionHubungi,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Text(
                          '081272959749',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1872FA)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Location Category',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const Text(
                        'Tempat Kerja',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF575551)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: Text('Lakukan Survey',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }

  void _showActionHubungi() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        height: 5,
                        decoration: const BoxDecoration(
                            color: Color(0xFFBBB9B5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Hubungi via',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2A26)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icon/phone.png', width: 64),
                                const SizedBox(height: 16),
                                const Text(
                                  'Panggilan (phone)',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF575551)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icon/wa.png', width: 64),
                                const SizedBox(height: 16),
                                const Text(
                                  'Text (WhatsApp)',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF575551)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                            child: Text('Tutup',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    var assignmentProvider =
        Provider.of<AssignmentProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          scrollDirection: Axis.vertical,
          itemCount: assignmentProvider.length,
          padding: const EdgeInsets.only(bottom: 24),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: _showDetail,
              child: assignmentProvider.index == 0
                  ? CardWidget(
                      color: secondaryColor,
                      colorBg: secondaryColor.withOpacity(0.4),
                      label: 'Ongoing',
                      name: 'Donny')
                  : assignmentProvider.index == 1
                      ? const CardWidget(
                          color: primaryColor,
                          colorBg: Color(0xFFFECCCC),
                          label: 'Waiting',
                          name: 'Ahmad')
                      : assignmentProvider.index == 2
                          ? CardWidget(
                              color: thirdColor,
                              colorBg: thirdColor.withOpacity(0.4),
                              label: 'Returned',
                              name: 'Johnny')
                          : CardWidget(
                              color: fifthColor,
                              colorBg: fifthColor.withOpacity(0.4),
                              label: 'Selesai',
                              name: 'Lala'),
            );
          }),
    );
  }
}
