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
  String? isRequired;
  bool? newData;

  Data(
      {this.id,
      this.taskCode,
      this.documentCode,
      this.documentName,
      this.fileName,
      this.filePath,
      this.type,
      this.isRequired,
      this.newData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskCode = json['task_code'];
    documentCode = json['document_code'];
    documentName = json['document_name'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    type = json['type'];
    isRequired = json['is_required'];
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
    data['is_required'] = isRequired;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_code': taskCode,
      'document_code': documentCode,
      'document_name': documentName,
      'file_name': fileName,
      'file_path': filePath,
      'type': type,
      'is_required': isRequired
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
        id: map['id'],
        taskCode: map['task_code'],
        documentCode: map['document_code'],
        documentName: map['document_name'],
        fileName: map['file_name'],
        filePath: map['file_path'],
        type: map['type'],
        isRequired: map['is_required']);
  }
}
