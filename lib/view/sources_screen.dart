import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souls_master/constants/scaffold_bg.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesScreen extends StatelessWidget {
  const SourcesScreen({super.key});

  void _launchURL() async {
    final Uri url =
        Uri.parse('https://darksouls.wiki.fextralife.com/Dark+Souls+Wiki');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(61, 255, 255, 255),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                'منابع',
                style: textTheme.titleMedium!.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/icons/master.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: const Color.fromARGB(255, 31, 31, 31).withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'تمامی مطالب از وبسایت ',
                        style: textTheme.titleMedium?.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text: 'Fextra Life',
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _launchURL,
                          ),
                          TextSpan(
                            text: '\nجمع‌آوری و ترجمه شده است.',
                            style:
                                textTheme.titleMedium?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
