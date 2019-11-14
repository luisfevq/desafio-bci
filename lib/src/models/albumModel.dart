// To parse this JSON data, do
//
//     final albumModel = albumModelFromJson(jsonString);

import 'dart:convert';

List<AlbumModel> albumModelFromJson(String str) => List<AlbumModel>.from(json.decode(str).map((x) => AlbumModel.fromJson(x)));

String albumModelToJson(List<AlbumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumModel {
    WrapperType wrapperType;
    Kind kind;
    int artistId;
    int collectionId;
    int trackId;
    ArtistName artistName;
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
    double collectionHdPrice;
    double trackHdPrice;
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
    String contentAdvisoryRating;
    String shortDescription;
    String longDescription;
    bool isStreamable;
    String copyright;
    String description;

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
        this.collectionHdPrice,
        this.trackHdPrice,
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
        this.contentAdvisoryRating,
        this.shortDescription,
        this.longDescription,
        this.isStreamable,
        this.copyright,
        this.description,
    });

    factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        wrapperType: wrapperTypeValues.map[json["wrapperType"]],
        kind: json["kind"] == null ? null : kindValues.map[json["kind"]],
        artistId: json["artistId"],
        collectionId: json["collectionId"],
        trackId: json["trackId"] == null ? null : json["trackId"],
        artistName: artistNameValues.map[json["artistName"]],
        collectionName: json["collectionName"],
        trackName: json["trackName"] == null ? null : json["trackName"],
        collectionCensoredName: json["collectionCensoredName"],
        trackCensoredName: json["trackCensoredName"] == null ? null : json["trackCensoredName"],
        artistViewUrl: json["artistViewUrl"],
        collectionViewUrl: json["collectionViewUrl"],
        trackViewUrl: json["trackViewUrl"] == null ? null : json["trackViewUrl"],
        previewUrl: json["previewUrl"],
        artworkUrl30: json["artworkUrl30"] == null ? null : json["artworkUrl30"],
        artworkUrl60: json["artworkUrl60"],
        artworkUrl100: json["artworkUrl100"],
        collectionPrice: json["collectionPrice"].toDouble(),
        trackPrice: json["trackPrice"] == null ? null : json["trackPrice"].toDouble(),
        collectionHdPrice: json["collectionHdPrice"] == null ? null : json["collectionHdPrice"].toDouble(),
        trackHdPrice: json["trackHdPrice"] == null ? null : json["trackHdPrice"].toDouble(),
        releaseDate: DateTime.parse(json["releaseDate"]),
        collectionExplicitness: explicitnessValues.map[json["collectionExplicitness"]],
        trackExplicitness: json["trackExplicitness"] == null ? null : explicitnessValues.map[json["trackExplicitness"]],
        discCount: json["discCount"] == null ? null : json["discCount"],
        discNumber: json["discNumber"] == null ? null : json["discNumber"],
        trackCount: json["trackCount"],
        trackNumber: json["trackNumber"] == null ? null : json["trackNumber"],
        trackTimeMillis: json["trackTimeMillis"] == null ? null : json["trackTimeMillis"],
        country: countryValues.map[json["country"]],
        currency: currencyValues.map[json["currency"]],
        primaryGenreName: primaryGenreNameValues.map[json["primaryGenreName"]],
        contentAdvisoryRating: json["contentAdvisoryRating"] == null ? null : json["contentAdvisoryRating"],
        shortDescription: json["shortDescription"] == null ? null : json["shortDescription"],
        longDescription: json["longDescription"] == null ? null : json["longDescription"],
        isStreamable: json["isStreamable"] == null ? null : json["isStreamable"],
        copyright: json["copyright"] == null ? null : json["copyright"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "wrapperType": wrapperTypeValues.reverse[wrapperType],
        "kind": kind == null ? null : kindValues.reverse[kind],
        "artistId": artistId,
        "collectionId": collectionId,
        "trackId": trackId == null ? null : trackId,
        "artistName": artistNameValues.reverse[artistName],
        "collectionName": collectionName,
        "trackName": trackName == null ? null : trackName,
        "collectionCensoredName": collectionCensoredName,
        "trackCensoredName": trackCensoredName == null ? null : trackCensoredName,
        "artistViewUrl": artistViewUrl,
        "collectionViewUrl": collectionViewUrl,
        "trackViewUrl": trackViewUrl == null ? null : trackViewUrl,
        "previewUrl": previewUrl,
        "artworkUrl30": artworkUrl30 == null ? null : artworkUrl30,
        "artworkUrl60": artworkUrl60,
        "artworkUrl100": artworkUrl100,
        "collectionPrice": collectionPrice,
        "trackPrice": trackPrice == null ? null : trackPrice,
        "collectionHdPrice": collectionHdPrice == null ? null : collectionHdPrice,
        "trackHdPrice": trackHdPrice == null ? null : trackHdPrice,
        "releaseDate": releaseDate.toIso8601String(),
        "collectionExplicitness": explicitnessValues.reverse[collectionExplicitness],
        "trackExplicitness": trackExplicitness == null ? null : explicitnessValues.reverse[trackExplicitness],
        "discCount": discCount == null ? null : discCount,
        "discNumber": discNumber == null ? null : discNumber,
        "trackCount": trackCount,
        "trackNumber": trackNumber == null ? null : trackNumber,
        "trackTimeMillis": trackTimeMillis == null ? null : trackTimeMillis,
        "country": countryValues.reverse[country],
        "currency": currencyValues.reverse[currency],
        "primaryGenreName": primaryGenreNameValues.reverse[primaryGenreName],
        "contentAdvisoryRating": contentAdvisoryRating == null ? null : contentAdvisoryRating,
        "shortDescription": shortDescription == null ? null : shortDescription,
        "longDescription": longDescription == null ? null : longDescription,
        "isStreamable": isStreamable == null ? null : isStreamable,
        "copyright": copyright == null ? null : copyright,
        "description": description == null ? null : description,
    };
}

