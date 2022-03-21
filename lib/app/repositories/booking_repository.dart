import 'package:dio/dio.dart';

import '../their_models/booking_model.dart';
import '../providers/mock_provider.dart';

class BookingsRepository {
  MockApiClient _apiClient;

  BookingsRepository() {
    this._apiClient = MockApiClient(httpClient: Dio());
  }

  Future<List<Booking>> getOngoingBookings({int page}) {
    return _apiClient.getBookings(page);
  }

  Future<List<Booking>> getCompletedBookings({int page}) {
    return _apiClient.getBookings(page);
  }

  Future<List<Booking>> getArchivedBookings({int page}) {
    return _apiClient.getBookings(page);
  }

  Future<Booking> getBooking(String bookingId) {
    return _apiClient.getBooking(bookingId);
  }
}
