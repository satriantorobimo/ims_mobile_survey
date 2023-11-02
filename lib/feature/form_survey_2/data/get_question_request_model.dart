class GetQuestionReqModel {
  String? taskCode;

  GetQuestionReqModel({this.taskCode});

  GetQuestionReqModel.fromJson(Map<String, dynamic> json) {
    taskCode = json['task_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_code'] = taskCode;
    return data;
  }
}
