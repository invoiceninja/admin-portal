// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:qr_flutter/qr_flutter.dart';

// White text on this passes WCAG AA, the app's default accent does not
const Color kBetaPromoBrandColor = Color(0xFF2870B5);

class BetaPromoPalette {
  BetaPromoPalette(this.isDark)
    : surface = isDark ? const Color(0xFF1B1C1E) : Colors.white,
      text = isDark ? Colors.white : const Color(0xFF14171A),
      muted = isDark ? const Color(0xFFA9ADB3) : const Color(0xFF5B6470),
      border = isDark ? const Color(0xFF393A3C) : const Color(0xFFE3E6EA),
      accent = isDark ? const Color(0xFF7DB6F2) : kBetaPromoBrandColor,
      tint = kBetaPromoBrandColor.withValues(alpha: isDark ? .24 : .10);

  final bool isDark;
  final Color surface;
  final Color text;
  final Color muted;
  final Color border;
  final Color accent;
  final Color tint;
}

class BetaPromoPill extends StatelessWidget {
  const BetaPromoPill({Key? key, required this.label, required this.palette})
    : super(key: key);

  final String label;
  final BetaPromoPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: palette.tint,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: palette.accent,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: .8,
        ),
      ),
    );
  }
}

class BetaPromoFeatureRow extends StatelessWidget {
  const BetaPromoFeatureRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.body,
    required this.palette,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String body;
  final BetaPromoPalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: palette.tint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: palette.accent),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: palette.text,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(
                    color: palette.muted,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A tinted box for something the user should read before they leave
class BetaPromoNotice extends StatelessWidget {
  const BetaPromoNotice({
    Key? key,
    required this.icon,
    required this.text,
    required this.palette,
    this.action,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final BetaPromoPalette palette;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palette.tint,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: palette.accent),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: palette.text,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                if (action != null) action!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A value the user retypes in the new app, with a button to copy it
class BetaPromoCopyRow extends StatelessWidget {
  const BetaPromoCopyRow({
    Key? key,
    required this.label,
    required this.value,
    required this.copyTooltip,
    required this.onCopy,
    required this.palette,
  }) : super(key: key);

  final String label;
  final String value;
  final String copyTooltip;
  final VoidCallback onCopy;
  final BetaPromoPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 4, 8),
      decoration: BoxDecoration(
        border: Border.all(color: palette.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: palette.muted, fontSize: 12),
                ),
                SizedBox(height: 2),
                // Addresses read left to right in every locale
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SelectableText(
                    value,
                    maxLines: 1,
                    style: TextStyle(
                      color: palette.text,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: copyTooltip,
            icon: Icon(Icons.copy, size: 18, color: palette.muted),
            onPressed: onCopy,
          ),
        ],
      ),
    );
  }
}

/// A terminal command, with a button to copy it
class BetaPromoCommandBox extends StatelessWidget {
  const BetaPromoCommandBox({
    Key? key,
    required this.command,
    required this.copyTooltip,
    required this.onCopy,
  }) : super(key: key);

  final String command;
  final String copyTooltip;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 2, 6),
      decoration: BoxDecoration(
        color: const Color(0xFF10151C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Expanded(
              child: SelectableText(
                command,
                style: const TextStyle(
                  color: Color(0xFFE6EDF3),
                  fontSize: 12.5,
                  height: 1.4,
                  fontFamily: 'monospace',
                  fontFamilyFallback: ['Menlo', 'Consolas', 'DejaVu Sans Mono'],
                ),
              ),
            ),
            IconButton(
              tooltip: copyTooltip,
              icon: Icon(Icons.copy, size: 18, color: Colors.white70),
              onPressed: onCopy,
            ),
          ],
        ),
      ),
    );
  }
}

/// A code to scan so someone at a desk can install the beta on their phone
class BetaPromoQrCard extends StatelessWidget {
  const BetaPromoQrCard({
    Key? key,
    required this.url,
    required this.caption,
    this.options = const [],
    this.selectedOption = 0,
    this.onOptionSelected,
  }) : super(key: key);

