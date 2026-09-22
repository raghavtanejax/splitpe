import 'package:flutter/material.dart';
import '../widgets/glass_components.dart';
import '../models/tranche.dart';
import '../services/upi_service.dart';
import '../theme/app_theme.dart';

class FallbackRoutingModal extends StatelessWidget {
  final Tranche tranche;

  const FallbackRoutingModal({super.key, required this.tranche});

  static Future<void> show(BuildContext context, Tranche tranche) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => FallbackRoutingModal(tranche: tranche),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.isDark(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.primaryBlue, width: 2)),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withAlpha(200) : Colors.black.withAlpha(50),
            blurRadius: 30,
            offset: const Offset(0, -10),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PAYMENT ROUTING FAILED',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: AppColors.alertRed,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\\'t open your default UPI app. Try forcing the payment through a specific app below:',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          _buildAppButton(context, 'Google Pay', 'gpay://upi/pay', AppColors.primaryBlue),
          const SizedBox(height: 12),
          _buildAppButton(context, 'PhonePe', 'phonepe://pay', const Color(0xFF6739B7)),
          const SizedBox(height: 12),
          _buildAppButton(context, 'Paytm', 'paytmmp://pay', const Color(0xFF00B9F5)),
          const SizedBox(height: 12),
          _buildAppButton(context, 'Copy Link', null, AppColors.text),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    );
  }

  Widget _buildAppButton(BuildContext context, String appName, String? scheme, Color color) {
    return GlassButton(
      color: color,
      
      
      
      
      onTap: () async {
        if (scheme == null) {
          await UpiService.copyToClipboard(tranche.upiUri);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('⚡ Copied to clipboard!')),
            );
            Navigator.pop(context);
          }
          return;
        }

        final launched = await UpiService.launchUpiIntent(
          tranche.upiUri,
          targetAppScheme: scheme,
        );
        
        if (!launched && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Could not open $appName'),
              backgroundColor: AppColors.alertRed,
            ),
          );
        } else if (context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Center(
          child: Text(
            scheme == null ? 'Copy UPI Link' : 'Try $appName',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
