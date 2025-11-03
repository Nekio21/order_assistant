import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:order_assistant/core/ui/app_button.dart';
import 'package:order_assistant/core/ui/app_spacing.dart';
import 'package:order_assistant/core/ui/app_text_style.dart';
import 'package:order_assistant/orders/logic/order_bloc.dart';

import '../../core/ui/app_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (ctx) => OrderBloc(), child: _OrdersWidget());
  }
}

class _OrdersWidget extends StatefulWidget {
  const _OrdersWidget();

  @override
  State<_OrdersWidget> createState() => _OrdersState();
}

class _OrdersState extends State<_OrdersWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: AppSpacing.small,
      children: [
        TextField(
          controller: controller,
          focusNode: FocusNode(),
          maxLines: 6,
          style: AppTextStyle.captionSmall.apply(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: 'orders.hint_text'.tr(),
            hintStyle: AppTextStyle.captionSmall.apply(
              color: AppTheme.textSecondary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.accent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.accent, width: 2),
            ),
          ),
        ),
        AppButton(
          isActive: true,
          icon: Symbols.shadow_add,
          text: "orders.generate".tr(),
          onClick: () {
            context.read<OrderBloc>().add(SendEmail(controller.text));
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