  final String url;
  final String caption;
  final List<String> options;
  final int selectedOption;
  final ValueChanged<int>? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: url,
            version: QrVersions.auto,
            size: 112,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 8),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF14171A),
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
          if (options.length > 1) ...[
            SizedBox(height: 6),
            // Shrinks rather than overflowing the card at the larger text sizes
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int index = 0; index < options.length; index++)
                    InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => onOptionSelected?.call(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: index == selectedOption
                              ? kBetaPromoBrandColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          options[index],
                          style: TextStyle(
                            color: index == selectedOption
                                ? Colors.white
                                : const Color(0xFF5B6470),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The screenshots the hero shows, so they can be decoded before it opens
List<String> betaPromoHeroAssets(bool isDark) {
  final theme = isDark ? 'dark' : 'light';

  return [
    'assets/images/beta/desktop_$theme.png',
    'assets/images/beta/phone_$theme.png',
  ];
}

/// Screenshots of the new app on the brand gradient
class BetaPromoHero extends StatelessWidget {
  const BetaPromoHero({
    Key? key,
    required this.isDark,
    required this.isWide,
    required this.closeButton,
    this.overlay,
  }) : super(key: key);

  final bool isDark;
  final bool isWide;
  final Widget closeButton;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    final assets = betaPromoHeroAssets(isDark);
    final desktop = assets.first;
    final phone = assets.last;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3C8FDD), Color(0xFF1F5FA8), Color(0xFF0D2C55)],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          PositionedDirectional(
            top: -110,
            end: -90,
            child: Container(
              width: 340,
              height: 340,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x38FFFFFF), Color(0x00FFFFFF)],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: isWide ? 44 : 20,
            top: isWide ? 84 : 24,
            child: _WindowFrame(
              asset: desktop,
              width: isWide ? 720 : 400,
              isDark: isDark,
            ),
          ),
          if (isWide)
            PositionedDirectional(
              start: 20,
              bottom: -44,
              child: _PhoneFrame(asset: phone, width: 164),
            )
          else
            PositionedDirectional(
              end: 58,
              top: 36,
              child: _PhoneFrame(asset: phone, width: 92),
            ),
          if (overlay != null)
            PositionedDirectional(end: 20, bottom: 20, child: overlay!),
          PositionedDirectional(end: 10, top: 10, child: closeButton),
        ],
      ),
    );
  }
}

const List<BoxShadow> _frameShadow = [
  BoxShadow(color: Color(0x59000000), blurRadius: 40, offset: Offset(0, 18)),
];

class _WindowFrame extends StatelessWidget {
  const _WindowFrame({
    required this.asset,
    required this.width,
    required this.isDark,
  });

  final String asset;
  final double width;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final barHeight = width * .036;

    return Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF26282B) : const Color(0xFFE9ECF0),
        borderRadius: BorderRadius.circular(width * .016),
        boxShadow: _frameShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: barHeight,
            child: Row(
              children: [
                SizedBox(width: barHeight * .5),
                for (int index = 0; index < 3; index++)
                  Container(
                    width: barHeight * .34,
                    height: barHeight * .34,
                    margin: EdgeInsets.only(right: barHeight * .24),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF55585D)
                          : const Color(0xFFC3C8CF),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
          Image.asset(
            asset,
            width: width,
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.medium,
            excludeFromSemantics: true,
          ),
        ],
      ),
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.asset, required this.width});

  final String asset;
  final double width;

  @override
  Widget build(BuildContext context) {
    final bezel = width * .032;

    return Container(
      width: width,
      padding: EdgeInsets.all(bezel),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1013),
        borderRadius: BorderRadius.circular(width * .15),
        boxShadow: _frameShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * .12),
        child: Image.asset(
          asset,
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.medium,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
