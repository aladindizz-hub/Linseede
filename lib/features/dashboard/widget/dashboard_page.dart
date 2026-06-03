import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hiddify/core/router/bottom_sheets/bottom_sheets_notifier.dart';
import 'package:hiddify/core/theme/widget/active_profile_card.dart';
import 'package:hiddify/core/theme/widget/aurora_background.dart';
import 'package:hiddify/core/theme/widget/brand_title.dart';
import 'package:hiddify/core/theme/widget/country_flag.dart';
import 'package:hiddify/core/theme/widget/glass_icon_button.dart';
import 'package:hiddify/core/theme/widget/hero_connect_button.dart';
import 'package:hiddify/core/theme/widget/info_card.dart';
import 'package:hiddify/core/theme/widget/section_header.dart';
import 'package:hiddify/core/theme/widget/server_list_item.dart';
import 'package:hiddify/core/theme/widget/stats_card.dart';
import 'package:hiddify/features/connection/model/connection_status.dart';
import 'package:hiddify/features/connection/notifier/connection_notifier.dart';
import 'package:hiddify/features/profile/model/profile_entity.dart';
import 'package:hiddify/features/profile/notifier/active_profile_notifier.dart';
import 'package:hiddify/features/proxy/active/active_proxy_notifier.dart';
import 'package:hiddify/features/stats/notifier/stats_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({
    super.key,
    this.onOpenSettings,
    this.onAddProfile,
    this.onViewAllServers,
  });

  final VoidCallback? onOpenSettings;
  final VoidCallback? onAddProfile;
  final VoidCallback? onViewAllServers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connStatus = ref.watch(
      connectionNotifierProvider.select((v) => v.valueOrNull ?? const Disconnected()),
    );
    final activeProfile = ref.watch(activeProfileProvider).valueOrNull;
    final activeProxy = ref.watch(activeProxyNotifierProvider).valueOrNull;
    final stats = ref.watch(statsNotifierProvider).valueOrNull;
    final ipInfo = ref.watch(ipInfoNotifierProvider).valueOrNull;

    final heroState = switch (connStatus) {
      Connected() => HeroConnectState.connected,
      Connecting() => HeroConnectState.connecting,
      Disconnecting() => HeroConnectState.connecting,
      Disconnected() => HeroConnectState.disconnected,
    };
    final isRunning = connStatus is Connected;

    void toggle() {
      ref.read(connectionNotifierProvider.notifier).toggleConnection();
    }

    void openAddProfile() {
      ref.read(bottomSheetsNotifierProvider.notifier).showAddProfile();
    }

    void openProfilesList() {
      ref.read(bottomSheetsNotifierProvider.notifier).showProfilesOverview();
    }

    final connectedAt = useState<DateTime?>(null);
    useEffect(() {
      if (isRunning) {
        connectedAt.value ??= DateTime.now();
      } else {
        connectedAt.value = null;
      }
      return null;
    }, [isRunning]);

    final now = useState(DateTime.now());
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        now.value = DateTime.now();
      });
      return timer.cancel;
    }, const []);

    final pingMs = activeProxy?.urlTestDelay ?? 0;
    final isPingTimeout = pingMs > 65000;
    final pingDisplay = pingMs <= 0 ? '—' : (isPingTimeout ? '∞' : '$pingMs');

    final downSpeed = stats?.downlink.toInt() ?? 0;
    final upSpeed = stats?.uplink.toInt() ?? 0;
    final totalTraffic = (stats?.downlinkTotal.toInt() ?? 0) + (stats?.uplinkTotal.toInt() ?? 0);

    final downSpeedFmt = _formatSpeed(downSpeed);
    final upSpeedFmt = _formatSpeed(upSpeed);
    final totalFmt = _formatSize(totalTraffic);

    final ipDisplay = isRunning ? (ipInfo?.ip ?? '…') : '—';
    final countryCode = ipInfo?.countryCode ?? activeProxy?.ipinfo.countryCode ?? '';

    final profileName = activeProfile?.name ?? 'Нет профиля';
    final profileSubtitle = _profileSubtitle(activeProfile);
    final protocolDisplay = (activeProxy?.type ?? 'VLESS').toUpperCase();

    final statusText = switch (connStatus) {
      Connected() => 'Подключено',
      Connecting() => 'Подключение…',
      Disconnecting() => 'Отключение…',
      Disconnected() => activeProfile == null ? 'Добавь профиль' : 'Не подключено',
    };

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AuroraBackground(
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      GlassIconButton(
                        icon: Icons.settings_outlined,
                        onTap: onOpenSettings,
                      ),
                      const Expanded(child: Center(child: BrandTitle())),
                      GlassIconButton(
                        icon: Icons.add_rounded,
                        onTap: onAddProfile ?? openAddProfile,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SizedBox(
                    height: 340,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeroConnectButton(
                              state: heroState,
                              onTap: activeProfile == null ? openAddProfile : toggle,
                              size: 260,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              statusText,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 8,
                          top: 80,
                          width: 130,
                          child: InfoCard(
                            label: 'Current IP',
                            value: ipDisplay,
                            footer: InfoBadge(
                              text: isRunning ? 'Hidden' : 'Off',
                              icon: isRunning ? Icons.verified_user_rounded : Icons.shield_outlined,
                              accent: isRunning ? BadgeAccent.success : BadgeAccent.warning,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 80,
                          width: 130,
                          child: InfoCard(
                            label: 'Protocol',
                            value: protocolDisplay,
                            secondaryLabel: 'Xray Core',
                            footer: InfoBadge(
                              text: isRunning ? 'Running' : 'Idle',
                              accent: isRunning ? BadgeAccent.success : BadgeAccent.warning,
                              dot: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (activeProfile != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
                    child: ActiveProfileCard(
                      title: profileName,
                      subtitle: profileSubtitle ?? '',
                      pingMs: pingMs > 0 && !isPingTimeout ? pingMs : 0,
                      connectionTime: _formatDuration(now.value, connectedAt.value),
                      leading: countryCode.isNotEmpty
                          ? CountryFlag(countryCode: countryCode, size: 56)
                          : null,
                      onRefreshTap: () => ref.read(activeProxyNotifierProvider.notifier).urlTest(''),
                      onTap: openProfilesList,
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: StatsGrid(
                    cards: [
                      StatsCard(
                        label: 'Ping',
                        value: pingDisplay,
                        unit: (pingMs > 0 && !isPingTimeout) ? 'ms' : '',
                        icon: Icons.speed_rounded,
                        accent: StatAccent.success,
                      ),
                      StatsCard(
                        label: 'Download',
                        value: downSpeedFmt.$1,
                        unit: downSpeedFmt.$2,
                        icon: Icons.arrow_downward_rounded,
                        accent: StatAccent.primary,
                      ),
                      StatsCard(
                        label: 'Upload',
                        value: upSpeedFmt.$1,
                        unit: upSpeedFmt.$2,
                        icon: Icons.arrow_upward_rounded,
                        accent: StatAccent.secondary,
                      ),
                      StatsCard(
                        label: 'Traffic',
                        value: totalFmt.$1,
                        unit: totalFmt.$2,
                        icon: Icons.pie_chart_outline_rounded,
                        accent: StatAccent.primary,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: SectionHeader(
                    title: 'Профили',
                    actionLabel: 'Все',
                    onActionTap: onViewAllServers ?? openProfilesList,
                  ),
                ),
              ),
              if (activeProfile != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: ServerListItem(
                      name: activeProfile.name,
                      subtitle: profileSubtitle ?? '',
                      pingMs: pingMs > 0 && !isPingTimeout ? pingMs : 0,
                      leading: countryCode.isNotEmpty
                          ? CountryFlag(countryCode: countryCode, size: 44)
                          : null,
                      onTap: openProfilesList,
                      onFavoriteTap: () {},
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: _EmptyProfileTile(onTap: openAddProfile),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String? _profileSubtitle(ProfileEntity? p) {
    if (p == null) return null;
    return switch (p) {
      RemoteProfileEntity(:final url) => Uri.tryParse(url)?.host.isNotEmpty == true
          ? Uri.parse(url).host
          : url,
      LocalProfileEntity() => 'Локальный профиль',
    };
  }

  String _formatDuration(DateTime now, DateTime? since) {
    if (since == null) return '00:00:00';
    final d = now.difference(since);
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}

(String, String) _formatSpeed(int bytesPerSec) {
  if (bytesPerSec <= 0) return ('0', 'Kbps');
  final bits = bytesPerSec * 8.0;
  if (bits >= 1e9) return ((bits / 1e9).toStringAsFixed(2), 'Gbps');
  if (bits >= 1e6) return ((bits / 1e6).toStringAsFixed(1), 'Mbps');
  if (bits >= 1e3) return ((bits / 1e3).toStringAsFixed(1), 'Kbps');
  return (bits.toStringAsFixed(0), 'bps');
}

(String, String) _formatSize(int bytes) {
  if (bytes <= 0) return ('0', 'KB');
  const kb = 1024.0;
  const mb = kb * 1024;
  const gb = mb * 1024;
  const tb = gb * 1024;
  final b = bytes.toDouble();
  if (b >= tb) return ((b / tb).toStringAsFixed(2), 'TB');
  if (b >= gb) return ((b / gb).toStringAsFixed(2), 'GB');
  if (b >= mb) return ((b / mb).toStringAsFixed(1), 'MB');
  return ((b / kb).toStringAsFixed(0), 'KB');
}

class _EmptyProfileTile extends StatelessWidget {
  const _EmptyProfileTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
              child: const Icon(Icons.add_rounded, color: Colors.white),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добавить профиль',
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Вставь vless:// / vmess:// / trojan:// ссылку',
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.white.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}
