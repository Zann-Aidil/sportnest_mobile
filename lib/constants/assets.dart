class AppAssets {
  static const String iconSemua = 'assets/images/icons/semua.png';
  static const String iconFutsal = 'assets/images/icons/futsal.png';
  static const String iconBasket = 'assets/images/icons/basket.png';
  static const String iconBadminton = 'assets/images/icons/badminton.png';
  static const String iconTenis = 'assets/images/icons/tenis.png';
  
  static String getKategoriIcon(String kategori) {
    if (kategori.toLowerCase().contains('futsal')) return iconFutsal;
    if (kategori.toLowerCase().contains('basket')) return iconBasket;
    if (kategori.toLowerCase().contains('badminton')) return iconBadminton;
    if (kategori.toLowerCase().contains('tenis')) return iconTenis;
    return iconSemua;
  }
}
