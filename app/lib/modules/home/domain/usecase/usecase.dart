import 'package:my_quran/modules/modules.dart';

class GetHomeDataUseCase {
  GetHomeDataUseCase(this.repository);
  final HomeRepositoryImpl repository;

  Future<HomeModel> execute(String token) async {
    return repository.getData(token);
  }
}
