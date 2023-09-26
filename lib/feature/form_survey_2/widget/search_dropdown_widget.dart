import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';

class SearchDropDownWidget extends StatefulWidget {
  const SearchDropDownWidget({super.key, required this.answerChoice});
  final List<AnswerChoice> answerChoice;
  @override
  State<SearchDropDownWidget> createState() => _SearchDropDownWidgetState();
}

class _SearchDropDownWidgetState extends State<SearchDropDownWidget> {
  final TextEditingController _searchCtrl = TextEditingController();

  List<AnswerChoice> value = [];

  List<String> valueSearch = [];

  String? selectedValue;

  @override
  void initState() {
    setState(() {
      value.addAll(widget.answerChoice);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Title',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, selectedValue);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0, color: Colors.grey.withOpacity(0.5)),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Center(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme:
                          Theme.of(context).inputDecorationTheme.copyWith(
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.grey;
                          }

                          return Colors.grey;
                        }),
                      ),
                    ),
                    child: TextFormField(
                      controller: _searchCtrl,
                      autofocus: false,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      onChanged: ((values) {
                        if (values.length > 3) {
                          setState(() {
                            valueSearch = [];
                          });
                          for (int i = 0; i < value.length; i++) {
                            if (value[i]
                                .questionOptionDesc!
                                .toLowerCase()
                                .contains(values.toLowerCase())) {
                              setState(() {
                                valueSearch.add(value[i].questionOptionDesc!);
                              });
                            }
                          }
                        }

                        if (values.length < 3) {
                          setState(() {
                            valueSearch = [];
                          });
                        }
                      }),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.5)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Cari',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
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
              ),
            ),
            Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    scrollDirection: Axis.vertical,
                    itemCount:
                        valueSearch.isEmpty ? value.length : valueSearch.length,
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedValue = valueSearch.isEmpty
                                ? value[index].questionOptionDesc!
                                : valueSearch[index];
                          });
                          Navigator.pop(context, selectedValue);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                valueSearch.isEmpty
                                    ? value[index].questionOptionDesc!
                                    : valueSearch[index],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF575551)),
                              ),
                              if (valueSearch.isEmpty
                                  ? selectedValue ==
                                      value[index].questionOptionDesc
                                  : selectedValue == valueSearch[index]) ...[
                                const Icon(
                                  Icons.circle,
                                  size: 16,
                                  color: primaryColor,
                                )
                              ]
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
