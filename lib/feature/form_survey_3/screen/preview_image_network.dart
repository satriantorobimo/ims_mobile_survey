import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/bloc/preview_attachment_bloc%20/bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/data/args_preview_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';

class PreviewImageNetworkScreen extends StatefulWidget {
  final ArgsPreviewAttachmentModel argsPreviewAttachmentModel;
  const PreviewImageNetworkScreen(this.argsPreviewAttachmentModel, {super.key});

  @override
  State<PreviewImageNetworkScreen> createState() =>
      _PreviewImageNetworkScreenState();
}

class _PreviewImageNetworkScreenState extends State<PreviewImageNetworkScreen> {
  PreviewAttachmentBloc previewAttachmentBloc =
      PreviewAttachmentBloc(attachmentListRepo: AttachmentListRepo());

  @override
  void initState() {
    previewAttachmentBloc.add(PreviewAttachmentAttempt(
        widget.argsPreviewAttachmentModel.fileName,
        widget.argsPreviewAttachmentModel.filePath));
    super.initState();
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
                      if (state is PreviewAttachmentLoaded) {}
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
                            return mainContent(state
                                .previewAttachmentResponseModel.value!.data!);
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
