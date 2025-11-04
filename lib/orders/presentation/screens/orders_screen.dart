import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:order_assistant/core/errors/error_mapper.dart';
import 'package:order_assistant/core/ui/theme/app_text_style.dart';
import 'package:order_assistant/core/ui/theme/app_theme.dart';
import 'package:order_assistant/core/ui/widgets/app_button.dart';
import 'package:order_assistant/core/ui/widgets/app_loading.dart';
import 'package:order_assistant/core/ui/theme/app_spacing.dart';
import 'package:order_assistant/core/ui/widgets/blob.dart';
import 'package:order_assistant/orders/presentation/bloc/order_bloc.dart';
import 'package:order_assistant/orders/presentation/models/order_display.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (ctx) => OrderBloc(), child: const _OrdersWidget());
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
    final state = context.watch<OrderBloc>().state;

    return BlocListener<OrderBloc, OrderState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(getErrorMessage(state.error!))));
        }
      },
      child: AppLoading(
      isLoading: state.isLoading,
      child: Column(
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
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.accent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.accent, width: 2),
              ),
            ),
          ),
          AppButton(
            isActive: true,
            icon: Symbols.shadow_add,
            text: 'orders.generate'.tr(),
            onClick: () {
              context.read<OrderBloc>().add(SendEmail(controller.text));
            },
          ),
          SingleChildScrollView(
            child: Column(
              children: state.orders?.map((o) => showOrder(o)).toList() ?? [],
            ),
          ),
        ],
      ),
    ));
  }

  Widget showOrder(OrderDisplay order) {
    final errorWidget = const Icon(Symbols.shopping_bag);

    return Row(
      spacing: AppSpacing.small,
      children: [
        CachedNetworkImage(
          imageUrl: order.imageUrl ?? '',
          width: 40,
          height: 40,
          placeholder: (context, url) =>
              const CircularProgressIndicator(color: AppTheme.primary),
          errorWidget: (context, url, error) => errorWidget,
        ),
        Text(order.name, style: AppTextStyle.captionBold.copyWith(color: AppTheme.textPrimary)),
        const Spacer(),
        if (order.isFitted == true)
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              spacing: AppSpacing.small,
              children: [
                Row(
                  spacing: AppSpacing.small,
                  children: [
                    Blob(text: order.price.toString()),
                    Blob(
                      text: 'orders.pcs'.tr(
                        context: context,
                        namedArgs: {'number': '${order.amount}'},
                      ),
                    ),
                  ],
                ),
                Row(children: [Blob(text: order.priceFull.toString())]),
              ],
            ),
          ),

        if (order.isFitted == false)
          Text(
            'orders.not_found'.tr(),
            style: AppTextStyle.captionBold.copyWith(color: Colors.redAccent),
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
