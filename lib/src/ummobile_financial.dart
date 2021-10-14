import 'package:ummobile_sdk/src/models/financial/movement.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/src/utils/utils.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API financial section requests.
class UMMobileFinancial {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'financial';

  /// Main UMMobile financial client constructor.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileFinancial({
    required String token,
    String version: latestVersion,
  }) : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => token,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        );

  /// Retrieve the balances.
  ///
  /// Also can [includeMovements] on the balances if it is specified.
  Future<List<Balance>> getBalances({
    IncludeMovements includeMovements: IncludeMovements.None,
  }) {
    return this._http.customGet(
        path: '/balances?includeMovements=${includeMovements.index}',
        mapper: (json) => List.from(json)
            .map((e) => Balance(
                  id: e['id'],
                  name: e['name'],
                  current: e['current'] is int
                      ? e['current'].toDouble()
                      : e['current'],
                  currentDebt: e['currentDebt'] is int
                      ? e['currentDebt'].toDouble()
                      : e['currentDebt'],
                  type: e['type'],
                  movements: includeMovements != IncludeMovements.None
                      ? this._mapMovements(e['movements'], balanceId: e['id'])
                      : null,
                ))
            .toList());
  }

  /// Retrieve the [balance] movements.
  ///
  /// Also can [includeLastYear] movements if it is specified.
  Future<Movements> getMovements(
    String balance, {
    bool includeLastYear: false,
  }) {
    return this._http.customGet(
          path: '/balances/$balance/movements?includeLastYear=$includeLastYear',
          mapper: (json) => _mapMovements(json, balanceId: balance),
        );
  }

  Movements _mapMovements(dynamic json, {String? balanceId}) {
    return Movements(
      balanceId: json['balanceId'] ?? balanceId ?? '',
      current:
          List.from(json['current']).map((e) => _mapSingleMovement(e)).toList(),
      lastYear: json['lastYear'] != null
          ? List.from(json['lastYear'])
              .map((e) => this._mapSingleMovement(e))
              .toList()
          : null,
    );
  }

  Movement _mapSingleMovement(dynamic json) {
    return Movement(
      id: json['id'],
      amount:
          json['amount'] is int ? json['amount'].toDouble() : json['amount'],
      balanceAfterThis: json['balanceAfterThis'] is int
          ? json['balanceAfterThis'].toDouble()
          : json['balanceAfterThis'],
      type: getMovementsTypeFromString(json['type'] ?? ''),
      description: json['description'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
