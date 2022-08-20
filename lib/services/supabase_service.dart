import 'package:supabase/supabase.dart';

class SupaBaseService {
  static const url = 'https://wuauudtaykmnliiorwcb.supabase.co';
  static const key =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1YXV1ZHRheWttbmxpaW9yd2NiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY2MDcxODM0NywiZXhwIjoxOTc2Mjk0MzQ3fQ.7MIjKO5HtH4A_o4PEmC5nzzArNTRWLT-O2v_JFse_NQ';

  final SupabaseClient _supabaseClient;
  static final SupaBaseService _singleton = SupaBaseService._internal();

  SupaBaseService._internal() : _supabaseClient = SupabaseClient(url, key);
  factory SupaBaseService() {
    print('Created: SupaBaseService');
    return _singleton;
  }

  static SupaBaseService get instance => _singleton;
  static SupabaseClient get client => instance._supabaseClient;
}
