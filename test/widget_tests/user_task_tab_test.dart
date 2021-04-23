import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// Local files imports.
import 'package:talawa/controllers/auth_controller.dart';
import 'package:talawa/controllers/org_controller.dart';
import 'package:talawa/services/preferences.dart';
import 'package:talawa/utils/gql_client.dart';
import 'package:talawa/views/pages/members/user_taskstab.dart';

Widget userTasksPage() => MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphQLConfiguration>(
          create: (_) => GraphQLConfiguration(),
        ),
        ChangeNotifierProvider<OrgController>(
          create: (_) => OrgController(),
        ),
        ChangeNotifierProvider<AuthController>(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProvider<Preferences>(
          create: (_) => Preferences(),
        ),
      ],
      child: MaterialApp(
        home: UserTasks(
          member: const {
            '_id': "6076f6d2cd2288002704654b",
          },
        ),
      ),
    );

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized()
          as TestWidgetsFlutterBinding;

  group("users task tab page tests", () {
    testWidgets("Testing if users task tab shows up", (tester) async {
      await tester.pumpWidget(userTasksPage());

      await tester.pumpAndSettle();
      //verify if [users task tab ] page appears
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets("Testing overflow of users task tab  page in a mobile screen",
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(440, 800);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(userTasksPage());
      await tester.pumpAndSettle();

      //verify if [users task tab] page appears
      expect(find.byType(Container), findsOneWidget);
    });
    testWidgets("Testing overflow of users task tab in a tablet screen",
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(1024, 768);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(userTasksPage());
      await tester.pumpAndSettle();

      //verify if [ users task tab ] page appears

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
