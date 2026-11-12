import 'package:app/settings/views/tabs/general.dart';
import 'package:app/user/models/read_item_handling.dart';
import 'package:app/utils/views/components/error_dialog.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:snaptest/snaptest.dart';

import '../helper_widget/test_app_setup_widget.dart';
import '../test_utils.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() async {
    await setupTests(loggedIn: true);
    nock.cleanAll();
  });

  testWidgets('Test general preferences happy path', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final getUser = nock(validServerUrl).get('/api/users')..reply(200, loadFixture('user.json'));
    final articlePreference = find.byKey(Key('article-preferences'));

    await tester.pumpWidget(TestSetup(child: GeneralSettingsTab()));
    await tester.pumpAndSettle();
    await snap(name: 'general_settings', matchToGolden: true);
    expect(getUser.isDone, true);
    expect(articlePreference, findsOneWidget);

    // from now on we acknowledge all the GET user calls
    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    TextField articlePreferenceWidget = tester.widget(articlePreference);
    expect(articlePreferenceWidget.controller!.text, 'ai preference');

    var userUpdate = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(userUpdate.isDone, true);

    // testing the slider
    final slider = find.byType(Slider);
    expect(slider, findsOneWidget);
    Slider sliderWidget = tester.widget(slider);
    expect(sliderWidget.value, 5);

    userUpdate = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    await tester.slideToValue(slider, 75);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));
    await snap(name: 'post_drag');
    expect(userUpdate.isDone, true);
    expect((tester.widget(slider) as Slider).value, 75);

    // testing the read item handling
    userUpdate = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    final readItemHandling = find.byKey(Key('read-item-handling'));
    expect(readItemHandling, findsOneWidget);
    expect(
      (tester.widget(readItemHandling) as DropdownMenu<ReadItemHandling>).initialSelection,
      ReadItemHandling.unreadFirstThenDim,
    );

    await tester.tap(readItemHandling);
    await tester.pumpAndSettle();

    await snap(name: 'read_item_handling_open');
    await tester.tap(find.text('Display normally').last);
    await tester.pumpAndSettle();
    expect(userUpdate.isDone, true);
    expect((tester.widget(readItemHandling) as DropdownMenu<ReadItemHandling>).initialSelection, ReadItemHandling.none);
  });

  testWidgets('Test get user backend communication errors', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final getUser = nock(validServerUrl).get('/api/users')..reply(500, '');

    await tester.pumpWidget(TestSetup(child: GeneralSettingsTab()));
    await tester.pumpAndSettle();

    expect(getUser.isDone, true);
    expect(find.byType(ErrorDialog), findsOneWidget);

    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);
  });

  testWidgets('Test update user backend communication errors', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: GeneralSettingsTab()));
    await tester.pumpAndSettle();

    await snap(name: 'before update fail');

    var userUpdate = nock(validServerUrl).post('/api/users', (body) => true)..reply(500, '');

    expect(find.text('Update'), findsOneWidget);
    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(userUpdate.isDone, true);

    expect(find.byType(ErrorDialog), findsOneWidget);
  });
}
