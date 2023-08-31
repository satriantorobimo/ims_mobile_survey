import 'package:floor/floor.dart';

@entity
class AttachmentList {
  @PrimaryKey(autoGenerate: true)
  int? ids;

  int id;
  String taskCode;
  String documentCode;
  String documentName;
  String fileName;
  String filePath;
  String type;

  AttachmentList(
      {required this.id,
      required this.taskCode,
      required this.documentCode,
      required this.documentName,
      required this.type,
      required this.fileName,
      required this.filePath});

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
