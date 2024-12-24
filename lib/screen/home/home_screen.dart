import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ga913_flutter/gen/l10n/l10n.dart';
import 'package:ga913_flutter/screen/home/home_event_handler.dart';
import 'package:ga913_flutter/screen/home/home_ui_model_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context);
    final uiModel = ref.watch(homeUiModelProvider);
    final eventHandler = ref.read(homeEventHandlerProvider);
    useEffect(() {
      eventHandler.onCreate();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l.homeTitle),
      ),
      body: uiModel.progress // ここで条件分岐
          ? const Center(
              // プログレスインジケーターを中央に表示
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SwitchListTile(
                  title: Text(l.homeFavoritesOnly),
                  value: uiModel.favoritesOnly,
                  onChanged: (value) {
                    eventHandler.onFavoritesOnlyChanged(value);
                  },
                ),
                const Divider(
                  height: 1,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom,
                    ),
                    itemCount: uiModel.landmarks.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ), // 区切り線を追加
                    itemBuilder: (context, index) {
                      final landmark = uiModel.landmarks[index];
                      return Container(
                        margin: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset(landmark.imageUrl,
                                width: 64, height: 64, fit: BoxFit.cover),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                landmark.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            if (landmark.isFavorite)
                              Icon(Icons.star,
                                  color: Theme.of(context).colorScheme.primary),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
