import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:sponsor_show/slide_show.dart';
import 'package:sponsor_show/sponsor.dart';
import 'package:sponsor_show/sponsor_slide.dart';

void main() => runApp(const SponsorShowApp());

class SponsorShowApp extends StatefulWidget {
  const SponsorShowApp({super.key});

  @override
  State<SponsorShowApp> createState() => _SponsorShowAppState();
}

class _SponsorShowAppState extends State<SponsorShowApp> {
  final sponsors = ValueNotifier<List<Sponsor>>([]);
  final error = ValueNotifier<Object?>(null);

  @override
  void initState() {
    super.initState();
    openSponsorsFile();
  }

  Future<void> openSponsorsFile() async {
    try {
      final file = File('sponsors.csv');
      if (await file.exists()) {
        sponsors.value = await loadSponsors(file);
        error.value = null;
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Open sponsors file',
      );

      if (result == null || result.files.isEmpty) {
        throw Exception('No file selected.');
      }

      final path = result.files.first.path;
      if (path == null) {
        throw Exception('No file selected.');
      }

      sponsors.value = await loadSponsors(File(path));
      error.value = null;
    } catch (e) {
      if (!mounted) {
        return;
      }
      if (e is Exception) {
        error.value = e.toString().substring("Exception: ".length);
      } else {
        error.value = e;
      }
      openSponsorsFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder(
        valueListenable: error,
        builder: (context, error, widget) {
          if (error != null) {
            return Text('Something went wrong: $error');
          }
          return ValueListenableBuilder(
            valueListenable: sponsors,
            builder: (context, sponsors, widget) {
              if (sponsors.isEmpty) {
                return Container();
              }
              return SlideShow(
                slideScreenTime: (index) =>
                    sponsors[index % sponsors.length].screenTime,
                slideBuilder: (context, index) => SponsorSlide(
                  name: sponsors[index % sponsors.length].name,
                  image: sponsors[index % sponsors.length].image,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
