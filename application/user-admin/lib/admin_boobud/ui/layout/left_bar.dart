import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare/admin_boobud/widgets/custom_pop_menu.dart';
import 'package:medicare/helpers/services/url_service.dart';
import 'package:medicare/helpers/theme/theme_customizer.dart';
import 'package:medicare/helpers/utils/my_shadow.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/widgets/my_card.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_router.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/images.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({super.key, this.isCondensed = false});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return MyCard(
      paddingAll: 0,
      borderRadiusAll: 12,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 1),
      child: AnimatedContainer(
        width: isCondensed ? 70 : 270,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(color: leftBarTheme.background, borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: MySpacing.all(12),
              child: InkWell(
                onTap: () => Get.toNamed('/dashboard'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isCondensed) Image.asset(Images.logoSmall, height: 36, fit: BoxFit.cover),
                    if (!widget.isCondensed)
                      Flexible(
                        fit: FlexFit.loose,
                        child: MyText.displayMedium(
                          "BooBud",
                          style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w800, color: contentTheme.primary, letterSpacing: .5),
                          maxLines: 1,
                        ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
                child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySpacing.height(12),
                    NavigationItem(iconData: LucideIcons.layout_dashboard, title: "Dashboard", isCondensed: isCondensed, route: '/dashboard'),
                    NavigationItem(iconData: LucideIcons.user_plus, title: "User Management", isCondensed: isCondensed, route: '/admin/user/list'),
                    // MenuWidget(
                    //   iconData: LucideIcons.user_plus,
                    //   isCondensed: isCondensed,
                    //   title: "User Management",
                    //   route: "/admin/patient/list",
                    //   children: [
                    //     MenuItem(title: "List", isCondensed: isCondensed, route: '/admin/patient/list', iconData: LucideIcons.scroll_text),
                    //     MenuItem(title: "Detail", isCondensed: isCondensed, route: '/admin/patient/detail', iconData: LucideIcons.list_ordered),
                    //     MenuItem(title: "Add", isCondensed: isCondensed, route: '/admin/patient/add', iconData: LucideIcons.list_ordered),
                    //     MenuItem(title: "Edit", isCondensed: isCondensed, route: '/admin/patient/edit', iconData: LucideIcons.list_ordered),
                    //   ],
                    // ),
                    NavigationItem(iconData: Icons.payments_outlined, title: "Subscription Management", isCondensed: isCondensed, route: '/admin/subscription/list'),

                    /*MenuWidget(
                      iconData: LucideIcons.briefcase_medical,
                      isCondensed: isCondensed,
                      title: "Subscription Management",
                      children: [
                        MenuItem(title: "Subscription", isCondensed: isCondensed, route: '/admin/doctor/list'),
                        MenuItem(title: "Detail", isCondensed: isCondensed, route: '/admin/doctor/detail'),
                        MenuItem(title: "Add", isCondensed: isCondensed, route: '/admin/doctor/add'),
                        MenuItem(title: "Edit", isCondensed: isCondensed, route: '/admin/doctor/edit'),
                      ],
                    ),*/

                    MenuWidget(
                      iconData: LucideIcons.notepad_text,
                      isCondensed: isCondensed,
                      title: "Reports & Analytics",
                      children: [
                        MenuItem(title: "User", isCondensed: isCondensed, route: '/admin/reports_analytics/user_report'),
                        MenuItem(title: "Subscription", isCondensed: isCondensed, route: '/admin/reports_analytics/subscription_report'),
                        MenuItem(title: "Match & Chat Insights ", isCondensed: isCondensed, route: '/admin/reports_analytics/match_and_chats_report'),
                        MenuItem(title: "Book Reports", isCondensed: isCondensed, route: '/admin/reports_analytics/book_report'),
                      ],
                    ),
                    NavigationItem(iconData: Icons.notifications_active_outlined, title: "Alerts & Notification", isCondensed: isCondensed, route: '/admin/notification'),
                    // NavigationItem(iconData: Icons.note_add_sharp, title: "Sign Up Form", isCondensed: isCondensed, route: '/admin/SignUpForm'),
                    NavigationItem(iconData: Icons.note_add_sharp, title: "Sign Up Form List", isCondensed: isCondensed, route: '/admin/SignUpFormList'),

                    // NavigationItem(iconData: LucideIcons.wallet, title: "Wallet", isCondensed: isCondensed, route: '/admin/reports_analytics/subscription'),
                    // NavigationItem(iconData: LucideIcons.settings, title: "Setting", isCondensed: isCondensed, route: '/admin/setting'),
                    MySpacing.height(20),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(label.toUpperCase(),
                color: leftBarTheme.labelColor, muted: true, maxLines: 1, overflow: TextOverflow.clip, fontWeight: 700),
          );
  }
}

class LabelWidget extends StatefulWidget {
  final bool isCondensed;
  final String label;

  const LabelWidget({super.key, required this.isCondensed, required this.label});

  @override
  State<LabelWidget> createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isCondensed) {
      return SizedBox();
    }
    return Container(margin: MySpacing.fromLTRB(16, 0, 16, 8), child: MyText.bodySmall(widget.label, muted: true, fontWeight: 600));
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;
  final String? route;

  const MenuWidget({super.key, required this.iconData, required this.title, this.isCondensed = false, this.active = false, this.children = const [],this.route});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (value) => popupShowing = value,
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) => setState(() {
            isHover = true;
          }),
          onExit: (event) => setState(() {
            isHover = false;
          }),
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
            padding: MySpacing.all(8),
            borderRadiusAll: 12,
            child: Center(
              child: Icon(widget.iconData, color: (isHover || isActive) ? leftBarTheme.activeItemColor : leftBarTheme.onBackground, size: 20),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer(
          paddingAll: 8,
          borderRadiusAll: 12,
          width: 200,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: widget.children),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) => setState(() {
          isHover = true;
        }),
        onExit: (event) => setState(() {
          isHover = false;
        }),
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (value) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(value);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(LucideIcons.chevron_down, size: 18, color: leftBarTheme.onBackground),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(widget.iconData, size: 20, color: isHover || isActive ? leftBarTheme.activeItemColor : leftBarTheme.onBackground),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          color: isHover || isActive ? leftBarTheme.activeItemColor : leftBarTheme.onBackground),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) => setState(() {
          isHover = true;
        }),
        onExit: (event) => setState(() {
          isHover = false;
        }),
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          borderRadiusAll: 12,
          child: MyText.bodySmall("${widget.isCondensed ? "-" : "- "}  ${widget.title}",
              overflow: TextOverflow.clip,
              maxLines: 1,
              textAlign: TextAlign.left,
              fontSize: 12.5,
              color: isActive || isHover ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
              fontWeight: isActive || isHover ? 600 : 500),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem({super.key, this.iconData, required this.title, this.isCondensed = false, this.route});

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
          // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) => setState(() {
          isHover = true;
        }),
        onExit: (event) => setState(() {
          isHover = false;
        }),
        child: MyContainer(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
          paddingAll: 8,
          borderRadiusAll: 12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(widget.iconData, color: (isHover || isActive) ? leftBarTheme.activeItemColor : leftBarTheme.onBackground, size: 20),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
