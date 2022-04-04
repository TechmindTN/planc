import 'package:dio/dio.dart';

import '../their_models/statistic.dart';
import '../providers/mock_provider.dart';

class StatisticRepository {
  MockApiClient _apiClient;

  StatisticRepository() {
    this._apiClient = MockApiClient(httpClient: Dio());
  }

  Future<List<Statistic>> getHomeStatistics() {
    return _apiClient.getHomeStatistics();
  }
}
