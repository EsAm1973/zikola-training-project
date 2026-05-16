import 'package:zikola_training_project/Features/onboarding/data/models/onboarding_page_data.dart';
import 'package:zikola_training_project/generated/assets.dart';

class OnboardingData {
  static final List<OnboardingPageData> pages = [
    OnboardingPageData(
      image: Assets.assetsImagesOnboard1,
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingPageData(
      image: Assets.assetsImagesOnboard2,
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingPageData(
      image: Assets.assetsImagesOnboard3,
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];
}
