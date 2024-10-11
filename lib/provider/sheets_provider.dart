import 'dart:convert';
import 'dart:developer';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

class SheetsDatabase {
  static SheetsDatabase helper = SheetsDatabase._createInstance();

  final _spreadsheetId = "1nld8o3rhWFEIg88JbJsUOvAWzlqezjd9bCa5u0Omnco";
  final _sheetName = 'Sheets1';

  SheetsDatabase._createInstance();

  Future<auth.AuthClient> getAuthClient() async {
    var credentialsJson =
        await rootBundle.loadString('assets/credentials.json');
    var credentials =
        auth.ServiceAccountCredentials.fromJson(json.decode(credentialsJson));
    final scopes = [
      sheets.SheetsApi.spreadsheetsScope,
      drive.DriveApi.driveScope
    ];
    return await auth.clientViaServiceAccount(credentials, scopes);
  }

  Future<String?> submitData(List<String> parsedResponse) async {
    var client = await getAuthClient();
    try {
      var dio = Dio();

      if (parsedResponse.length > 18277) {
        log('Too many columns generated from the CSV string.');
        return "Código Incorreto - Número de campos diferentes do esperado.";
      }

      var accessToken = client.credentials.accessToken;
      var headers = {
        'Authorization': '${accessToken.type} ${accessToken.data}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var insertRange = '$_sheetName!A:A';
      var requestBody = {
        'values': [parsedResponse]
      };
      log('Request Body for Insert: $requestBody');
      var responseResult = await dio.post(
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/$insertRange:append?valueInputOption=RAW',
        options: Options(
          headers: headers,
        ),
        data: jsonEncode(requestBody),
      );

      log('Response from API: ${responseResult.data}');
      log('Data submitted successfully');
      return "success";
    } catch (e) {
      log('Error submitting data: $e');

      return "Erro ao submeter os dados: $e";
    }
  }
}
