import 'dart:developer';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/components/loading_grid_comp.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_2/widget/button_next_2_widget.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/general_util.dart';
import '../../../utility/string_router_util.dart';
import '../widget/drop_down_search_widget.dart';

class FormSurvey2Screen extends StatefulWidget {
  const FormSurvey2Screen({super.key, required this.taskList});
  final TaskList taskList;

  @override
  State<FormSurvey2Screen> createState() => _FormSurvey2ScreenState();
}

class _FormSurvey2ScreenState extends State<FormSurvey2Screen> {
  late List<Data> data = [];
  late List<AnswerResultsModel> results = [];
  bool isLoading = true;
  late final List<TextEditingController> controllers = [];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _getData();
    });
    super.initState();
  }

  Widget txtBox(String subLabel, int index, int isMandatory) {
    if (widget.taskList.status == 'WAITING' ||
        widget.taskList.status == 'DONE') {
      controllers[index].text = data[index].answer!;
    }
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF575551),
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: subLabel),
                    TextSpan(
                        text: isMandatory == 1 ? ' *' : ' ',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        )),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: TextFormField(
                controller: controllers[index],
                autofocus: false,
                enabled: widget.taskList.status == 'WAITING' ||
                        widget.taskList.status == 'DONE'
                    ? false
                    : true,
                readOnly: widget.taskList.status == 'WAITING' ||
                        widget.taskList.status == 'DONE'
                    ? true
                    : false,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    fontSize: 15.0,
                    color: widget.taskList.status == 'WAITING' ||
                            widget.taskList.status == 'DONE'
                        ? Colors.grey
                        : Colors.black),
                onEditingComplete: () {
                  var isData = results.where(
                      (element) => element.pCode!.contains(data[index].code!));
                  if (isData.isNotEmpty) {
                    results.removeWhere((element) =>
                        element.pCode!.contains(data[index].code!));
                    results.add(AnswerResultsModel(
                        pAnswer: controllers[index].text,
                        pCode: data[index].code!));
                  } else {
                    results.add(AnswerResultsModel(
                        pAnswer: controllers[index].text,
                        pCode: data[index].code!));
                  }
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: widget.taskList.status == 'WAITING' ||
                          widget.taskList.status == 'DONE'
                      ? Colors.grey.withOpacity(0.05)
                      : Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget radioBtn(
      List<AnswerChoice> value, String title, int index, String code) {
    final List<String> listQuestion =
        value.map((val) => val.questionOptionDesc!).toList();

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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF575551),
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: title),
                    const TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        )),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          SizedBox(
            height: 50.0,
            child: RadioGroup<String>.builder(
              direction: Axis.horizontal,
              groupValue: data[index].answer ?? '',
              horizontalAlignment: MainAxisAlignment.spaceAround,
              onChanged: widget.taskList.status == 'WAITING' ||
                      widget.taskList.status == 'DONE'
                  ? null
                  : (values) async {
                      setState(() {
                        data[index].answer = values;
                        for (int i = 0; i < value.length; i++) {
                          if (value[i].questionOptionDesc == values) {
                            if (results.isEmpty) {
                              results.add(AnswerResultsModel(
                                  pAnswerChoiceId: value[i].id, pCode: code));
                            } else {
                              var isData = results.where((element) =>
                                  element.pCode!.contains(data[index]
                                      .answerChoice![i]
                                      .questionCode!));
                              if (isData.isNotEmpty) {
                                results.removeWhere((element) => element.pCode!
                                    .contains(data[index]
                                        .answerChoice![i]
                                        .questionCode!));
                                results.add(AnswerResultsModel(
                                    pAnswerChoiceId: value[i].id, pCode: code));
                              } else {
                                results.add(AnswerResultsModel(
                                    pAnswerChoiceId: value[i].id, pCode: code));
                              }
                            }
                          }
                        }
                      });
                    },
              activeColor: widget.taskList.status == 'WAITING' ||
                      widget.taskList.status == 'DONE'
                  ? Colors.grey
                  : primaryColor,
              items: listQuestion,
              textStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFF2D2A26),
              ),
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final questionListDao = database.questionListDao;
    final answerListDao = database.answerListDao;
    late List<Data> datas = [];
    await questionListDao
        .findQuestionListByTaskCode(widget.taskList.code)
        .then((value) async {
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          controllers.add(TextEditingController());
          late List<AnswerChoice> answerList = [];
          log('lalala ${value[i]!.code}');
          await answerListDao
              .findAnswerListByCode(value[i]!.code)
              .then((values) {
            if (values.isNotEmpty) {
              for (int x = 0; x < values.length; x++) {
                answerList.add(AnswerChoice(
                    id: values[x].id,
                    questionOptionDesc: values[x].questionOptionDesc,
                    questionCode: value[i]!.questionCode));

                if (x == values.length - 1) {
                  datas.add(Data(
                      answerChoice: answerList,
                      answer: value[i]!.answer,
                      answerChoiceId: value[i]!.answerChoiceId,
                      code: value[i]!.code,
                      questionCode: value[i]!.questionCode,
                      questionDesc: value[i]!.questionDesc,
                      taskCode: value[i]!.taskCode,
                      type: value[i]!.type));
                }
              }
            } else {
              datas.add(Data(
                  answerChoice: [],
                  answer: value[i]!.answer,
                  answerChoiceId: value[i]!.answerChoiceId,
                  code: value[i]!.code,
                  questionCode: value[i]!.questionCode,
                  questionDesc: value[i]!.questionDesc,
                  taskCode: value[i]!.taskCode,
                  type: value[i]!.type));
            }
          });
        }
      } else {}
    });

    setState(() {
      data.addAll(datas);
      isLoading = false;
      database.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Form Survey ${widget.taskList.type.toLowerCase().capitalizeOnlyFirstLater()}',
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16, top: 20),
              child: Text(
                '2 dari 4',
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
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pertanyaan Survey',
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
                        : Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 12);
                                },
                                scrollDirection: Axis.vertical,
                                itemCount: data.length,
                                padding: const EdgeInsets.only(bottom: 80),
                                itemBuilder: (context, index) {
                                  final List<String> ddItems = [];

                                  for (int i = 0;
                                      i < data[index].answerChoice!.length;
                                      i++) {
                                    ddItems.add(data[index]
                                        .answerChoice![i]
                                        .questionOptionDesc!);
                                  }
                                  return data[index].type == 'DROPDOWN LIST'
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              width: 1.0,
                                            ),
                                            color: Colors.transparent,
                                          ),
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.78,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF575551),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: data[index]
                                                                .questionDesc!
                                                                .toLowerCase()
                                                                .capitalizeOnlyFirstLater()),
                                                        const TextSpan(
                                                            text: ' *',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.red,
                                                            )),
                                                      ],
                                                    ),
                                                  )),
                                              const SizedBox(height: 16),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.83,
                                                child: CustomDropdownButton2(
                                                    onChanged: widget.taskList
                                                                    .status ==
                                                                'WAITING' ||
                                                            widget.taskList
                                                                    .status ==
                                                                'DONE'
                                                        ? null
                                                        : (values) {
                                                            setState(() {
                                                              data[index]
                                                                      .answer =
                                                                  values;
                                                              for (int i = 0;
                                                                  i <
                                                                      data[index]
                                                                          .answerChoice!
                                                                          .length;
                                                                  i++) {
                                                                if (data[index]
                                                                        .answerChoice![
                                                                            i]
                                                                        .questionOptionDesc ==
                                                                    values) {
                                                                  if (results
                                                                      .isEmpty) {
                                                                    results.add(AnswerResultsModel(
                                                                        pAnswerChoiceId: data[index]
                                                                            .answerChoice![
                                                                                i]
                                                                            .id,
                                                                        pCode: data[index]
                                                                            .code));
                                                                  } else {
                                                                    var isData = results.where((element) => element
                                                                        .pCode!
                                                                        .contains(data[index]
                                                                            .answerChoice![i]
                                                                            .questionCode!));

                                                                    if (isData
                                                                        .isNotEmpty) {
                                                                      results.removeWhere((element) => element
                                                                          .pCode!
                                                                          .contains(data[index]
                                                                              .answerChoice![i]
                                                                              .questionCode!));
                                                                      results.add(AnswerResultsModel(
                                                                          pAnswerChoiceId: data[index]
                                                                              .answerChoice![
                                                                                  i]
                                                                              .id,
                                                                          pCode:
                                                                              data[index].code));
                                                                    } else {
                                                                      results.add(AnswerResultsModel(
                                                                          pAnswerChoiceId: data[index]
                                                                              .answerChoice![
                                                                                  i]
                                                                              .id,
                                                                          pCode:
                                                                              data[index].code));
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            });
                                                          },
                                                    dropdownItems: ddItems,
                                                    buttonWidth:
                                                        double.infinity,
                                                    buttonHeight: 47,
                                                    dropdownWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.78,
                                                    icon: const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                    ),
                                                    iconSize: 20,
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                      color: widget.taskList
                                                                      .status ==
                                                                  'WAITING' ||
                                                              widget.taskList
                                                                      .status ==
                                                                  'DONE'
                                                          ? Colors.grey
                                                              .withOpacity(0.05)
                                                          : Colors.white,
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5)),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10.0)),
                                                    ),
                                                    hint: 'Pilih Jawaban',
                                                    value: data[index].answer ==
                                                            ""
                                                        ? null
                                                        : data[index].answer),
                                              ),
                                            ],
                                          ),
                                        )
                                      : data[index].type == 'RADIO BUTTON'
                                          ? radioBtn(
                                              data[index].answerChoice!,
                                              data[index]
                                                  .questionDesc!
                                                  .toLowerCase()
                                                  .capitalizeOnlyFirstLater(),
                                              index,
                                              data[index].code!)
                                          : data[index].type == 'LOOKUP LIST'
                                              ? DropDownSearchWidget(
                                                  title: data[index]
                                                      .questionDesc!
                                                      .toLowerCase()
                                                      .capitalizeOnlyFirstLater(),
                                                  hint: 'Pilih Jawaban',
                                                  value: data[index].answer,
                                                  enabled:
                                                      widget.taskList.status ==
                                                                  'WAITING' ||
                                                              widget.taskList
                                                                      .status ==
                                                                  'DONE'
                                                          ? false
                                                          : true,
                                                  onTap:
                                                      widget.taskList.status ==
                                                                  'WAITING' ||
                                                              widget.taskList
                                                                      .status ==
                                                                  'DONE'
                                                          ? null
                                                          : () async {
                                                              final result = await Navigator.pushNamed(
                                                                  context,
                                                                  StringRouterUtil
                                                                      .searchDropdownScreenRoute,
                                                                  arguments: data[
                                                                          index]
                                                                      .answerChoice);

                                                              if (result !=
                                                                  null) {
                                                                setState(() {
                                                                  data[index]
                                                                          .answer =
                                                                      result
                                                                          .toString();
                                                                });
                                                                for (int i = 0;
                                                                    i <
                                                                        data[index]
                                                                            .answerChoice!
                                                                            .length;
                                                                    i++) {
                                                                  if (data[index]
                                                                          .answerChoice![
                                                                              i]
                                                                          .questionOptionDesc ==
                                                                      result) {
                                                                    if (results
                                                                        .isEmpty) {
                                                                      results.add(AnswerResultsModel(
                                                                          pAnswerChoiceId: data[index]
                                                                              .answerChoice![
                                                                                  i]
                                                                              .id,
                                                                          pCode:
                                                                              data[index].code));
                                                                    } else {
                                                                      var isData = results.where((element) => element
                                                                          .pCode!
                                                                          .contains(data[index]
                                                                              .answerChoice![i]
                                                                              .questionCode!));

                                                                      if (isData
                                                                          .isNotEmpty) {
                                                                        results.removeWhere((element) => element
                                                                            .pCode!
                                                                            .contains(data[index].answerChoice![i].questionCode!));
                                                                        results.add(AnswerResultsModel(
                                                                            pAnswerChoiceId:
                                                                                data[index].answerChoice![i].id,
                                                                            pCode: data[index].code));
                                                                      } else {
                                                                        results.add(AnswerResultsModel(
                                                                            pAnswerChoiceId:
                                                                                data[index].answerChoice![i].id,
                                                                            pCode: data[index].code));
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                )
                                              : txtBox(
                                                  data[index]
                                                      .questionDesc!
                                                      .toLowerCase()
                                                      .capitalizeOnlyFirstLater(),
                                                  index,
                                                  1);
                                }),
                          ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ButtonNext2Widget(
                    results: results,
                    taskList: widget.taskList,
                    lengthQuestion: data.length,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
