import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/bloc/cart_state.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/features/order/domain/exceptions/empty_cart_exception.dart';
import 'package:pizza_app/features/order/domain/usecases/create_order_usecase.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final cartCubit = context.read<CartCubit>();
    final items = cartCubit.state.items;
    final address = context.read<AddressesCubit>().state.selectedAddress;

    if (items.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.orderEmptyCart)));
      return;
    }
    if (address == null) {
      router.push('/addresses-list');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final createOrder = sl<CreateOrderUsecase>();
      await createOrder(CreateOrderParams(items: items, address: address));

      cartCubit.clearCart();
      messenger.showSnackBar(SnackBar(content: Text(l10n.orderCreated)));
      router.go('/');
    } on EmptyCartException {
      messenger.showSnackBar(SnackBar(content: Text(l10n.orderEmptyCart)));
    } catch (e) {
      debugPrint(e.toString());
      messenger.showSnackBar(SnackBar(content: Text(l10n.orderFailed)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) => PrimaryFilledButton(
        onPressed: (_isLoading || state.items.isEmpty) ? null : _onPressed,
        label: l10n.proceedToCheckoutForButton(state.totalPrice),
      ),
    );
  }
}
