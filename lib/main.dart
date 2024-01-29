import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  final configuration = DatadogConfiguration(
    clientToken: 'pub3a63fb84a35c7fa2269d949b8ab4c706',
    env: 'prod',
    site: DatadogSite.ap1,
    nativeCrashReportEnabled: true,
    loggingConfiguration: DatadogLoggingConfiguration(),
    rumConfiguration: DatadogRumConfiguration(
      applicationId: '2505fdfe-fdc1-4ec3-b874-c1093a456db1',
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DatadogSdk.runApp(configuration, TrackingConsent.granted, () async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The wall',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      navigatorObservers: [
        DatadogNavigationObserver(datadogSdk: DatadogSdk.instance),
      ],
    );
  }
}
