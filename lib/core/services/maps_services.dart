import 'package:url_launcher/url_launcher.dart';

class MapsServices {
  Future<bool> openGoogleMaps(double lat, double lng) async {
    final Uri uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    } else {
      return false;
    }
  }

}