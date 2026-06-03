import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class _ServerMock {
  const _ServerMock(this.name, this.code, this.subtitle, this.ping, {this.hot = false});
  final String name;
  final String code;
  final String subtitle;
  final int ping;
  final bool hot;
}

const String _kSubtitle = 'VLESS / TCP / REALITY / JSON';

const List _kServers = [
  _ServerMock('Germany', 'DE', _kSubtitle, 42, hot: true),
  _ServerMock('USA', 'US', _kSubtitle, 78),
  _ServerMock('Japan', 'JP', _kSubtitle, 112),
  _ServerMock('Singapore', 'SG', _kSubtitle, 134),
  _ServerMock('France', 'FR', _kSubtitle, 62),
  _ServerMock('Sweden', 'SE', _kSubtitle, 76),
  _ServerMock('Netherlands', 'NL', _kSubtitle, 157),
];

class DashboardPage extends HookWidget {
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
  Widget build(BuildContext context) {
    final state = useState(ConnectState.disconnected);

    void toggle() {
      switch (state.value) {
        case ConnectState.disconnected:
          state.value = ConnectState.connecting;
          Future.delayed(const Duration(milliseconds: 1400), () {
            if (!context.mounted) return;
            state.value = ConnectState.connected;
          });
          break;
        case ConnectState.connecting:
        case ConnectState.connected:
        case ConnectState.error:
          state.value = ConnectState.disconnected;
          break;
      }
    }

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
                      const Expanded(
                        child: Center(child: BrandTitle()),
                      ),
                      GlassIconButton(
                        icon: Icons.add_rounded,
                        onTap: onAddProfile,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SizedBox(
                    height: 320,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: HeroConnectButton(
                            state: state.value,
                            onTap: toggle,
                            size: 280,
                          ),
                        ),
                        const Positioned(
                          left: 8,
                          top: 80,
                          width: 130,
                          child: InfoCard(
                            label: 'Current IP',
                            value: '104.21.45.94',
                            footer: InfoBadge(
                              text: 'Hidden',
                              icon: Icons.verified_user_rounded,
                              accent: BadgeAccent.success,
                            ),
                          ),
                        ),
                        const Positioned(
                          right: 8,
                          top: 80,
                          width: 130,
                          child: InfoCard(
                            label: 'Protocol',
                            value: 'VLESS',
                            secondaryLabel: 'Xray Core',
                            footer: InfoBadge(
                              text: 'Running',
                              accent: BadgeAccent.success,
                              dot: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
                  child: ActiveProfileCard(
                    title: 'Germany - Frankfurt',
                    subtitle: 'lin-01.linseedevpn.com',
                    pingMs: 42,
                    connectionTime: '00:12:45',
                    leading: const CountryFlag(countryCode: 'DE', size: 56),
                    onRefreshTap: () {},
                    onTap: () {},
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: StatsGrid(
                    cards: [
                      StatsCard(
                        label: 'Ping',
                        value: '42',
                        unit: 'ms',
                        icon: Icons.speed_rounded,
                        accent: StatAccent.success,
                      ),
                      StatsCard(
                        label: 'Download',
                        value: '147.3',
                        unit: 'Mbps',
                        icon: Icons.arrow_downward_rounded,
                        accent: StatAccent.primary,
                      ),
                      StatsCard(
                        label: 'Upload',
                        value: '38.6',
                        unit: 'Mbps',
                        icon: Icons.arrow_upward_rounded,
                        accent: StatAccent.secondary,
                      ),
                      StatsCard(
                        label: 'Traffic',
                        value: '4.82',
                        unit: 'GB',
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
                    title: 'Servers',
                    actionLabel: 'View All',
                    onActionTap: onViewAllServers,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final s = _kServers[index] as _ServerMock;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ServerListItem(
                          name: s.name,
                          subtitle: s.subtitle,
                          pingMs: s.ping,
                          leading: CountryFlag(countryCode: s.code, size: 44),
                          trailingBadge: s.hot
                              ? const Text('🔥', style: TextStyle(fontSize: 14))
                              : null,
                          onTap: () {},
                          onFavoriteTap: () {},
                        ),
                      );
                    },
                    childCount: _kServers.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
