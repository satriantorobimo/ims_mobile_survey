import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';
import 'package:mobile_survey/utility/general_util.dart';

import '../../../components/color_comp.dart';

class Radio2Widget extends StatefulWidget {
  const Radio2Widget(
      {super.key,
      required this.id,
      required this.onChanged,
      required this.title,
      required this.answerChoice});
  final int id;
  final Function(AnswerChoice?) onChanged;
  final String title;
  final List<AnswerChoice> answerChoice;

  @override
  State<Radio2Widget> createState() => _Radio2WidgetState();
}

class _Radio2WidgetState extends State<Radio2Widget> {
  late AnswerChoice selectedAnswer = AnswerChoice();

  setSelectedValue(AnswerChoice answerChoice) {
    setState(() {
      selectedAnswer = answerChoice;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];

    for (AnswerChoice answer in widget.answerChoice) {
      widgets.add(
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.38,
          child: RadioListTile<AnswerChoice?>(
            value: answer,
            groupValue: selectedAnswer,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(
              answer.questionOptionDesc!
                  .toLowerCase()
                  .capitalizeOnlyFirstLater(),
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2D2A26)),
            ),
            onChanged: (answerChoice) {
              setSelectedValue(answerChoice!);
            },
            selected: selectedAnswer == answer,
            activeColor: primaryColor,
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF575551),
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: createRadioListUsers(),
          )
        ],
      ),
    );
  }
}