enum ArtistName { CALIFORNICATION, NIRVANA, DAYS_BETWEEN_STATIONS, KELLS, CHANA_ROTHMAN, GILLIAN_G_GAAR, ALAN_GOODMAN }

final artistNameValues = EnumValues({
    "Alan Goodman": ArtistName.ALAN_GOODMAN,
    "Californication": ArtistName.CALIFORNICATION,
    "Chana Rothman": ArtistName.CHANA_ROTHMAN,
    "Days Between Stations": ArtistName.DAYS_BETWEEN_STATIONS,
    "Gillian G. Gaar": ArtistName.GILLIAN_G_GAAR,
    "Kells": ArtistName.KELLS,
    "Nirvana": ArtistName.NIRVANA
});

enum Explicitness { NOT_EXPLICIT }

final explicitnessValues = EnumValues({
    "notExplicit": Explicitness.NOT_EXPLICIT
});

enum Country { USA }

final countryValues = EnumValues({
    "USA": Country.USA
});

enum Currency { USD }

final currencyValues = EnumValues({
    "USD": Currency.USD
});

enum Kind { TV_EPISODE, SONG }

final kindValues = EnumValues({
    "song": Kind.SONG,
    "tv-episode": Kind.TV_EPISODE
});

enum PrimaryGenreName { COMEDY, ALTERNATIVE, ROCK, CHILDREN_S_MUSIC, BIOGRAPHIES_MEMOIRS, NEW_AGE }

final primaryGenreNameValues = EnumValues({
    "Alternative": PrimaryGenreName.ALTERNATIVE,
    "Biographies & Memoirs": PrimaryGenreName.BIOGRAPHIES_MEMOIRS,
    "Children's Music": PrimaryGenreName.CHILDREN_S_MUSIC,
    "Comedy": PrimaryGenreName.COMEDY,
    "New Age": PrimaryGenreName.NEW_AGE,
    "Rock": PrimaryGenreName.ROCK
});

enum WrapperType { TRACK, AUDIOBOOK }

final wrapperTypeValues = EnumValues({
    "audiobook": WrapperType.AUDIOBOOK,
    "track": WrapperType.TRACK
});

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
