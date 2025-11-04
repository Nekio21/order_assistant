import 'package:easy_localization/easy_localization.dart';

import 'package:order_assistant/core/errors/failures.dart';

String getErrorMessage(Failure error) {
  if (error is NetworkFailure) {
    return 'errors.network'.tr();
  } else if (error is ServerFailure) {
    return 'errors.server'.tr();
  } else if (error is KeyFailure) {
    return 'errors.key'.tr();
  }else if (error is AIFailure) {
    return 'errors.ai'.tr();
  } else {
    return 'errors.unknown'.tr();
  }
}