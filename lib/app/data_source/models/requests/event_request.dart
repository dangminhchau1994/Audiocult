class EventRequest {
  final String? query;
  final String? postalCode;
  final String? location;
  final String? countryIso;
  final String? view;
  final String? distance;
  final String? when;
  final String? startTime;
  final String? endTime;
  final String? sort;
  final String? userId;
  final int? page;
  final int? limit;

  EventRequest({
    this.query,
    this.postalCode,
    this.location,
    this.countryIso,
    this.view,
    this.distance,
    this.when,
    this.startTime,
    this.endTime,
    this.sort,
    this.page,
    this.limit,
    this.userId
  });
}
