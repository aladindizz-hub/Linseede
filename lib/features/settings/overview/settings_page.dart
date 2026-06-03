import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hiddify/core/localization/translations.dart';
import 'package:hiddify/core/router/dialog/dialog_notifier.dart';
import 'package:hiddify/core/router/go_router/helper/active_breakpoint_notifier.dart';
import 'package:hiddify/core/theme/color_theme_preferences.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/widget/aurora_background.dart';
import 'package:hiddify/core/theme/widget/glass_card.dart';
import 'package:hiddify/core/theme/widget/theme_picker_sheet.dart';
import 'package:hiddify/features/profile/notifier/active_profile_notifier.dart';
import 'package:hiddify/features/settings/notifier/config_option/config_option_notifier.dart';
import 'package:hiddify/features/settings/notifier/reset_tunnel/reset_tunnel_notifier.dart';
import 'package:hiddify/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ConfigOptionSection {
  warp,
  fragment;

  static final _warpKey = GlobalKey(debugLabel: "warp-section-key");
  static final _fragmentKey = GlobalKey(debugLabel: "fragment-section-key");

  GlobalKey get key => switch (this) {
        ConfigOptionSection.warp => _warpKey,
        ConfigOptionSection.fragment => _fragmentKey,
      };
}

class SettingsPage extends HookConsumerWidget {
  SettingsPage({super.key, String? section})
      : section = section != null ? ConfigOptionSection.values.byName(section) : null;

