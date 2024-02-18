import 'package:flutter/material.dart';
import '../../model/get_card_model.dart';
import '../../res/color.dart';
import '../../utils/routes/routes_name.dart';

class CardTemplate extends StatelessWidget {
  const CardTemplate({
    Key? key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.getCardResponse,
  }) : super(key: key);

  final String cardHolderName;
  final String cardNumber;
  final GetCardModel? getCardResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/card_template.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          if (!(getCardResponse?.hasCard ?? false))
            Center(
              child: SizedBox(
                height: 40, // Set your desired margin height
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Apply Card button press
                    Navigator.pushNamed(context, RoutesName.apply);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor,
                  ),
                  child: const Text('Apply Card'),
                ),
              ),
            ),
          if (getCardResponse?.hasCard ?? false)
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          Colors.yellowAccent,
                          Colors.redAccent,
                          Colors.yellow,
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      cardNumber.replaceAllMapped(
                          RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cardHolderName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}