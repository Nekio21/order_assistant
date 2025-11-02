import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:order_assistant/core/ui/app_button.dart';
import 'package:order_assistant/core/ui/app_spacing.dart';
import 'package:order_assistant/core/ui/app_text_style.dart';
import 'package:order_assistant/core/ui/app_theme.dart';
import 'package:order_assistant/products/ui/products_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootState();
}

enum Screen { products, orders }

class _RootState extends State<RootScreen> {
  Screen screenState = Screen.products;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.large),

          child: Column(
            spacing: AppSpacing.large,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                  vertical: AppSpacing.base,
                ),
                color: AppTheme.primary,
                child: Text(
                  "general.app_name".tr(),
                  style: AppTextStyle.headingLarge.copyWith(
                    color: AppTheme.onPrimary,
                  ),
                ),
              ),
              Expanded(
                child: screenState == Screen.products
                    ? ProductsScreen()
                    : SizedBox.shrink(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    isActive: screenState == Screen.products,
                    icon: Symbols.shoppingmode,
                    text: "products.button_name".tr(),
                    onClick: () {
                      setState(() {
                        screenState = Screen.products;
                      });
                    },
                  ),
                  AppButton(
                    isActive: screenState == Screen.orders,
                    icon: Symbols.delivery_truck_speed,
                    text: "products.button_name".tr(),
                    onClick: () {
                      setState(() {
                        screenState = Screen.orders;
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
