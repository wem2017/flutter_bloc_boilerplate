import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/utils/utils.dart';
import 'package:envato/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    createBannerAd();
    createInterstitialAd();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }

  ///Create BannerAd
  void createBannerAd() {
    final banner = BannerAd(
      size: AdSize.largeBanner,
      request: const AdRequest(),
      adUnitId: Ads.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            bannerAd = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
      ),
    );
    banner.load();
  }

  ///Create InterstitialAd
  void createInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: Ads.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  ///Show InterstitialAd
  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

  ///On logout
  void onLogout() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('log_out')),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  Translate.of(context).translate('would_you_like_log_out'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('close'),
              onPressed: () {
                Navigator.pop(context, false);
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('log_out'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    if (result == true) {
      AppBloc.signCubit.onLogOut();
    }
  }

  ///On navigation
  void onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///Build Banner Ads
  Widget buildBanner() {
    if (bannerAd != null) {
      return SizedBox(
        width: bannerAd!.size.width.toDouble(),
        height: bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: bannerAd!),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('account'),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: onLogout,
              ),
            ],
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  AppListTitle(
                    title: Translate.of(context).translate('setting'),
                    leading: Icon(
                      Icons.settings_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      onNavigate(Routes.setting);
                    },
                    trailing: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  buildBanner(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
