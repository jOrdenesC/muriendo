import 'package:movitronia/Database/Models/evidencesSend.dart';

abstract class EvidencesRepository {
  Future<int> insertEvidence(EvidencesSend evidencesSend);

  Future updateEvidence(EvidencesSend evidencesSend);

  Future deleteEvidence(String gifDataId);

  Future deleteAll();

  Future<List<EvidencesSend>> getAllEvidences();

  Future<List<EvidencesSend>> getEvidenceID(String id);

  Future<List<EvidencesSend>> getEvidenceNumber(int id);
}
