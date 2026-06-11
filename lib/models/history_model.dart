class HistoryModel {
  final int id;
  final String kategoriUji;
  final String hasilPengukuran;
  final String statusMedis;
  final String createdAt;

  HistoryModel({
    required this.id,
    required this.kategoriUji,
    required this.hasilPengukuran,
    required this.statusMedis,
    required this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json["id"],
      kategoriUji: json["kategori_uji"] ?? "",
      hasilPengukuran: json["hasil_pengukuran"] ?? "",
      statusMedis: json["status_medis"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }
}
