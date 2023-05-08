import 'package:comprei/components/purchase_repository.dart';
import 'package:comprei/presentation/bloc/purchase_list/purchase_list_bloc.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchasesListWidget extends StatelessWidget {
  const PurchasesListWidget({
    Key? key,
    required this.purchaseRepository,
  }) : super(key: key);

  final PurchaseRepository purchaseRepository;

  Widget _buildScreenByState(PurchaseListState state) {
    if (state is LoadedPurchaseListState) {
      final purchases = state.purchaseSummaries;
      return ListView.builder(
        itemCount: purchases.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(purchases[index].merchant.nickName ??
                purchases[index].merchant.name),
            subtitle: Text(purchases[index].id.toString()),
          ),
        ),
      );
    }

    return const LoadingWidget();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PurchaseListBloc(),
      child: BlocBuilder<PurchaseListBloc, PurchaseListState>(
        builder: (context, state) {
          BlocProvider.of<PurchaseListBloc>(context).add(
            PurchaseListLoadEvent(purchaseRepository: purchaseRepository),
          );
          return _buildScreenByState(state);
        },
      ),
    );
  }
}

class PurchaseListScreen extends StatelessWidget {
  const PurchaseListScreen({
    Key? key,
    required this.purchaseRepository,
  }) : super(key: key);

  final PurchaseRepository purchaseRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('purchases'),
      ),
      body: PurchasesListWidget(
        purchaseRepository: purchaseRepository,
      ),
    );
  }
}
