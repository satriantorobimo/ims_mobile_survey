class User {
  final int id;

  final String idpp;
  final String ucode;
  final String name;
  final String systemDate;
  final String branchCode;
  final String branchName;
  final String companyCode;
  final String companyName;
  final String deviceId;

  User(
      {required this.ucode,
      required this.id,
      required this.name,
      required this.systemDate,
      required this.branchCode,
      required this.branchName,
      required this.idpp,
      required this.companyCode,
      required this.companyName,
      required this.deviceId});
}
