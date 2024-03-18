import 'package:flutter/material.dart';

import '../../res/color.dart';
import 'faq_items.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
      ),
      body: ListView(
        children: const [
          FAQItem(
            question: 'Q1. Do you have apps for iPhones?',
            answer: 'Sorry. We currently don’t have iPhone App.',
          ),
          FAQItem(
            question: 'Q2. Do you have web dashboard?',
            answer: 'Yes we have web dashboard for admins.',
          ),
          FAQItem(
            question: 'Q3. Do you have any website?',
            answer: 'https://dma.com.bd',
          ),
          FAQItem(
            question: 'Q4. Do you provide services all over Bangladesh?',
            answer: 'Yes. We do.',
          ),
          FAQItem(
            question: 'Q5. Can you provide services internationally?',
            answer: 'Yes. We can.',
          ),
          FAQItem(
            question: 'Q6. How can I contact you?',
            answer: 'You can call us by +8801711083958 or send an email to: info@dma-bd.com',
          ),
          FAQItem(
            question: 'Q7. Where is your office?',
            answer: 'Our corporate office is at Rupayan Shelford Building-Level14, 23/6 Mirpur Road, Shyamoli, Dhaka-1200, Bangladesh.',
          ),
          FAQItem(
            question: 'Q8. Where is your Factory?',
            answer: 'Our Datasoft Manufacturing & Assembly Inc. Ltd. factory is located in Bangabandhu Hi-Tech City, Kaliakair, Gazipur, Bangladesh.',
          ),
        ],
      ),
    );
  }
}