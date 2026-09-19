import 'package:flutter/material.dart';
import '../models/split_order.dart';
import '../theme/app_theme.dart';
import 'splitpe_logo.dart';
import 'package:intl/intl.dart';

class ReceiptGeneratorUI extends StatelessWidget {
  final SplitOrder order;

  const ReceiptGeneratorUI({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: Colors.white, // Receipts are usually white
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SplitPeLogo(size: 24, showBadge: false),
              Text(
                'TAX INVOICE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Colors.black.withAlpha(150),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            order.merchantName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          Text(
            order.merchantVpa,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withAlpha(150),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.black12, thickness: 2),
          const SizedBox(height: 12),
          ...order.tranches.map((t) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tranche ${t.index}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    if (t.txnRef != null)
                      Text(
                        'Ref: ${t.txnRef}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                          fontFamily: 'monospace',
                        ),
                      ),
                  ],
                ),
                Text(
                  '₹${t.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 12),
          const Divider(color: Colors.black12, thickness: 2),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL PAID',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
              ),
              Text(
                '₹${order.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryGreen),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, color: AppColors.primaryGreen, size: 16),
                SizedBox(width: 8),
                Text(
                  '0% MDR FEE INCURRED',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt)}',
              style: const TextStyle(fontSize: 10, color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
