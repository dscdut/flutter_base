import 'package:flutter_unihack_template/common/constants/endpoints.dart';
import 'package:flutter_unihack_template/common/helpers/dio_helper.dart';
import 'package:flutter_unihack_template/data/dtos/auth/login_by_email_request_dto.dart';
import 'package:flutter_unihack_template/data/dtos/auth/login_response_dto.dart';
import 'package:flutter_unihack_template/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRemoteDataSource {
  UserRemoteDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  final DioHelper _dioHelper;

  Future<LoginResponseDTO> loginByEmail(LoginByEmailRequestDTO params) async {
    final response = await _dioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );

    return LoginResponseDTO(
      user: UserModel.fromJson(response.data['data']['user'] as Map<String, dynamic>),
      refreshToken: response.data['data']['token']['refreshToken'] as String,
      accessToken: response.data['data']['token']['accessToken'] as String,
      expiresIn: response.data['data']['token']['expiresIn'] as int,
    );
  }
}
