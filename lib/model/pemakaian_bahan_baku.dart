class PemakaianBahanBaku {
  final int id;
  final int bahanBakuId;
  final int jumlah;

  PemakaianBahanBaku({
    required this.id,
    required this.bahanBakuId,
    required this.jumlah,
  });

  factory PemakaianBahanBaku.fromJson(Map<String, dynamic> json) {
    return PemakaianBahanBaku(
      id: json['id'],
      bahanBakuId: json['bahan_baku_id'],
      jumlah: json['jumlah'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bahan_baku_id': bahanBakuId,
      'jumlah': jumlah,
    };
  }
}


