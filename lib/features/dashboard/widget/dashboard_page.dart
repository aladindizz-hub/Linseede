import 'package:flutter/material.dart';
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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, this.onOpenSettings, this.onAddProfile, this.onViewAllServers});

  final VoidCallback? onOpenSettings;
  final VoidCallback? onAddProfile;
  final VoidCallback? onViewAllServers;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _ServerMock {
  const _ServerMock(this.name, this.code, this.subtitle, this.ping, {this.hot = false});
  final String name;
  final String code;
  final String subtitle;
  final int ping;
  final bool hot;
}

class _DashboardPageState extends State<DashboardPage> {
  ConnectState _state = ConnectState.disconnected;

  static const _subtitle = 'VLESS / TCP / REALITY / JSON';

  static const List<_ServerMock> _servers = [
    _ServerMock('Germany', 'DE', _subtitle, 42, hot: true),
    _ServerMock('USA', 'US', _subtitle, 78),
    _ServerMock('Japan', 'JP', _subtitle, 112),
    _ServerMock('Singapore', 'SG', _subtitle, 134),
    _ServerMock('France', 'FR', _subtitle, 62),
    _ServerMock('Sweden', 'SE', _subtitle, 76),
    _ServerMock('Netherlands', 'NL', _subtitle, 157),
  ];

  void _toggle() {
    setState(() {
      switch (_state) {
        case ConnectState.disconnected:
          _state = ConnectState.connecting;
          Future.delayed(const Duration(milliseconds: 1400), () {
            if (!mounted) return;
            setState(() => _state = ConnectState.connected);
          });
          break;
        case ConnectState.connecting:
          _state = ConnectState.disconnected;
          break;
        case ConnectState.connected:
          _state = ConnectState.disconnected;
          break;
        case ConnectState.error:
          _state = ConnectState.disconnected;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        onTap: widget.onOpenSettings,
                      ),
                      const Expanded(
                        child: Center(child: BrandTitle()),
                      ),
                      GlassIconButton(
                        icon: Icons.add_rounded,
                        onTap: widget.onAddProfile,
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
                            state: _state,
                            onTap: _toggle,
                            size: 280,
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 80,
                          width: 130,
                          child: InfoCard(
                            label: 'Current IP',
                            value: '104.21.45.94',
                            footer: const InfoBadge(
                              text: 'Hidden',
                              icon: Icons.verified_user_rounded,
                              accent: BadgeAccent.success,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 80,
                          width: 130,
                          child: InfoCard(
                            label: 'Protocol',
                            value: 'VLESS',
                            secondaryLabel: 'Xray Core',
                            footer: const InfoBadge(
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
                    onActionTap: widget.onViewAllServers,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final s = _servers[index];
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
                    childCount: _servers.length,
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
