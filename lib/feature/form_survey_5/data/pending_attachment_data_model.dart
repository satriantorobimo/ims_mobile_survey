class PendingAttachment {
  int? ids;

  String? pModule;
  String? pHeader;
  String? pChild;
  int? pId;
  int? pFilePaths;
  String? pFileName;
  String? pBase64;
  String? imagePath;

  PendingAttachment(
      {this.ids,
      required this.pModule,
      required this.pHeader,
      required this.pChild,
      required this.pId,
      required this.pFilePaths,
      required this.pFileName,
      required this.pBase64,
      required this.imagePath});

  PendingAttachment copyWith(
      {int? ids,
      String? pModule,
      String? pHeader,
      String? pChild,
      int? pId,
      int? pFilePaths,
      String? pFileName,
      String? pBase64,
      String? imagePath}) {
    return PendingAttachment(
        ids: ids,
        pBase64: pBase64 ?? this.pBase64,
        pChild: pChild ?? this.pChild,
        pFileName: pFileName ?? this.pFileName,
        pFilePaths: pFilePaths ?? this.pFilePaths,
        pHeader: pHeader ?? this.pHeader,
        pId: pId ?? this.pId,
        pModule: pModule ?? this.pModule,
        imagePath: imagePath ?? this.imagePath);
  }
}
