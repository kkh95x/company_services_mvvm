import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm_desgin_app/app/di.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/routes_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _homeViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _homeViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getConectWidget(),
                    () {
                  _homeViewModel.start();
                }) ??
                _getConectWidget();
          },
        ),
      ),
    );
  }

  Widget _getConectWidget() {
    return StreamBuilder<HomeObject>(
      stream: _homeViewModel.outputHomeObject,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBanner(snapshot.data?.data.banners),
            _getSection(AppString.services),
            _getServiesWidget(snapshot.data?.data.services),
            _getSection(AppString.stores),
            _getStoreWidget(snapshot.data?.data.stores),
          ],
        );
      },
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPading.p12,
          right: AppPading.p12,
          top: AppPading.p12,
          bottom: AppPading.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _homeViewModel.dispose();
  }

  Widget _getBanner(List<BannerAd>? baners) {
    if (baners != null) {
      return CarouselSlider(
          items: baners
              .map((baner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          baner.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s190,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getServiesWidget(List<Services>? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPading.p12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          height: AppSize.s160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                            color: ColorManager.white,
                            width: AppSize.s1,
                          )),
                      child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            height: AppSize.s120,
                            width: AppSize.s120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppPading.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      ]),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoreWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            top: AppSize.s12, left: AppSize.s12, right: AppSize.s12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                
                final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: _animationController, curve: Interval((1/(stores.length))*index,1.0)));
                _animationController.forward();
                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, Widget? child) {
                    return FadeTransition(
                      opacity: animation,
                      child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 50 * (1.0 - animation.value), 0.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.storeDetailsRoute);
                          },
                          child: Card(
                            elevation: AppSize.s4,
                            child: Image.network(
                              stores[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
