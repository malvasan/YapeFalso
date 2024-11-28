import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yapefalso/domain/transfer.dart';
import 'package:yapefalso/domain/user_metadata.dart';

part 'data_base_repository.g.dart';

class DataBaseRepository {
  DataBaseRepository(this.supabase);

  final SupabaseClient supabase;

  Future<UserMetadata> retrieveCurrentUser() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('user is null');
    }

    try {
      final response = await supabase
          .from('profiles')
          .select(
              'name, phoneNumber:phone_number, dni, email, credit, accountNumber:account_number')
          .eq('id', user.id)
          .limit(1);
      response[0]['id'] = '';
      return UserMetadata.fromJson(response[0]);
    } catch (e) {
      throw Exception('user data not retrieved');
    }
  }

  Future<double> retrieveUserCredit() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('user is null');
    }

    try {
      final response = await supabase
          .from('profiles')
          .select('credit')
          .eq('id', user.id)
          .limit(1);
      return response[0]['credit'].toDouble();
    } catch (e) {
      throw Exception('user credit not retrieved');
    }
  }

  Future<List<Transfer>> retrieveTransfers() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('user is null');
    }
    try {
      final response = await supabase
          .from('transfers')
          .select(
              'id, createdAt:created_at, amount, userNote:user_note, from:receiver_id(id, name, phoneNumber:phone_number), to:provider_id(id, name, phoneNumber:phone_number)')
          .or('receiver_id.eq.${user.id},provider_id.eq.${user.id}')
          .order('created_at', ascending: false)
          .limit(7);

      var transfersList = <Transfer>[];
      for (var value in response) {
        if (value['from']['id'] == user.id) {
          value['name'] = value['to']['name'];
          value['phoneNumber'] = value['to']['phoneNumber'];
          value['isPositive'] = true;
        } else if (value['to']['id'] == user.id) {
          value['name'] = value['from']['name'];
          value['phoneNumber'] = value['from']['phoneNumber'];
          value['isPositive'] = false;
        }
        value.remove('from');
        value.remove('to');
        transfersList.add(Transfer.fromJson(value));
      }
      return transfersList;
    } catch (e) {
      throw Exception('user transfers not retrieved');
    }
  }

  Future<UserMetadata> retrieveUserByPhone(int phone) async {
    try {
      final response = await supabase
          .from('profiles')
          .select(
              'id, name, phoneNumber:phone_number, dni, email, credit, accountNumber:account_number')
          .eq('phone_number', phone)
          .limit(1);

      return UserMetadata.fromJson(response[0]);
    } catch (e) {
      throw Exception('user data not retrieved');
    }
  }

  Future<Transfer> transfer(
      {required double amount,
      required String receiverID,
      required String userNote}) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('user is null');
    }
    final providerID = user.id;
    try {
      final paymentResponse = await supabase.rpc('insert_transfer', params: {
        'amount': amount,
        'receiver_id': receiverID,
        'provider_id': providerID,
        'user_note': userNote,
      });

      final transferResponse = await supabase
          .from('transfers')
          .select(
              'id, createdAt:created_at, amount, userNote:user_note, from:receiver_id(id, name, phoneNumber:phone_number)')
          .eq('id', paymentResponse)
          .limit(1);

      transferResponse[0]['name'] = transferResponse[0]['from']['name'];
      transferResponse[0]['phoneNumber'] =
          transferResponse[0]['from']['phoneNumber'];
      transferResponse[0]['isPositive'] = false;

      transferResponse[0].remove('from');

      return Transfer.fromJson(transferResponse[0]);

      //return UserMetadata.fromJson(response);
    } catch (e) {
      throw Exception('user data not retrieved, ${e.toString()}');
    }
  }

  Future<List<Transfer>> retrieveTransfersByDate(DateTime date) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('user is null');
    }
    try {
      final response = await supabase
          .from('transfers')
          .select(
              'id, createdAt:created_at, amount, userNote:user_note, from:receiver_id(id, name, phoneNumber:phone_number), to:provider_id(id, name, phoneNumber:phone_number)')
          .gte('created_at', date.toIso8601String())
          .or('receiver_id.eq.${user.id},provider_id.eq.${user.id}')
          .order('created_at', ascending: true)
          .limit(7);

      var transfersList = <Transfer>[];
      for (var value in response) {
        if (value['from']['id'] == user.id) {
          value['name'] = value['to']['name'];
          value['phoneNumber'] = value['to']['phoneNumber'];
          value['isPositive'] = true;
        } else if (value['to']['id'] == user.id) {
          value['name'] = value['from']['name'];
          value['phoneNumber'] = value['from']['phoneNumber'];
          value['isPositive'] = false;
        }
        value.remove('from');
        value.remove('to');
        transfersList.add(Transfer.fromJson(value));
      }
      return transfersList;
    } catch (e) {
      throw Exception('user transfers not retrieved');
    }
  }
}

@Riverpod(keepAlive: true)
DataBaseRepository dataBase(DataBaseRef ref) {
  return DataBaseRepository(Supabase.instance.client);
}
