// Mocks generated by Mockito 5.3.2 from annotations
// in restaurant_app/test/ui/home_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:restaurant_app/data/api/api_services.dart' as _i5;
import 'package:restaurant_app/data/models/restaurant_detail.dart' as _i3;
import 'package:restaurant_app/data/models/restaurants.dart' as _i2;
import 'package:restaurant_app/data/models/review.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRestaurantsModel_0 extends _i1.SmartFake
    implements _i2.RestaurantsModel {
  _FakeRestaurantsModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRestaurantDetailModel_1 extends _i1.SmartFake
    implements _i3.RestaurantDetailModel {
  _FakeRestaurantDetailModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeReviewModel_2 extends _i1.SmartFake implements _i4.ReviewModel {
  _FakeReviewModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i5.ApiService {
  @override
  String imageBaseUrl({
    _i5.Resolution? resolution,
    required String? pictureId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #imageBaseUrl,
          [],
          {
            #resolution: resolution,
            #pictureId: pictureId,
          },
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i6.Future<_i2.RestaurantsModel> restaurantList(String? keyword) =>
      (super.noSuchMethod(
        Invocation.method(
          #restaurantList,
          [keyword],
        ),
        returnValue:
            _i6.Future<_i2.RestaurantsModel>.value(_FakeRestaurantsModel_0(
          this,
          Invocation.method(
            #restaurantList,
            [keyword],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i2.RestaurantsModel>.value(_FakeRestaurantsModel_0(
          this,
          Invocation.method(
            #restaurantList,
            [keyword],
          ),
        )),
      ) as _i6.Future<_i2.RestaurantsModel>);
  @override
  _i6.Future<_i3.RestaurantDetailModel> restaurantDetail(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #restaurantDetail,
          [id],
        ),
        returnValue: _i6.Future<_i3.RestaurantDetailModel>.value(
            _FakeRestaurantDetailModel_1(
          this,
          Invocation.method(
            #restaurantDetail,
            [id],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i3.RestaurantDetailModel>.value(
            _FakeRestaurantDetailModel_1(
          this,
          Invocation.method(
            #restaurantDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.RestaurantDetailModel>);
  @override
  _i6.Future<_i4.ReviewModel> addReview(
    String? id,
    String? name,
    String? review,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addReview,
          [
            id,
            name,
            review,
          ],
        ),
        returnValue: _i6.Future<_i4.ReviewModel>.value(_FakeReviewModel_2(
          this,
          Invocation.method(
            #addReview,
            [
              id,
              name,
              review,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.ReviewModel>.value(_FakeReviewModel_2(
          this,
          Invocation.method(
            #addReview,
            [
              id,
              name,
              review,
            ],
          ),
        )),
      ) as _i6.Future<_i4.ReviewModel>);
}