import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:provider/provider.dart';

import '../../../components/color_comp.dart';
import '../../../utility/string_router_util.dart';
import '../data/hubungan_model.dart';
import '../provider/form_survey_4_provider.dart';

class FormSurvey4Screen extends StatefulWidget {
  const FormSurvey4Screen({super.key, required this.argsSubmitDataModel});
  final ArgsSubmitDataModel argsSubmitDataModel;

  @override
  State<FormSurvey4Screen> createState() => _FormSurvey4ScreenState();
}

class _FormSurvey4ScreenState extends State<FormSurvey4Screen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _phoneAreaCtrl = TextEditingController();
  final TextEditingController _remarkCtrl = TextEditingController();
  final TextEditingController _nilaiCtrl = TextEditingController();

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    super.initState();
  }

  void _sumberInformasiDetail(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actionsPadding:
                const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Detail Sumber Informasi',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D2A26)),
              ),
            ),
            titlePadding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            contentPadding: const EdgeInsets.only(
              top: 0,
              bottom: 24,
              left: 24,
              right: 24,
            ),
            content: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nama',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF575551),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _nameCtrl,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
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
                          'Phone Area',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF575551),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _phoneAreaCtrl,
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
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
                          'Phone',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF575551),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
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
                          'Remark',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF575551),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _remarkCtrl,
                            autofocus: false,
                            maxLines: 5,
                            maxLength: 240,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
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
                          'Nilai',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF575551),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _nilaiCtrl,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.05)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            actions: [
              InkWell(
                onTap: () {
                  setState(() {
                    Provider.of<FormSurvey4Provider>(context, listen: false)
                        .setHubunganModel(HubunganModel(
                            name: _nameCtrl.text,
                            phoneArea: _phoneAreaCtrl.text,
                            phoneNumber: _phoneCtrl.text,
                            remark: _remarkCtrl.text,
                            value: double.parse(_nilaiCtrl.text),
                            taskCode:
                                widget.argsSubmitDataModel.taskList.code));
                    _nameCtrl.clear();
                    _phoneAreaCtrl.clear();
                    _phoneCtrl.clear();
                    _remarkCtrl.clear();
                    _nilaiCtrl.clear();
                  });

                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Center(
                      child: Text('Tambah Sumber Informasi',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600))),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var formSurvey4Provider = Provider.of<FormSurvey4Provider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              '4 dari 4',
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
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.white, Color(0xFFf9f9f9)],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 80, top: 16, left: 16, right: 16),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hubungan dengan Debitur',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF2D2A26),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 24),
                    formSurvey4Provider.listHubunganModel.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFF9F9F9),
                                width: 1.0,
                              ),
                              color: const Color(0xFFF9F9F9),
                            ),
                            width: double.infinity,
                            height: 100,
                            child: const Center(
                              child: Text(
                                'Belum ada sumber informasi',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF575551),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                formSurvey4Provider.listHubunganModel.length,
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                              );
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                  color: Colors.transparent,
                                ),
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${formSurvey4Provider.listHubunganModel[index].name}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF2D2A26),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${formSurvey4Provider.listHubunganModel[index].value}',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '(${formSurvey4Provider.listHubunganModel[index].phoneArea}) ${formSurvey4Provider.listHubunganModel[index].phoneNumber}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF2D2A26),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${formSurvey4Provider.listHubunganModel[index].remark}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF2D2A26),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              );
                            }),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                          onPressed: () {
                            _sumberInformasiDetail(context);
                          },
                          // ignore: sort_child_properties_last
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.person_add,
                                color: primaryColor,
                                size: 22,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Tambah Sumber Informasi',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0))),
                            side: MaterialStateProperty.all(const BorderSide(
                              color: primaryColor,
                            )),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    color: const Color(0xFFf9f9f9),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 45,
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              // ignore: sort_child_properties_last
                              child: const Text(
                                'Sebelumnya',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0))),
                                side:
                                    MaterialStateProperty.all(const BorderSide(
                                  color: primaryColor,
                                )),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, StringRouterUtil.form5ScreenRoute,
                                arguments: ArgsSubmitDataModel(
                                    answerResults: widget
                                        .argsSubmitDataModel.answerResults,
                                    taskList:
                                        widget.argsSubmitDataModel.taskList,
                                    uploadAttachment: widget
                                        .argsSubmitDataModel.uploadAttachment,
                                    refrence:
                                        formSurvey4Provider.listHubunganModel));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Center(
                                child: Text('Berikutnya',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
