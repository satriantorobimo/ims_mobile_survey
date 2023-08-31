import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/bloc/preview_attachment_bloc%20/bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/data/args_preview_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PreviewPdfNetworkScreen extends StatefulWidget {
  final ArgsPreviewAttachmentModel argsPreviewAttachmentModel;
  const PreviewPdfNetworkScreen(this.argsPreviewAttachmentModel, {super.key});

  @override
  State<PreviewPdfNetworkScreen> createState() =>
      _PreviewPdfNetworkScreenState();
}

class _PreviewPdfNetworkScreenState extends State<PreviewPdfNetworkScreen> {
  PreviewAttachmentBloc previewAttachmentBloc =
      PreviewAttachmentBloc(attachmentListRepo: AttachmentListRepo());

  @override
  void initState() {
    previewAttachmentBloc.add(PreviewAttachmentAttempt(
        widget.argsPreviewAttachmentModel.fileName,
        widget.argsPreviewAttachmentModel.filePath));
    super.initState();
  }

  createPdf(String base64pdf, String fileName) async {
    var bytes = base64Decode(base64pdf.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    await OpenFile.open("${output.path}/$fileName");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocListener(
                    bloc: previewAttachmentBloc,
                    listener: (_, PreviewAttachmentState state) {
                      if (state is PreviewAttachmentLoaded) {
                        createPdf(
                            state.previewAttachmentResponseModel.value!.data!,
                            state.previewAttachmentResponseModel.value!
                                .filename!);
                      }
                      if (state is PreviewAttachmentError) {}
                    },
                    child: BlocBuilder(
                        bloc: previewAttachmentBloc,
                        builder: (_, PreviewAttachmentState state) {
                          if (state is PreviewAttachmentLoading) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          if (state is PreviewAttachmentLoaded) {
                            return Container();
                          }
                          if (state is PreviewAttachmentError) {
                            return Container();
                          }
                          return Container();
                        })),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: Text(
                        'BACK',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainContent(String value) {
    return Center(
      child: Image.memory(
        base64Decode(value),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
