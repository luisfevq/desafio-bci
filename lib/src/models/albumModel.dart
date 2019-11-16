import 'dart:convert';

List<AlbumModel> albumModelFromJson(String str) =>
    List<AlbumModel>.from(json.decode(str).map((x) => AlbumModel.fromJson(x)));

String albumModelToJson(List<AlbumModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumModel {
  WrapperType wrapperType;
  Kind kind;
  int artistId;
  int collectionId;
  int trackId;
  String artistName;
  String collectionName;
  String trackName;
  String collectionCensoredName;
  String trackCensoredName;
  String artistViewUrl;
  String collectionViewUrl;
  String trackViewUrl;
  String previewUrl;
  String artworkUrl30;
  String artworkUrl60;
  String artworkUrl100;
  double collectionPrice;
  double trackPrice;
  DateTime releaseDate;
  Explicitness collectionExplicitness;
  Explicitness trackExplicitness;
  int discCount;
  int discNumber;
  int trackCount;
  int trackNumber;
  int trackTimeMillis;
  Country country;
  Currency currency;
  PrimaryGenreName primaryGenreName;
  bool isStreamable;
  String collectionArtistName;
  int collectionArtistId;
  String collectionArtistViewUrl;
  String contentAdvisoryRating;

  AlbumModel({
    this.wrapperType,
    this.kind,
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.trackViewUrl,
    this.previewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.releaseDate,
    this.collectionExplicitness,
    this.trackExplicitness,
    this.discCount,
    this.discNumber,
    this.trackCount,
    this.trackNumber,
    this.trackTimeMillis,
    this.country,
    this.currency,
    this.primaryGenreName,
    this.isStreamable,
    this.collectionArtistName,
    this.collectionArtistId,
    this.collectionArtistViewUrl,
    this.contentAdvisoryRating,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        wrapperType: wrapperTypeValues.map[json["wrapperType"]],
        kind: kindValues.map[json["kind"]],
        artistId: json["artistId"],
        collectionId: json["collectionId"],
        trackId: json["trackId"],
        artistName: json["artistName"],
        collectionName: json["collectionName"],
        trackName: json["trackName"],
        collectionCensoredName: json["collectionCensoredName"],
        trackCensoredName: json["trackCensoredName"],
        artistViewUrl: json["artistViewUrl"],
        collectionViewUrl: json["collectionViewUrl"],
        trackViewUrl: json["trackViewUrl"],
        previewUrl: json["previewUrl"],
        artworkUrl30: json["artworkUrl30"],
        artworkUrl60: json["artworkUrl60"],
        artworkUrl100: json["artworkUrl100"],
        collectionPrice: json["collectionPrice"] == null ? 0 : json["collectionPrice"].toDouble(),
        trackPrice: json["trackPrice"] == null ? 0 : json["trackPrice"].toDouble(),
        releaseDate: DateTime.parse(json["releaseDate"]),
        collectionExplicitness:
            explicitnessValues.map[json["collectionExplicitness"]],
        trackExplicitness: explicitnessValues.map[json["trackExplicitness"]],
        discCount: json["discCount"],
        discNumber: json["discNumber"],
        trackCount: json["trackCount"],
        trackNumber: json["trackNumber"],
        trackTimeMillis: json["trackTimeMillis"],
        country: countryValues.map[json["country"]],
        currency: currencyValues.map[json["currency"]],
        primaryGenreName: primaryGenreNameValues.map[json["primaryGenreName"]],
        isStreamable: json["isStreamable"],
        collectionArtistName: json["collectionArtistName"] == null
            ? ''
            : json["collectionArtistName"],
        collectionArtistId: json["collectionArtistId"] == null
            ? 0
            : json["collectionArtistId"],
        collectionArtistViewUrl: json["collectionArtistViewUrl"] == null
            ? ''
            : json["collectionArtistViewUrl"],
        contentAdvisoryRating: json["contentAdvisoryRating"] == null
            ? ''
            : json["contentAdvisoryRating"],
      );

  Map<String, dynamic> toJson() => {
        "wrapperType": wrapperTypeValues.reverse[wrapperType],
        "kind": kindValues.reverse[kind],
        "artistId": artistId,
        "collectionId": collectionId,
        "trackId": trackId,
        "artistName": artistName,
        "collectionName": collectionName,
        "trackName": trackName,
        "collectionCensoredName": collectionCensoredName,
        "trackCensoredName": trackCensoredName,
        "artistViewUrl": artistViewUrl,
        "collectionViewUrl": collectionViewUrl,
        "trackViewUrl": trackViewUrl,
        "previewUrl": previewUrl,
        "artworkUrl30": artworkUrl30,
        "artworkUrl60": artworkUrl60,
        "artworkUrl100": artworkUrl100,
        "collectionPrice": collectionPrice == null ? 0 : collectionPrice,
        "trackPrice": trackPrice == null ? 0 : trackPrice,
        "releaseDate": releaseDate.toIso8601String(),
        "collectionExplicitness":
            explicitnessValues.reverse[collectionExplicitness],
        "trackExplicitness": explicitnessValues.reverse[trackExplicitness],
        "discCount": discCount,
        "discNumber": discNumber,
        "trackCount": trackCount,
        "trackNumber": trackNumber,
        "trackTimeMillis": trackTimeMillis,
        "country": countryValues.reverse[country],
        "currency": currencyValues.reverse[currency],
        "primaryGenreName": primaryGenreNameValues.reverse[primaryGenreName],
        "isStreamable": isStreamable,
        "collectionArtistName":
            collectionArtistName == null ? '' : collectionArtistName,
        "collectionArtistId":
            collectionArtistId == null ? 0 : collectionArtistId,
        "collectionArtistViewUrl":
            collectionArtistViewUrl == null ? '' : collectionArtistViewUrl,
        "contentAdvisoryRating":
            contentAdvisoryRating == null ? '' : contentAdvisoryRating,
      };
}

enum Explicitness { NOT_EXPLICIT, CLEANED, EXPLICIT }

final explicitnessValues = EnumValues({
  "cleaned": Explicitness.CLEANED,
  "explicit": Explicitness.EXPLICIT,
  "notExplicit": Explicitness.NOT_EXPLICIT
});

enum Country { USA }

final countryValues = EnumValues({"USA": Country.USA});

enum Currency { USD }

final currencyValues = EnumValues({"USD": Currency.USD});

enum Kind { SONG }

final kindValues = EnumValues({"song": Kind.SONG});

enum PrimaryGenreName {
  URBANO_LATINO,
  POP,
  LATINO,
  HIP_HOP_RAP,
  POP_LATINO,
  MSICA_TROPICAL,
  DANCE
}

final primaryGenreNameValues = EnumValues({
  "Dance": PrimaryGenreName.DANCE,
  "Hip-Hop/Rap": PrimaryGenreName.HIP_HOP_RAP,
  "Latino": PrimaryGenreName.LATINO,
  "Música tropical": PrimaryGenreName.MSICA_TROPICAL,
  "Pop": PrimaryGenreName.POP,
  "Pop Latino": PrimaryGenreName.POP_LATINO,
  "Urbano latino": PrimaryGenreName.URBANO_LATINO
});

enum WrapperType { TRACK }

final wrapperTypeValues = EnumValues({"track": WrapperType.TRACK});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
