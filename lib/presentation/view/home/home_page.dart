import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp/presentation/common/localization/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: (index) {
        widget.navigationShell.goBranch(
          index,
          initialLocation: index == widget.navigationShell.currentIndex,
        );
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.play_circle_outline),
          label: AppLocalizations.of(context)!.movie_title,
        ),
        const NavigationDestination(
          icon: Icon(Icons.search_outlined),
          label: 'Buscador',
        ),
        NavigationDestination(
          icon: const Icon(Icons.info_outlined),
          label: AppLocalizations.of(context)!.about_title,
        ),
      ],
    );
  }
}
