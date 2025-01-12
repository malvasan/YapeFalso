import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/utils.dart';

class PaymentHistoryCard extends ConsumerWidget {
  const PaymentHistoryCard({super.key, required this.transfer});

  final Transfer transfer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          title: Text(
            transfer.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            convertToYapeFormat(transfer.createdAt),
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
          trailing: transfer.isPositive
              ? Text(
                  'S/ ${transfer.amount.toStringAsPrecision(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              : Text(
                  '- S/ ${transfer.amount.toStringAsPrecision(2)}',
                  style: const TextStyle(
                    color: Color(0xFFD3526E),
                    fontSize: 18,
                  ),
                ),
          onTap: () => ref.read(autorouteProvider).push(
                ConfirmationRoute(
                  yapeo: false,
                  transferData: transfer,
                ),
              ),
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          height: 1,
        ),
      ],
    );
  }
}
