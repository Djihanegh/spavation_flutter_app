import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'errors.dart';

//mixin HttpHandlerMixin {
  String catchExceptions(http.Response? response, error) {
    String? msg;
    if (error is Exception) {
      try {
        if (error is HttpException) {
          switch (response?.statusCode) {
            case 400:
              msg = BadRequest().toString();
              break;
            case 401:
              msg = Unauthorized().toString();
              break;
            case 402:
              msg = PaymentRequired().toString();
              break;
            case 403:
              msg = Forbidden().toString();
              break;
            case 404:
              msg = Http404().toString();
              break;
            case 405:
              msg = MethodNotAllowed(response?.body).toString();
              break;
            case 406:
              msg = NotAcceptable(response?.body).toString();
              break;
            case 407:
              msg = ProxyAuthenticationRequired(response?.body).toString();
              break;
            case 408:
              msg = RequestTimeOut().toString();
              break;
            case 409:
              msg = Conflict(response?.body).toString();
              break;
            case 410:
              msg = Gone(response?.body).toString();
              break;
            case 413:
              msg = PayloadTooLarge(response?.body).toString();
              break;
            case 429:
              msg = TooManyRequests(response?.body).toString();
              break;
            case 500:
              msg = InternalServerError(response?.body).toString();
              break;
            case 501:
              msg = NotImplemented(response?.body).toString();
              break;
            case 502:
              msg = BadGateway(response?.body).toString();
              break;
            case 503:
              msg = ServiceUnavailable(response?.body).toString();
              break;
            case 504:
              msg = GatewayTimeOut(response?.body).toString();
              break;
            case 505:
              msg = HttpVersionNotSupported(response?.body).toString();
              break;
            case 506:
              msg = VariantsAlsoNegotiates(response?.body).toString();
              break;
            case 507:
              msg = InsufficientStorage(response?.body).toString();
              break;
            case 508:
              msg = LoopDetected(response?.body).toString();
              break;

            case 510:
              msg = NotExtended(response?.body).toString();
              break;
            case 511:
              msg = NetworkAuthRequired(response?.body).toString();
              break;
          }
        } else if (error is SocketException) {
          msg = NoInternetConnexion().toString();
        } else {
          msg = UnexpectedError().toString();
        }
      } on FormatException catch (_) {
        return FormatException(response?.body).toString();
      } on PlatformException catch (_) {
        return UnexpectedError().toString();
      } catch (_) {
        msg = UnexpectedError().toString();
      }
    } else {
      msg = UnexpectedError().toString();
    }

    return msg ?? "";
  }

