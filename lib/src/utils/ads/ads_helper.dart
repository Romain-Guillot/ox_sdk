import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  static showInterstitial(String adUnit) async {
    final onFinish = Completer<void>();
    InterstitialAd.load(
      adUnitId: adUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (_) => onFinish.complete(),
        onAdLoaded: (ad) async {
          ad.fullScreenContentCallback = _AdCallback<InterstitialAd>(
            onClosed: onFinish,
          );
          await ad.show();
        },
      ),
    );
    await onFinish.future;
  }

  static Future<bool> showRewarded(String adUnit) async {
    bool rewardEarned = false;
    final Completer<void> onFinish = Completer<void>();
    await RewardedAd.load(
      adUnitId: adUnit,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdFailedToLoad: (_) => onFinish.complete(),
        onAdLoaded: (RewardedAd ad) async {
          ad.fullScreenContentCallback = _AdCallback<RewardedAd>(
            onClosed: onFinish,
          );
          await ad.show(onUserEarnedReward: (ad, reward) {
            rewardEarned = true;
          });
        },
      ),
    );
    await onFinish.future;
    return rewardEarned;
  }
}

class _AdCallback<T extends Ad> extends FullScreenContentCallback<T> {
  _AdCallback({
    // Function(T ad)? onAdLoaded,
    // Function(T ad, LoadAdError error)? onAdFailedToLoad,
    // Function(T ad)? onNativeAdImpression,
    // Function(Ad ad)? onAdClosed,
    Completer<void>? onShowed,
    required Completer<void> onClosed,
  }) : super(
          onAdShowedFullScreenContent: (T ad) {
            // onAdLoaded?.call(ad);
            onShowed?.complete();
          },
          onAdDismissedFullScreenContent: (T ad) {
            // onAdClosed?.call(ad);
            ad.dispose();
            if (!onClosed.isCompleted) {
              onClosed.complete();
            }
          },
          onAdFailedToShowFullScreenContent: (T ad, AdError loadAdError) {
            // onAdFailedToLoad?.call(ad, loadAdError);
            ad.dispose();
            if (!onClosed.isCompleted) {
              onClosed.complete();
            }
          },
          // onAdImpression: onNativeAdImpression,
        );
}
