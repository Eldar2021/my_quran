import 'package:my_quran/modules/modules.dart';

class GetHomeDataUseCase {
  const GetHomeDataUseCase(this.repository);

  final HomeRepository repository;

  Future<HomeModel> execute(String token) {
    return repository.getData(token);
  }
}
