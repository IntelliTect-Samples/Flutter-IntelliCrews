import 'package:integration_test/integration_test_driver.dart';
import 'package:webkit_inspection_protocol/webkit_inspection_protocol.dart';

Future<void> main() async {
  final chromeConnection = ChromeConnection('localhost');
  final chromeTab = (await chromeConnection.getTabs()).first;
  final connection = await chromeTab.connect();
  final page = WipPage(connection);
  await page.sendCommand("Browser.grantPermissions", params: {
    'permissions': [
      'audioCapture',
      'videoCapture',
    ]
  });

  await integrationDriver();
}
