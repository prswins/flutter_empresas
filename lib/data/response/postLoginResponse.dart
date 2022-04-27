// To parse this JSON data, do
//
//     final postLoginResponse = postLoginResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostLoginResponse postLoginResponseFromJson(String str) => PostLoginResponse.fromJson(json.decode(str));

String postLoginResponseToJson(PostLoginResponse data) => json.encode(data.toJson());

class PostLoginResponse {
    PostLoginResponse({
        required this.investor,
        required this.enterprise,
        required this.success,
    });

    Investor ? investor;
    dynamic enterprise;
    bool success;

    factory PostLoginResponse.fromJson(Map<String, dynamic> json) => PostLoginResponse(
        investor: json["investor"] == null ? null : Investor.fromJson(json["investor"]),
        enterprise: json["enterprise"],
        success: json["success"] == null ? null : json["success"],
    );

    Map<String, dynamic> toJson() => {
        "investor": investor == null ? null : investor!.toJson(),
        "enterprise": enterprise,
        "success": success == null ? null : success,
    };
}

class Investor {
    Investor({
        required this.id,
        required this.investorName,
        required this.email,
        required this.city,
        required this.country,
        required this.balance,
        required this.photo,
        required this.portfolio,
        required this.portfolioValue,
        required this.firstAccess,
        required this.superAngel,
    });

    int id;
    String investorName;
    String email;
    String city;
    String country;
    double balance;
    dynamic photo;
    Portfolio ? portfolio;
    double portfolioValue;
    bool firstAccess;
    bool superAngel;

    factory Investor.fromJson(Map<String, dynamic> json) => Investor(
        id: json["id"] == null ? null : json["id"],
        investorName: json["investor_name"] == null ? null : json["investor_name"],
        email: json["email"] == null ? null : json["email"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        photo: json["photo"],
        portfolio: json["portfolio"] == null ? null : Portfolio.fromJson(json["portfolio"]),
        portfolioValue: json["portfolio_value"] == null ? null : json["portfolio_value"].toDouble(),
        firstAccess: json["first_access"] == null ? null : json["first_access"],
        superAngel: json["super_angel"] == null ? null : json["super_angel"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "investor_name": investorName == null ? null : investorName,
        "email": email == null ? null : email,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "balance": balance == null ? null : balance,
        "photo": photo,
        "portfolio": portfolio == null ? null : portfolio!.toJson(),
        "portfolio_value": portfolioValue == null ? null : portfolioValue,
        "first_access": firstAccess == null ? null : firstAccess,
        "super_angel": superAngel == null ? null : superAngel,
    };
}

class Portfolio {
    Portfolio({
        required this.enterprisesNumber,
        required this.enterprises,
    });

    int enterprisesNumber;
    List<dynamic>? enterprises;

    factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        enterprisesNumber: json["enterprises_number"] == null ? null : json["enterprises_number"],
        enterprises: json["enterprises"] == null ? null : List<dynamic>.from(json["enterprises"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "enterprises_number": enterprisesNumber == null ? null : enterprisesNumber,
        "enterprises": enterprises == null ? null : List<dynamic>.from(enterprises!.map((x) => x)),
    };
}
