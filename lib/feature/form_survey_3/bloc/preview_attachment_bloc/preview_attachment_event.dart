import 'package:equatable/equatable.dart';

abstract class PreviewAttachmentEvent extends Equatable {
  const PreviewAttachmentEvent();
}

class PreviewAttachmentAttempt extends PreviewAttachmentEvent {
  const PreviewAttachmentAttempt(this.fileName, this.filePath);
  final String fileName;
  final String filePath;

  @override
  List<Object> get props => [fileName, filePath];
}
