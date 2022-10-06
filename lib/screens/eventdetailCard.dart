import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair22_3rdyear/constants/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailCard extends StatelessWidget {
  const EventDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
      child: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: const [
                SizedBox(height: 30),
                Image(image: AssetImage("assets/images/eventDetail.png")),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 14, right: 14),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Description :",
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididun ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500),
                  // softWrap: true,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _launchUrl(Uri.parse("https://github.com/sohail2000"));
                    Future.delayed(const Duration(milliseconds: 3000), () {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff9E9EEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Register"),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw 'Could not launch $url';
    }
  }
}
