import 'package:etronix/Models/admin_dashboard/product_model.dart';
import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onEdit;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name
            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

           
            Wrap(
              spacing: 6,
              children: product.categories
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            ),

            const SizedBox(height: 6),

            
            Row(
              children: [
                Icon(
                  product.isAvailable
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: product.isAvailable
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(product.isAvailable
                    ? 'Available'
                    : 'Out of Stock'),
              ],
            ),

            if (product.hasCoupon)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Chip(
                  label: Text('Coupon'),
                  backgroundColor: Colors.greenAccent,
                ),
              ),

            const Spacer(),

           
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
