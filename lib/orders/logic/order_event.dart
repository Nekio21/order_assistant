part of 'order_bloc.dart';

abstract class OrderEvent{}

class SendEmail extends OrderEvent{
  final String text;

  SendEmail(this.text);
}