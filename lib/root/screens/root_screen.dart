import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:order_assistant/core/ui/theme/app_text_style.dart';
import 'package:order_assistant/core/ui/theme/app_theme.dart';
import 'package:order_assistant/core/ui/widgets/app_button.dart';
import 'package:order_assistant/core/ui/theme/app_spacing.dart';
import 'package:order_assistant/orders/presentation/screens/orders_screen.dart';
import 'package:order_assistant/products/presentation/screens/products_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootState();
}

enum Screen { products, orders }

class _RootState extends State<RootScreen> {
  Screen currentScreen = Screen.products;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),

          child: Column(
            spacing: AppSpacing.large,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                  vertical: AppSpacing.base,
                ),
                color: AppTheme.primary,
                child: Text(
                  'general.app_name'.tr(),
                  style: AppTextStyle.headingLarge.copyWith(
                    color: AppTheme.onPrimary,
                  ),
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: currentScreen == Screen.products ? 0 : 1,
                  children: const [
                    SizedBox.expand(child: ProductsScreen()),
                    SizedBox.expand(child: OrdersScreen()),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    isActive: currentScreen == Screen.products,
                    icon: Symbols.shoppingmode,
                    text: 'products.button_name'.tr(),
                    onClick: () {
                      setState(() {
                        currentScreen = Screen.products;
                      });
                    },
                  ),
                  AppButton(
                    isActive: currentScreen == Screen.orders,
                    icon: Symbols.delivery_truck_speed,
                    text: 'orders.button_name'.tr(),
                    onClick: () {
                      setState(() {
                        currentScreen = Screen.orders;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
