class BookingModel {
  final String id;
  final String lapanganId;
  final String lapanganNama;
  final String lapanganLokasi;
  final String lapanganImage;
  final DateTime tanggal;
  final String jamMulai;
  final String jamSelesai;
  final int durasi;
  final int totalHarga;
  final String metodePembayaran;
  final String status;
  final String kodeBooking;
  final String userEmail;

  BookingModel({
    required this.id,
    required this.lapanganId,
    required this.lapanganNama,
    required this.lapanganLokasi,
    required this.lapanganImage,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.durasi,
    required this.totalHarga,
    required this.metodePembayaran,
    required this.status,
    required this.kodeBooking,
    required this.userEmail,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      lapanganId: json['lapanganId'],
      lapanganNama: json['lapanganNama'],
      lapanganLokasi: json['lapanganLokasi'],
      lapanganImage: json['lapanganImage'],
      tanggal: DateTime.parse(json['tanggal']),
      jamMulai: json['jamMulai'],
      jamSelesai: json['jamSelesai'],
      durasi: json['durasi'],
      totalHarga: json['totalHarga'],
      metodePembayaran: json['metodePembayaran'],
      status: json['status'],
      kodeBooking: json['kodeBooking'],
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lapanganId': lapanganId,
      'lapanganNama': lapanganNama,
      'lapanganLokasi': lapanganLokasi,
      'lapanganImage': lapanganImage,
      'tanggal': tanggal.toIso8601String(),
      'jamMulai': jamMulai,
      'jamSelesai': jamSelesai,
      'durasi': durasi,
      'totalHarga': totalHarga,
      'metodePembayaran': metodePembayaran,
      'status': status,
      'kodeBooking': kodeBooking,
      'userEmail': userEmail,
    };
  }

  String get formattedTanggal {
    final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final dayName = days[tanggal.weekday - 1];
    return '$dayName, ${tanggal.day} ${months[tanggal.month - 1]} ${tanggal.year}';
  }

  String get formattedHarga {
    return 'Rp ${_formatNumber(totalHarga)}';
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}
