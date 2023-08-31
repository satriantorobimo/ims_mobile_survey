class AttachmentListResponseModel {
  int? result;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  AttachmentListResponseModel(
      {this.result,
      this.statusCode,
      this.message,
      this.data,
      this.code,
      this.id});

  AttachmentListResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    statusCode = json['StatusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['StatusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['id'] = id;
    return data;
  }
}

class Data {
  int? id;
  String? taskCode;
  String? documentCode;
  String? documentName;
  String? fileName;
  String? filePath;
  String? type;
  bool? newData;

  Data(
      {this.id,
      this.taskCode,
      this.documentCode,
      this.documentName,
      this.fileName,
      this.filePath,
      this.type,
      this.newData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskCode = json['task_code'];
    documentCode = json['document_code'];
    documentName = json['document_name'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_code'] = taskCode;
    data['document_code'] = documentCode;
    data['document_name'] = documentName;
    data['file_name'] = fileName;
    data['file_path'] = filePath;
    data['type'] = type;
    return data;
  }
}
