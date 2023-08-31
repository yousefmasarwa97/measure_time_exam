import 'package:excel_example/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-397411",
  "private_key_id": "1597d5e526d61e77ce7baaa2e00dd12152dcfc93",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDd1N3heJVfWp2m\n8Ew029vbulzVHYE1nNGhB89IilLD9Iqws6rb1kMOVptsZUiSvnw6l87iNUN3lgcB\n7YyqPg+StqK6yxz7EtEuCJPK52nM3J9mNR8VlgmZwuPScV5fCFoKaIyPxYAo1OE3\n+IKOuj2Coi3Mnrz8SWfNhrnZa7JXtCvrpThhT415avlvpKKjcqDEERFOCZLUppMG\ncRp3Sqn6zDcHJT5OxPCmdytA/rU7jiD+rlV5IQGJZCZb0vm17YqpfYQ76kTWIiGa\n+AwSnhFVOD8+m06fmKzSD2b6syojsjRhonPv2CxyuDYb3GKbAMzNk0QHLnSAWRo4\najtnqv/FAgMBAAECggEABh5fTwnJbPY4j6iPIYzIQAOgQzdAyh7HiskxXCSHQI/C\nh48ycO/fAkqR7OfPnE8+vqBTUi/6lWuA8/pTvUUK9EFaCbbyggZfLgWJ4LiIquA8\nUVBjyW+jAie7AEyk4rrTPk2V8EftT12tJ027ztNaQPvXhuOrU3Ye3oS5zu0b396z\nhQfriyQqQvn5lI3IHpvo01s7t6iPrCqgJ4+uIa+60y8aF79nUd9Vzmzs3gcmI+ow\nbi9ZkPFiT9P0q0gITvqZYmD8ez2SK4Ul6XrSz3Ct36PyTqxQ9+pUpjYrycgf4VxO\neSYNUMn9liCKDeRw9StqKhK4pEtBZHExZGvPWBLfYQKBgQD9WM4uuFYH7/7hNHRr\nZ8z3A4DTI5AHJ/ZeVKmGHjmFR/ShFH+iqePkbYg9zDVVk3fv73nThpbPAYeSRkw8\nQtdJdpPk2a3Pdtwun16ieaqjskxT9V1CmqINa6LCOxReUnpKkQ6FfS4owGZVFbDz\nXzEITUtgu0i9xrRwVe7IdJL9nQKBgQDgJ5J1wP8tMZW/B975AcSduWE3AYHmxi9J\nfGmimXned8AJrADNE8S448+isB9oMSCTSj6A3g8wVEZAEgczCfizBDhh76ixE0Xv\nZo8grGzMbb7YLJgexlNNm+9DdoKRQojNJKwhN5zilpeHpgjafo5K1BaY/dUkPVAw\nDXVkhVsGSQKBgBJC+Hm9p9Xiosiw80NatBeKFRsjERqy8rtR9vZH73V//k4uIBUl\nkdvBWXS6541Hl/mflXR92xkIzzDoCE6/sq0E8xwn5LNzqeNicXvcsUQjcgULRrGq\nW8wD2jON9qXl5BLD6fwNTep6E+ZGLf8c+XfTun86gL/NNuxyBUhFvuKxAoGBAJ4G\nB9CQANVhkYodCGpPfscau5hFrch9izSpSudgf3QAxBeNdPsepp8Zq3Wr6FhR2f88\nZhf/dIHDx8q/aufmbbf2j7ErfadoSPNfQCPuqrzr2ZEYzx1S/8NE3UaYM7AoUb0d\nz2OTizyKocT1nmQ6uCG0p0GwISTtPKzDsDDvep5RAoGBAOTc2Nrwt8HfzkzDUauo\nFZ0olrNLNsYyjARS80i8W33MjL3aytwDFzitYNtgnrUffSJWtbKiAA5L2kavT17i\nJDXYsERvmvbeKyIn6UnQFby2DqdwiM4pkFC1KJq6tZofBpNxWf0oLpQGnEgTMnBn\nubnuKavmUu3mRLHOg/nGX7aa\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-397411.iam.gserviceaccount.com",
  "client_id": "102654425533166069784",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-397411.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';
  static final _spreadsheetId = '1KXViHx1iGwVjQmVvnjUEcVrBMPNy4LqX5NA79G-EVpE';

  static final _gsheets = GSheets(_credentials);

  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
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

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(
    String name,
    Map<String, dynamic> user,
  ) async {
    if (_userSheet == null) return false;
    return _userSheet!.values.map.insertRowByKey(name, user);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.insertValueByKeys(
      value,
      columnKey: key,
      rowKey: id,
    );
  }
}
