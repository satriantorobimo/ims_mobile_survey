import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/form_survey_3/bloc/preview_attachment_bloc%20/bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/data/args_preview_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

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

  void _sessionExpired() {
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
          title: Container(),
          titlePadding: const EdgeInsets.only(top: 20, left: 20),
          contentPadding: const EdgeInsets.only(
            top: 0,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Sesi anda telah habis',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 8),
              Text(
                'Silahkan Login ulang',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF575551)),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                        context, StringRouterUtil.reloginScreenRoute)
                    .then((value) {
                  previewAttachmentBloc.add(PreviewAttachmentAttempt(
                      widget.argsPreviewAttachmentModel.fileName,
                      widget.argsPreviewAttachmentModel.filePath));
                });
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text('Ok',
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
                      if (state is PreviewAttachmentException) {
                        if (state.error == 'expired') {
                          _sessionExpired();
                        }
                      }
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
