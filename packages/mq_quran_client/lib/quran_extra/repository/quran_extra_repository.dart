abstract interface class QuranExtraRepository {
  Future<bool> setDonPages({
    required List<int> pageNumber,
    required String status,
    String? hatimId,
  });
}
