import 'dart:io';

class Sponsor {
  Sponsor({
    required this.name,
    required this.image,
    required this.amount,
  });

  factory Sponsor.fromCsv(String csv) {
    final split = csv.split(';');
    if (split.length != 3) {
      throw Exception(
        'expected 3 elements in the csv (csv=$csv) (expected csv format: {name};{image};{amount})',
      );
    }
    final amount = double.tryParse(split[2]);
    if (amount == null) {
      throw Exception(
        'could not parse amount (value=${split[2]}) (expected csv format: {name};{image};{amount})',
      );
    }
    return Sponsor(name: split[0], image: File(split[1]), amount: amount);
  }

  final String name;
  final File image;
  final double amount;

  Duration get screenTime => Duration(seconds: amount.toInt());
}

Future<List<Sponsor>> loadSponsors(File csvFile) async {
  return csvFile
      .readAsLines()
      .then((lines) => lines.map(Sponsor.fromCsv).toList(growable: false));
}
