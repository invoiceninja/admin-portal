// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class SettingsRepository {
  const SettingsRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<CompanyEntity> saveCompany(
      Credentials credentials, CompanyEntity company) async {
    final data = serializers.serializeWith(CompanyEntity.serializer, company);
    dynamic response;

    final url = credentials.url+ '/companies/${company.id}';
    response = await webClient.put(
      url,
      credentials.token,
      data: json.encode(data),
    );

    final CompanyItemResponse companyResponse =
        serializers.deserializeWith(CompanyItemResponse.serializer, response)!;

    return companyResponse.data;
  }

  Future<CompanyEntity> saveEInvoiceCertificate(Credentials credentials,
      CompanyEntity company, MultipartFile eInvoiceCertificate) async {
    dynamic response;

    final url = credentials.url+ '/companies/${company.id}';
    final fields = <String, String>{
      '_method': 'put',
    };

    response = await webClient.post(
      url,
      credentials.token,
      multipartFiles: [eInvoiceCertificate],
      data: fields,
    );

    final CompanyItemResponse companyResponse =
        serializers.deserializeWith(CompanyItemResponse.serializer, response)!;

    return companyResponse.data;
  }

  Future<UserEntity> saveAuthUser(
    Credentials credentials,
    UserEntity user,
    String? password,
    String? idToken,
  ) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    final url = credentials.url+ '/users/${user.id}?include=company_user';
    response = await webClient.put(
      url,
      credentials.token,
      data: json.encode(data),
      password: password,
      idToken: idToken,
    );

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<UserEntity> connectOAuthUser(
    Credentials credentials,
    String provider,
    String? password,
    String idToken,
    String accessToken,
  ) async {
    dynamic response;

    final url = credentials.url+ '/connected_account?include=company_user';
    response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'id_token': idToken,
          'access_token': accessToken,
          'provider': provider,
        },
      ),
      password: password,
    );

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<UserEntity> disconnectOAuthUser(
    Credentials credentials,
    UserEntity user,
    String? password,
    String? idToken,
  ) async {
    dynamic response;

    final url = credentials.url+
        '/users/${user.id}/disconnect_oauth?include=company_user';
    response = await webClient.post(
      url,
      credentials.token,
      password: password,
      idToken: idToken,
    );

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<UserEntity> disconnectOAuthMailer(
    Credentials credentials,
    String? password,
    String? idToken,
    String userId,
  ) async {
    dynamic response;

    final url = credentials.url+
        '/users/$userId/disconnect_mailer?include=company_user';
    response = await webClient.post(
      url,
      credentials.token,
      password: password,
    );

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<UserEntity> connectGmailUser(
    Credentials credentials,
    String? password,
    String idToken,
    String serverAuthCode,
  ) async {
    dynamic response;

    final url =
        credentials.url+ '/connected_account/gmail?include=company_user';
    response = await webClient.post(
      url,
      credentials.token,
      data: json.encode(
        {
          'id_token': idToken,
          'server_auth_code': serverAuthCode,
        },
      ),
      password: password,
      idToken: idToken,
    );

    final UserItemResponse userResponse =
        serializers.deserializeWith(UserItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<UserCompanyEntity> saveUserSettings(
      Credentials credentials, UserEntity user) async {
    final data = serializers.serializeWith(UserEntity.serializer, user);
    dynamic response;

    final url = credentials.url+ '/company_users/${user.id}';
    response = await webClient.put(
      url,
      credentials.token,
      data: json.encode(data),
    );

    final UserCompanyItemResponse userResponse = serializers.deserializeWith(
        UserCompanyItemResponse.serializer, response)!;

    return userResponse.data;
  }

  Future<BaseEntity> uploadLogo(Credentials credentials, String entityId,
      MultipartFile multipartFile, EntityType? type) async {
    final route = type == EntityType.company
        ? 'companies'
        : type == EntityType.group
            ? 'group_settings'
            : 'clients';
    final url = '${credentials.url}/$route/$entityId';

    final dynamic response = await webClient.post(url, credentials.token,
        data: {'_method': 'PUT'}, multipartFiles: [multipartFile]);

    if (type == EntityType.client) {
      return serializers
          .deserializeWith(ClientItemResponse.serializer, response)!
          .data;
    } else if (type == EntityType.group) {
      return serializers
          .deserializeWith(GroupItemResponse.serializer, response)!
          .data;
    } else {
      return serializers
          .deserializeWith(CompanyItemResponse.serializer, response)!
          .data;
    }
  }

  Future<CompanyEntity> uploadDocument(
      Credentials credentials,
      CompanyEntity company,
      List<MultipartFile> multipartFiles,
      bool isPrivate) async {
    final fields = <String, String>{
      '_method': 'put',
      'is_public': isPrivate ? '0' : '1',
    };

    final dynamic response = await webClient.post(
        '${credentials.url}/companies/${company.id}/upload', credentials.token,
        data: fields, multipartFiles: multipartFiles);

    final CompanyItemResponse companyResponse =
        serializers.deserializeWith(CompanyItemResponse.serializer, response)!;

    return companyResponse.data;
  }

  Future<bool> disableTwoFactor(
    Credentials credentials,
    String? password,
    String? idToken,
  ) async {
    await webClient.post(
      '${credentials.url}/settings/disable_two_factor',
      credentials.token,
      idToken: idToken,
      password: password,
    );

    return true;
  }
}
