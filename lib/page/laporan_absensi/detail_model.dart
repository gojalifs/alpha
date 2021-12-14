class DetailKehadiran {
  String id, tanggal, jamMasuk, jamKeluar, jamOT;

  DetailKehadiran({
    required this.id,
    required this.tanggal,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.jamOT,
  });

  factory DetailKehadiran.fomJson(Map<String, dynamic> jsonData) =>
      DetailKehadiran(
          id: jsonData['id'],
          tanggal: jsonData['tanggal'],
          jamMasuk: jsonData['jam_masuk'],
          jamKeluar: jsonData['jam_keluar'],
          jamOT: jsonData['jam_OT']);
}