  final ConfigOptionSection? section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsProvider).requireValue;
    final currentTheme = ref.watch(colorThemePreferencesProvider);
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;
    final hasProfile = ref.watch(hasAnyProfileProvider).value ?? false;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          t.pages.settings.title,
          style: TextStyle(
            color: surface.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        iconTheme: IconThemeData(color: surface.textPrimary),
        actions: [
          MenuAnchor(
            menuChildren: [
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () async => await ref
                        .read(dialogNotifierProvider.notifier)
                        .showConfirmation(
                          title: t.common.msg.import.confirm,
                          message: t.dialogs.confirmation.settings.import.msg,
                        )
                        .then((shouldImport) async {
                      if (shouldImport) {
                        await ref.read(configOptionNotifierProvider.notifier).importFromClipboard();
                      }
                    }),
                    child: Text(t.pages.settings.options.import.clipboard),
                  ),
                  MenuItemButton(
                    onPressed: () async => await ref
                        .read(dialogNotifierProvider.notifier)
                        .showConfirmation(
                          title: t.common.msg.import.confirm,
                          message: t.dialogs.confirmation.settings.import.msg,
                        )
                        .then((shouldImport) async {
                      if (shouldImport) {
                        await ref.read(configOptionNotifierProvider.notifier).importFromJsonFile();
                      }
                    }),
                    child: Text(t.pages.settings.options.import.file),
                  ),
                ],
                child: Text(t.common.import),
              ),
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () async => await ref.read(configOptionNotifierProvider.notifier).exportJsonClipboard(),
                    child: Text(t.pages.settings.options.export.anonymousToClipboard),
                  ),
                  MenuItemButton(
                    onPressed: () async => await ref.read(configOptionNotifierProvider.notifier).exportJsonFile(),
                    child: Text(t.pages.settings.options.export.anonymousToFile),
                  ),
                  const PopupMenuDivider(),
                  MenuItemButton(
                    onPressed: () async => await ref
                        .read(configOptionNotifierProvider.notifier)
                        .exportJsonClipboard(excludePrivate: false),
                    child: Text(t.pages.settings.options.export.allToClipboard),
                  ),
                  MenuItemButton(
                    onPressed: () async =>
                        await ref.read(configOptionNotifierProvider.notifier).exportJsonFile(excludePrivate: false),
                    child: Text(t.pages.settings.options.export.allToFile),
                  ),
                ],
                child: Text(t.common.export),
              ),
              const PopupMenuDivider(),
              MenuItemButton(
                child: Text(t.pages.settings.options.reset),
                onPressed: () async => await ref.read(configOptionNotifierProvider.notifier).resetOption(),
              ),
            ],
            builder: (context, controller, child) => IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: Icon(Icons.more_vert_rounded, color: surface.textPrimary),
            ),
          ),
          const Gap(8),
        ],
      ),
      body: AuroraBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          children: [
            _ThemeHeroTile(
              displayName: currentTheme.displayName,
              tagline: currentTheme.tagline,
              emoji: currentTheme.emoji,
              accent: accent,
              surface: surface,
              onTap: () => ThemePickerSheet.show(context),
            ),
            const Gap(20),
            _GroupTitle(text: 'Сеть', surface: surface),
            const Gap(8),
            _SettingsGroup(
              children: [
                _SettingsRow(
                  icon: Icons.layers_rounded,
                  iconColor: accent.primary,
                  title: t.pages.settings.general.title,
                  surface: surface,
                  onTap: () => context.go(context.namedLocation('general')),
                ),
                if (hasProfile)
                  _SettingsRow(
                    icon: Icons.webhook_rounded,
                    iconColor: accent.secondary,
                    title: t.pages.settings.chain.title,
                    subtitle: t.pages.settings.chain.subtitle,
                    surface: surface,
                    onTap: () => context.go(context.namedLocation('chainOptions')),
                  ),
                _SettingsRow(
                  icon: Icons.route_rounded,
                  iconColor: accent.tertiary,
                  title: t.pages.settings.routing.title,
                  surface: surface,
                  onTap: () => context.go(context.namedLocation('routingOptions')),
                ),
                _SettingsRow(
                  icon: Icons.dns_rounded,
                  iconColor: accent.success,
                  title: t.pages.settings.dns.title,
                  surface: surface,
                  onTap: () => context.go(context.namedLocation('dnsOptions')),
                ),
                _SettingsRow(
                  icon: Icons.input_rounded,
                  iconColor: accent.warning,
                  title: t.pages.settings.inbound.title,
                  surface: surface,
                  onTap: () => context.go(context.namedLocation('inboundOptions')),
                ),
                _SettingsRow(
                  icon: Icons.content_cut_rounded,
                  iconColor: accent.danger,
                  title: t.pages.settings.tlsTricks.title,
                  surface: surface,
                  isLast: !PlatformUtils.isIOS,
                  onTap: () => context.go(context.namedLocation('tlsTricks')),
                ),
                if (PlatformUtils.isIOS)
                  _SettingsRow(
                    icon: Icons.autorenew_rounded,
                    iconColor: accent.primary,
                    title: t.pages.settings.resetTunnel,
                    surface: surface,
                    isLast: true,
                    onTap: () async {
                      await ref.read(resetTunnelNotifierProvider.notifier).run();
                    },
                  ),
              ],
            ),
            if (Breakpoint(context).isMobile()) ...[
              const Gap(20),
              _GroupTitle(text: 'Информация', surface: surface),
              const Gap(8),
              _SettingsGroup(
                children: [
                  _SettingsRow(
                    icon: Icons.description_rounded,
                    iconColor: accent.secondary,
                    title: t.pages.logs.title,
                    surface: surface,
                    onTap: () => context.go(context.namedLocation('logs')),
                  ),
                  _SettingsRow(
                    icon: Icons.info_rounded,
                    iconColor: accent.tertiary,
                    title: t.pages.about.title,
                    surface: surface,
                    isLast: true,
                    onTap: () => context.go(context.namedLocation('about')),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ThemeHeroTile extends StatelessWidget {
  const _ThemeHeroTile({
    required this.displayName,
    required this.tagline,
    required this.emoji,
    required this.accent,
    required this.surface,
    required this.onTap,
  });

  final String displayName;
  final String tagline;
  final String emoji;
  final AccentTheme accent;
  final SurfaceTheme surface;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(18),
      radius: RadiusTokens.large,
      intensity: GlassIntensity.strong,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent.primary.withOpacity(0.18),
          accent.secondary.withOpacity(0.12),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [accent.primary, accent.secondary],
              ),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 26)),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Тема оформления',
                  style: TextStyle(
                    color: surface.textTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const Gap(2),
                Text(
                  displayName,
                  style: TextStyle(
                    color: surface.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(2),
                Text(
                  tagline,
                  style: TextStyle(
                    color: surface.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: surface.textTertiary),
        ],
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle({required this.text, required this.surface});
  final String text;
  final SurfaceTheme surface;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: surface.textTertiary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      radius: RadiusTokens.large,
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.surface,
    this.subtitle,
    this.isLast = false,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final SurfaceTheme surface;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: iconColor.withOpacity(0.25), width: 1),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: surface.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const Gap(2),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: surface.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: surface.textTertiary, size: 20),
                ],
              ),
            ),
            if (!isLast)
              Padding(
                padding: const EdgeInsets.only(left: 66),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: surface.textTertiary.withOpacity(0.08),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SettingsSection extends HookConsumerWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    required this.namedLocation,
  });

  final String title;
  final Widget? subtitle;
  final IconData icon;
  final String namedLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle,
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => context.go(namedLocation),
    );
  }
}
