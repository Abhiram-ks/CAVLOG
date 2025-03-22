import 'package:admin/data/repositories/auth_repository.dart';

class LoginUsecase {
 final AuthRepository authRepository;

 LoginUsecase({required this.authRepository});

 Future<bool> execute(String email, String password){
  return authRepository.verifyAdminCredentials(email, password);
 }
}