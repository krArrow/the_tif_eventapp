import 'package:intl/intl.dart';

class AutoGenerate {
  AutoGenerate({
    required this.content,
    required this.status,
  });

  late final Content content;
  late bool status;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    content = Content.fromJson(json['content']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Content {
  Content({
    required this.data,
    required this.meta,
  });

  late final List<Data> data;
  late final Meta meta;

  Content.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  late final int id;
  late final String title;
  late final String description;
  late final String bannerImage;
  late final String dateTime;
  late final String organiserName;
  late final String organiserIcon;
  late final String venueName;
  late final String venueCity;
  late final String venueCountry;

  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  // Named constructor for JSON parsing
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['banner_image'],
      dateTime: json['date_time'],
      organiserName: json['organiser_name'],
      organiserIcon: json['organiser_icon'],
      venueName: json['venue_name'],
      venueCity: json['venue_city'],
      venueCountry: json['venue_country'],
    );
  }

  late String newDateTime = getDateTime();

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['banner_image'] = bannerImage;
    _data['date_time'] = dateTime;
    _data['new_date_time'] = newDateTime;
    _data['organiser_name'] = organiserName;
    _data['organiser_icon'] = organiserIcon;
    _data['venue_name'] = venueName;
    _data['venue_city'] = venueCity;
    _data['venue_country'] = venueCountry;
    return _data;
  }

  String getDateTime() {
    // Parse the provided date-time string
    DateTime parsedDateTime = DateTime.parse(dateTime);

    // Format the date and time components with short month and day names
    String dayName = DateFormat('E').format(parsedDateTime); // Short day name (e.g., Wed)
    String monthName = DateFormat('MMM').format(parsedDateTime); // Short month name (e.g., Mar)
    String date = DateFormat('dd').format(parsedDateTime); // Day of the month (e.g., 01)
    String hoursMinutes = DateFormat('hh:mm a').format(parsedDateTime);

    return "$dayName, $monthName $date • $hoursMinutes";
  }
}

class Meta {
  Meta({
    required this.total,
  });

  late final int total;

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    return _data;
  }
}
