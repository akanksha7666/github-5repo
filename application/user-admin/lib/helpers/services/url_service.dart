import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static goToUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  static goToPurchase() {
    goToUrl('');
  }

  static goToPagger() {
    goToUrl('https://getappui.com/pagger');
  }

  static getCurrentUrl() {
    var path = Uri.base.path;
    path = path.replaceAll('admin/user/add', 'admin/user/list');
    path = path.replaceAll('admin/user/edit', 'admin/user/list');
    path = path.replaceAll('admin/user/detail', 'admin/user/list');
    path = path.replaceAll('admin/subscription/add', 'admin/subscription/list');
    path = path.replaceAll('admin/subscription/edit', 'admin/subscription/list');
    path = path.replaceAll('/admin/SignUpFormList/SignUpForm', 'admin/SignUpFormList');
    return path;
  }
}
