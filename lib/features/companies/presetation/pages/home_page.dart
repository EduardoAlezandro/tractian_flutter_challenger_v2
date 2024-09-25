import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/presetation/stores/company_store.dart';
import 'package:tractian_flutter_challenger_v2/routes/app_routes.dart';

class HomePage extends GetView<CompanyStore> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        title: Image.asset("assets/images/logo_tractian.png"),
      ),
      body: Observer(
        builder: (_) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.companies.isEmpty) {
            return const Center(child: Text('Nenhuma empresa disponível.'));
          } else {
            return Center(
              child: ListView.builder(
                itemCount: controller.companies.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                itemBuilder: (context, index) {
                  final company = controller.companies[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SizedBox(
                      width: 317,
                      height: 76,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.assetPage,
                            arguments: {'companyId': company.id},
                          );
                        },
                        child: Row(
                          children: [
                            Image.asset('assets/images/companies_icon.png'),
                            const SizedBox(width: 16),
                            Text(
                              company.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
