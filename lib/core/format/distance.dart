/// "850 m", "6.8 km", "24 km" (DESIGN §8: km and m, no long decimals).
String formatDistance(int metres) {
  if (metres < 1000) return '${(metres / 10).round() * 10} m';
  final km = metres / 1000;
  return km < 10 ? '${km.toStringAsFixed(1)} km' : '${km.round()} km';
}
