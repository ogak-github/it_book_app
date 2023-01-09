import 'dart:convert';

class Book {
  String? error;
  String title;
  String? subtitle;
  String? authors;
  String? publisher;
  String? isbn10;
  String? isbn13;
  String? pages;
  String? year;
  String? rating;
  String? desc;
  String? price;
  String? image;
  String? url;
  List<Pdf>? pdf;

  Book({
    this.error,
    required this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.isbn10,
    this.isbn13,
    this.pages,
    this.year,
    this.desc,
    this.rating,
    this.price,
    this.image,
    this.url,
    this.pdf,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final pdf = <Pdf>[];
    if (json['pdf'] != null) {
      for (var data in json['pdf']) {
        pdf.add(data.toJson());
      }
    }

    return Book(
      error: json['error'],
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      publisher: json['publisher'],
      isbn10: json['isbn10'],
      isbn13: json['isbn13'],
      pages: json['pages'],
      year: json['year'],
      desc: json['desc'],
      rating: json['rating'],
      price: json['price'],
      image: json['image'],
      url: json['url'],
      pdf: pdf,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'authors': authors,
        'publisher': publisher,
        'isbn10': isbn10,
        'isbn13': isbn13,
        'pages': pages,
        'year': year,
        'desc': desc,
        'rating': rating,
        'price': price,
        'image': image,
        'url': url
      };
}

class Pdf {
  String? chapter, url;

  Pdf({
    this.chapter,
    this.url,
  });

  Map<String, dynamic> toJson() => {
        'chapter': chapter,
        'url': url,
      };
}
