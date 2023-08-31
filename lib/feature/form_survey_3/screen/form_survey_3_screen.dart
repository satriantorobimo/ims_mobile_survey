import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_survey/components/loading_grid_comp.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/args_preview_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import '../widget/button_next_3_widget.dart';
import 'package:path/path.dart' as path;

class FormSurvey3Screen extends StatefulWidget {
  const FormSurvey3Screen({super.key, required this.argsSubmitDataModel});
  final ArgsSubmitDataModel argsSubmitDataModel;
  @override
  State<FormSurvey3Screen> createState() => _FormSurvey3ScreenState();
}

class _FormSurvey3ScreenState extends State<FormSurvey3Screen> {
  bool isLoading = true;

  late List<Data> data = [];

  Future pickImage(String type, int index) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage = await imagePicker.pickImage(
        source: type == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 90,
      );
      if (pickedImage == null) return;
      String basename = path.basename(pickedImage.path);
      setState(() {
        data[index].filePath = pickedImage.path;
        data[index].fileName = basename;
        data[index].newData = true;
      });

      return;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  void _imageAction(int index) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actionsPadding:
              const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Select Source',
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage('gallery', index);
                      // _pickFotoFromGallery(type, isRetake, index);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo_library_rounded, size: 60),
                          SizedBox(height: 16),
                          Text(
                            'Gallery',
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
                    onTap: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      final result = await Navigator.pushNamed(
                          context, StringRouterUtil.formTakePicScreenRoute,
                          arguments: firstCamera);

                      if (result != null) {
                        setState(() {
                          data[index].filePath = result.toString();
                          data[index].fileName =
                              path.basename(result.toString());
                          data[index].newData = true;
                        });
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo_camera_rounded, size: 60),
                          SizedBox(height: 16),
                          Text(
                            'Camera',
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
              )
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
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
                    child: Text('Tutup',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        );
      },
    );
  }

  _getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final attachmentListDao = database.attachmentListDao;

    await attachmentListDao
        .findAttachmentListByCode(widget.argsSubmitDataModel.taskList.code)
        .then((value) async {
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          setState(() {
            data.add(Data(
                documentCode: value[i].documentCode,
                documentName: value[i].documentName,
                fileName: value[i].fileName,
                filePath: value[i].filePath,
                id: value[i].id,
                taskCode: value[i].taskCode,
                type: value[i].type));
          });
        }
      } else {}
    });

    setState(() {
      isLoading = false;
      database.close();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

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
              '3 dari 4',
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
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Attachment',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2D2A26),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 24),
                      isLoading
                          ? const LoadingGridComp(
                              height: 90,
                              length: 5,
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 12);
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: data.isEmpty ? 0 : data.length,
                              padding: const EdgeInsets.only(bottom: 24),
                              itemBuilder: (context, index) {
                                final ext =
                                    path.extension(data[index].fileName!);
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Row(
                                    children: [
                                      data[index].filePath != "" &&
                                              data[index].fileName != ""
                                          ? InkWell(
                                              onTap: () {
                                                if (ext == '.PDF') {
                                                  if (data[index].newData !=
                                                      null) {
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        StringRouterUtil
                                                            .previewPdfNetworkScreenRoute,
                                                        arguments:
                                                            ArgsPreviewAttachmentModel(
                                                                data[index]
                                                                    .fileName!,
                                                                data[index]
                                                                    .filePath!));
                                                  }
                                                } else {
                                                  if (data[index].newData !=
                                                      null) {
                                                    Navigator.pushNamed(
                                                        context,
                                                        StringRouterUtil
                                                            .previewImageAssetScreenRoute,
                                                        arguments: data[index]
                                                            .filePath);
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        StringRouterUtil
                                                            .previewImageNetworkScreenRoute,
                                                        arguments:
                                                            ArgsPreviewAttachmentModel(
                                                                data[index]
                                                                    .fileName!,
                                                                data[index]
                                                                    .filePath!));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                  color: Colors.white,
                                                  width: 70,
                                                  height: 70,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Icon(
                                                      ext == '.PDF'
                                                          ? Icons.picture_as_pdf
                                                          : Icons.image,
                                                      size: 25,
                                                      color: const Color(
                                                          0xFF575551),
                                                    ),
                                                  )),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                _imageAction(index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFF9F9F9),
                                                    width: 1.0,
                                                  ),
                                                  color:
                                                      const Color(0xFFF9F9F9),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                width: 70,
                                                height: 70,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.camera_alt_rounded,
                                                    size: 25,
                                                    color: Color(0xFF575551),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]
                                                .documentName!
                                                .toLowerCase()
                                                .capitalizeOnlyFirstLater(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF2D2A26),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Ambil ${data[index].documentName!.toLowerCase().capitalizeOnlyFirstLater()}',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF575551),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      data[index].filePath != "" &&
                                              data[index].fileName != ""
                                          ? Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _imageAction(index);
                                                  },
                                                  child: const Text(
                                                    'Retake',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                );
                              })
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ButtonNext3Widget(
                  data: data,
                  results: widget.argsSubmitDataModel.answerResults,
                  taskList: widget.argsSubmitDataModel.taskList,
                ))
          ],
        ),
      ),
    );
  }
}
