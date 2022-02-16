import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants/colors.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.label,
    required this.isActive,
    required this.callback,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String label;
  final String icon;
  final bool isActive;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        height: 60,
        child: Column(
          children: [
            Container(
              width: 52,
              height: 2,
              color: isActive ? AppColors.primary : null,
            ),
            const Expanded(child: SizedBox()),
            SvgPicture.asset(
              icon,
              color: isActive ? AppColors.primary : null,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : AppColors.grey1,
                fontSize: 12,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
