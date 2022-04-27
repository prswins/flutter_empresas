// To parse this JSON data, do
//
//     final getEnterpriseListResponse = getEnterpriseListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetEnterpriseListResponse getEnterpriseListResponseFromJson(String str) => GetEnterpriseListResponse.fromJson(json.decode(str));

String getEnterpriseListResponseToJson(GetEnterpriseListResponse data) => json.encode(data.toJson());

class GetEnterpriseListResponse {
    GetEnterpriseListResponse({
        required this.enterprises,
    });

    List<Enterpris> ? enterprises;

    factory GetEnterpriseListResponse.fromJson(Map<String, dynamic> json) => GetEnterpriseListResponse(
        enterprises: json["enterprises"] == null ? null : List<Enterpris>.from(json["enterprises"].map((x) => Enterpris.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "enterprises": enterprises == null ? null : List<dynamic>.from(enterprises!.map((x) => x.toJson())),
    };
}

class Enterpris {
    Enterpris({
        required this.id,
        required this.emailEnterprise,
        required this.facebook,
        required this.twitter,
        required this.linkedin,
        required this.phone,
        required this.ownEnterprise,
        required this.enterpriseName,
        required this.photo,
        required this.description,
        required this.city,
        required this.country,
        required this.value,
        required this.sharePrice,
        required this.enterpriseType,
    });

    int id;
    dynamic emailEnterprise;
    dynamic facebook;
    dynamic twitter;
    dynamic linkedin;
    dynamic phone;
    bool ownEnterprise;
    String enterpriseName;
    String photo;
    String description;
    String city;
    String country;
    int value;
    double sharePrice;
    EnterpriseType ?enterpriseType;

    factory Enterpris.fromJson(Map<String, dynamic> json) => Enterpris(
        id: json["id"] == null ? null : json["id"],
        emailEnterprise: json["email_enterprise"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        phone: json["phone"],
        ownEnterprise: json["own_enterprise"] == null ? null : json["own_enterprise"],
        enterpriseName: json["enterprise_name"] == null ? null : json["enterprise_name"],
        photo: json["photo"] == null ? null : json["photo"],
        description: json["description"] == null ? null : json["description"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        value: json["value"] == null ? null : json["value"],
        sharePrice: json["share_price"] == null ? null : json["share_price"].toDouble(),
        enterpriseType: json["enterprise_type"] == null ? null : EnterpriseType.fromJson(json["enterprise_type"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email_enterprise": emailEnterprise,
        "facebook": facebook,
        "twitter": twitter,
        "linkedin": linkedin,
        "phone": phone,
        "own_enterprise": ownEnterprise == null ? null : ownEnterprise,
        "enterprise_name": enterpriseName == null ? null : enterpriseName,
        "photo": photo == null ? null : photo,
        "description": description == null ? null : description,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "value": value == null ? null : value,
        "share_price": sharePrice == null ? null : sharePrice,
        "enterprise_type": enterpriseType == null ? null : enterpriseType!.toJson(),
    };
}

class EnterpriseType {
    EnterpriseType({
        required this.id,
        required this.enterpriseTypeName,
    });

    int id;
    String enterpriseTypeName;

    factory EnterpriseType.fromJson(Map<String, dynamic> json) => EnterpriseType(
        id: json["id"] == null ? null : json["id"],
        enterpriseTypeName: json["enterprise_type_name"] == null ? null : json["enterprise_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "enterprise_type_name": enterpriseTypeName == null ? null : enterpriseTypeName,
    };
}
