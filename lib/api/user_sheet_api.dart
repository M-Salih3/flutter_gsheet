import 'package:database/model/user.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credantails = r'''
{
  "type": "service_account",
  "project_id": "gsheets-399604",
  "private_key_id": "430c187ad1b228867d17a7e328e1ad1f061db50c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC6HvbR6hI6XDKt\nR7iACh9A1tXlyX7AwgXOKgoPQKTEb0NXkttLNm/cLcUwhZyyv+H7IkuBcsmtDu48\ny6emeq9jzPshq2m3tALHiLjLkmwkaSdba06lD0jjFlj4pTPCZLrN5xOckR1ioXyy\nuPXdvlG38gli8FVH5tqnX5WEkKezapAWXDbfN7Y51jyciqyYrW3ZdY1FkTaHaY7C\n2ysQio14JHEgJW3K2BvVbb32Rh4pQwsZAK4jUXmBFvztr1GZJE/dRGccgSuU8MFI\ncg7sLHk65RJ6DVuYE3jWnGn1+vCi1yRjr2IMkuUWtYTVwyEV0RwYx3tQc6I/i/Tp\nvlXePP2XAgMBAAECggEATVR/LZFo+GmFPry9WimaeaipX5t7+B/FJLcPze2IZ/to\nifLA/XuFN4Cm3PWuuRADlwHVSFgGlkpNTuI46nEv/THWJ9OeDY8T1o6mZSKVnv03\ntoKbvvXeTUfkOI7/NeX/PXykh9k9UdURx/oUYYjpUBmWr852SHUQ5RjQOS+XFfJb\nEze8ygYtpZP8Azf3/NdHoYf6jDyDpib21FosetQB28zT/yQVtUAJJxIFdlyKiOJU\nwDLBIPJiCzvp26GUj3C5Bvb8z79ucbv2u9dqcFDXFZ8+A6tl9svxuNYTigJH/TtR\nh7SofrnSledQcigQrjCZDya0CLUWlWVrM4+1bS7sJQKBgQDt5u4vL/cRqDfErWhr\nOCbmNY0pmg3iKU3s6N/Qz4Vr1vnMWhvEocbJNWhhT2yH7cvAs95SOfUGSaEgfCr2\nqjD6pV8b6moOjOtUb3V18AlMX7M2yrEQEUscT/Q4sGP4UIjfP6I5+Vsb9x66y/k/\nqqP+IkZUScC0Mx0fy9q4Q8P3DQKBgQDIR5zGSOl755Xx81FTvEN0Ygeq6IiGZrRh\nMtmiqjNA8q+R0zQwsLYRPaownayKSwIOdbRVh9ywAsKjXbfHrSt3GsKUnqSpXyat\nyAeSQE9stRPmFX7K9oHOo7zqKYq122RODaQXlfecwCUunJ4TUd1WcyvpUKtZd2Fl\nkAjO8GxeMwKBgCF1RfBK/aN1FgrKHJJfvlDIHUdJjERPbM8x3TBfzzLgdBdCYP9h\nhTSNF1YANpJTZkF+ynikAArXVhrce6pfOy41DdA+QpYzSXGBj3J7xMMB/pFpJkfN\nNtQPhphmbljg8q77IxSmNiMTuTWqNC65EAFQzrVR/hEZ0zHCmMsrdKcNAoGBAIg5\nLUkxDp5YRoTrGsX5p2fhxZVZ1IKWGNqD28PoQDRM3V4yaa00hKH1b2zh0hm+Kwfq\nx13lqxWMyxaTCA2om4fHi9HKlfUd4xEQnRW86EjoYUB+Hl+ui1whwr0CxHYtY2wz\nmwjv2BumFaQ+osZBSGskqxlm5SVVLcoGzfbzUMJBAoGAZhixPhUASk61OC1852O9\nHOBiI3+J5BwgT7pEbw/vSaRXEcY1GLnjrnbCkwR2L2AXYnzkqUZafxEBKLZmZptQ\nGSQFXP/3aTJkl1uJb4lndaAM4XACOi2QuQ1S/ws9hfCCDQvalxZgN9FEk4g5pBi4\n+LuWxYtmNujqakVGytdqsTQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-399604.iam.gserviceaccount.com",
  "client_id": "111152581645782908633",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-399604.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  static final _spreadsheetId = '1uTrobRvYDo9KdH6Y1sZEp4GH-LXJlmyuXv1-uNjXqPo';
  static final _gsheets = GSheets(_credantails);
  static Worksheet? _userSheet;

  static Future init() async {
    try{
      final Spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorkSheet(Spreadsheet, title: 'users');

    final firstRow = UserFields.getFields();
    _userSheet!.values.insertRow(1,firstRow);

    }catch(e){
      print('init error : $e');
    }
    
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;

    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<User>> getAll() async{
    if(_userSheet == null) return <User>[];

    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();

  }
  static Future<User?> getById(int id) async{
    if (_userSheet == null) return null;
    
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future insert(List<Map<String,dynamic>> rowList)async{
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

}