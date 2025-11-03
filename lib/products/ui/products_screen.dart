import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:order_assistant/core/ui/app_spacing.dart';
import 'package:order_assistant/core/ui/app_text_style.dart';
import 'package:order_assistant/core/ui/app_theme.dart';
import 'package:order_assistant/products/logic/product_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/ui/app_loading.dart';
import '../data/product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ProductBloc(),
      child: _ProductsWidget(),
    );
  }
}

class _ProductsWidget extends StatefulWidget {
  const _ProductsWidget();

  @override
  State<_ProductsWidget> createState() => _ProductState();
}

class _ProductState extends State<_ProductsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(LoadProducts());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;

    return AppLoading(
      isLoading: state.isLoading,
      child: SingleChildScrollView(
        child: Column(
          spacing: AppSpacing.base,
          children: (state.products)
              .map(
                (p) => productCard(p)
              )
              .toList(),
        ),
      ),
    );
  }

  Widget productCard(Product product) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.small,
      ),
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        spacing: AppSpacing.small,
        children: [
          CachedNetworkImage(
            imageUrl: product.imageUrl,
            width: 80,
            height: 80,
            placeholder: (context, url) =>
                CircularProgressIndicator(color: AppTheme.primary),
            errorWidget: (context, url, error) => Icon(Symbols.shopping_bag),
          ),
          Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.maxSmall,
            children: [
              Text(product.name, style: AppTextStyle.captionBold),
              Text(
                product.description,
                textAlign: TextAlign.justify,
                softWrap: true,
                style: AppTextStyle.captionSmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: price(product.price),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget price(double price) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.small),
      decoration: BoxDecoration(
        color: AppTheme.accent,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        '$price',
        style: AppTextStyle.captionBold.copyWith(color: AppTheme.onAccent, fontSize: 14),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
