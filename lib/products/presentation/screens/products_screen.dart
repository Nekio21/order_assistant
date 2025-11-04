import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:order_assistant/core/data/models/product.dart';
import 'package:order_assistant/core/errors/error_mapper.dart';
import 'package:order_assistant/core/ui/theme/app_spacing.dart';
import 'package:order_assistant/core/ui/theme/app_text_style.dart';
import 'package:order_assistant/core/ui/theme/app_theme.dart';
import 'package:order_assistant/core/ui/widgets/app_loading.dart';
import 'package:order_assistant/core/ui/widgets/blob.dart';
import 'package:order_assistant/products/presentation/bloc/product_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ProductBloc(),
      child: const _ProductsWidget(),
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
      final bloc = context.read<ProductBloc>();
      bloc.add(LoadProducts());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;

    return BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) => previous.error != current.error,
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(getErrorMessage(state.error!))));
          }
        },
        child: AppLoading(
          isLoading: state.isLoading,
          child: SingleChildScrollView(
            child: Column(
              spacing: AppSpacing.base,
              children: (state.products).map((p) => productCard(p)).toList(),
            ),
          ),
        ));
  }

  Widget productCard(Product product) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.small,
      ),
      decoration: const BoxDecoration(
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
                const CircularProgressIndicator(color: AppTheme.primary),
            errorWidget: (context, url, error) =>
                const Icon(Symbols.shopping_bag),
          ),
          Expanded(
            child: Column(
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
                  child: Blob(text: '${product.price}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
