class LapanganModel {
  final String id;
  final String nama;
  final String lokasi;
  final String kategori;
  final double rating;
  final int jumlahUlasan;
  final int hargaPerJam;
  final String deskripsi;
  final List<String> fasilitas;
  final String imageUrl;
  final bool isAvailable;

  LapanganModel({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.kategori,
    required this.rating,
    required this.jumlahUlasan,
    required this.hargaPerJam,
    required this.deskripsi,
    required this.fasilitas,
    required this.imageUrl,
    this.isAvailable = true,
  });

  String get formattedPrice {
    return 'Rp ${_formatNumber(hargaPerJam)} / jam';
  }

  String get formattedPriceShort {
    return 'Rp ${_formatNumber(hargaPerJam)}';
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

class LapanganData {
  static List<LapanganModel> dummyLapangan = [
    LapanganModel(
      id: '1',
      nama: 'The Elite Futsal Nest',
      lokasi: 'Medan Pancing',
      kategori: 'Futsal',
      rating: 4.9,
      jumlahUlasan: 120,
      hargaPerJam: 250000,
      deskripsi:
          'Lapangan futsal standar, rumput sintetis berkualitas, fasilitas lengkap dan nyaman.',
      fasilitas: ['Parkir', 'Mushola', 'Toilet', 'Kantin', 'Wi-Fi'],
      imageUrl: 'futsal',
    ),
    LapanganModel(
      id: '2',
      nama: 'Gaperta Town',
      lokasi: 'Medan Kota',
      kategori: 'Basket',
      rating: 4.7,
      jumlahUlasan: 98,
      hargaPerJam: 180000,
      deskripsi:
          'Lapangan basket indoor dengan fasilitas modern dan pencahayaan terbaik.',
      fasilitas: ['Parkir', 'Toilet', 'Kantin', 'Wi-Fi'],
      imageUrl: 'basket',
    ),
    LapanganModel(
      id: '3',
      nama: 'Nest Badminton Hall',
      lokasi: 'Medan Perjuangan',
      kategori: 'Badminton',
      rating: 4.9,
      jumlahUlasan: 75,
      hargaPerJam: 80000,
      deskripsi:
          'Gedung badminton dengan 8 lapangan, AC sentral, dan lantai karet berkualitas.',
      fasilitas: ['Parkir', 'Toilet', 'Mushola', 'Wi-Fi'],
      imageUrl: 'badminton',
    ),
    LapanganModel(
      id: '4',
      nama: 'The Force LeftDelta',
      lokasi: 'Medan Tembung',
      kategori: 'Tenis',
      rating: 4.5,
      jumlahUlasan: 62,
      hargaPerJam: 120000,
      deskripsi:
          'Lapangan tenis outdoor dengan permukaan hard court, pemandangan kota yang indah.',
      fasilitas: ['Parkir', 'Toilet', 'Kantin'],
      imageUrl: 'tenis',
    ),
    LapanganModel(
      id: '5',
      nama: 'Pro Futsal Center',
      lokasi: 'Medan ',
      kategori: 'Futsal',
      rating: 4.3,
      jumlahUlasan: 45,
      hargaPerJam: 200000,
      deskripsi:
          'Lapangan futsal profesional dengan tribun penonton dan sistem pencahayaan LED.',
      fasilitas: ['Parkir', 'Toilet', 'Kantin', 'Mushola'],
      imageUrl: 'futsal',
    ),
  ];
}
