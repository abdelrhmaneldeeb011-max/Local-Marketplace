import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShopsCard extends StatelessWidget {
  const ShopsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              const Image(image: AssetImage('assets/img/MarketPhoto.png')),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      'marketName'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'open'.tr(),
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.deepOrange[500],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'location'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange[300],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.circle, size: 6, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'categoryName'.tr(),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.circle, size: 6, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'description'.tr(),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
