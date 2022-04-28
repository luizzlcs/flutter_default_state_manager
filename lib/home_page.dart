import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_bloc_pattern_page.dart';
import 'package:flutter_default_state_manager/change_notifier/imc_change_notifier_controller.dart';
import 'package:flutter_default_state_manager/change_notifier/imc_change_notifier_page.dart';
import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';
import 'package:flutter_default_state_manager/value_notifier/imc_value_notifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _goToPageValueNotifier(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _goToPageChangeNotifier(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  void _goToPageChangeBlocPattern(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _goToPage(context, ImcSetstatePage()),
              icon: const Icon(Icons.settings_remote),
              label: const Text(
                'SetState!',
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton.icon(
              onPressed: () =>
                  _goToPageValueNotifier(context, ImcValueNotifier()),
              icon: const Icon(Icons.videogame_asset_outlined),
              label: const Text(
                'ValueNotifier!',
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton.icon(
              onPressed: () =>
                  _goToPageChangeNotifier(context, ImcChangeNotifierPage()),
              icon: const Icon(Icons.change_history_rounded),
              label: const Text(
                'ChangerNotiFier!',
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton.icon(
              onPressed: () => _goToPageChangeBlocPattern(context, ImcBlocPatternPage()),
              icon: const Icon(Icons.view_stream_rounded),
              label: const Text(
                'Bloc Patern (Stream)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
