import 'package:my_quran/modules/modules.dart';

class GetHomeDataUseCase {
  const GetHomeDataUseCase(this.repository);

  final HomeRepository repository;

  Future<HomeEntity> execute(String token) {
    return repository.getData(token);
  }
}
