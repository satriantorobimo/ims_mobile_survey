class PreviewAttachmentResponseModel {
  Value? value;
  int? statusCode;
  String? message;

  PreviewAttachmentResponseModel({this.value, this.statusCode, this.message});

  PreviewAttachmentResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class Value {
  String? data;
  String? filename;

  Value({this.data, this.filename});

  Value.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['filename'] = filename;
    return data;
  }
}
