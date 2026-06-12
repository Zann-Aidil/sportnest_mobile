class UserModel {
  final String id;
  final String namaLengkap;
  final String email;
  final String noTelepon;
  final String? fotoProfil;

  UserModel({
    required this.id,
    required this.namaLengkap,
    required this.email,
    required this.noTelepon,
    this.fotoProfil,
  });
}
