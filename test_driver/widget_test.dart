import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//import 'package:invoiceninja_flutter/ui/auth/login_view.dart';

void main() {
  group('scrolling performance test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connects to the app
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        // Closes the connection
        driver.close();
      }
    });

    test('measure', () async {
      // Record the performance timeline of things that happen inside the closure
      final Timeline timeline = await driver.traceAction(() async {

        //SerializableFinder email = find.byValueKey('email');

        final SerializableFinder email = find.byTooltip('Email');
        expect(email, isNotNull);
        await driver.waitFor(email);
        await driver.enterText('test');

        /*
        // Find the scrollable user list
        SerializableFinder userList = find.byValueKey('user-list');

        // Scroll down 5 times
        for (int i = 0; i < 5; i++) {
          // Scroll 300 pixels down, for 300 millis
          await driver.scroll(
              userList, 0.0, -300.0, new Duration(milliseconds: 300));

          // Emulate a user's finger taking its time to go back to the original
          // position before the next scroll
          await new Future<Null>.delayed(new Duration(milliseconds: 500));
        }

        // Scroll up 5 times
        for (int i = 0; i < 5; i++) {
          await driver.scroll(
              userList, 0.0, 300.0, new Duration(milliseconds: 300));
          await new Future<Null>.delayed(new Duration(milliseconds: 500));
        }
        */
      });

      // The `timeline` object contains all the performance data recorded during
      // the scrolling session. It can be digested into a handful of useful
      // aggregate numbers, such as "average frame build time".
      final TimelineSummary summary = new TimelineSummary.summarize(timeline);

      // The following line saves the timeline summary to a JSON file.
      summary.writeSummaryToFile('scrolling_performance', pretty: true);

      // The following line saves the raw timeline data as JSON.
      summary.writeTimelineToFile('scrolling_performance', pretty: true);
    });
  });
}