import 'package:flutter_test/flutter_test.dart';
import 'package:comprei/logics/nfe_extractor.dart';

void main() {
  group('Url validation test', () {
    test('Valid nfce fazenda url', () {
      final url = Uri.parse(
          "https://www.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx?p=352110455439150006966");

      expect(isNFeURL(url), true);
    });

    test('Valid nfce fazenda url not sp', () {
      final url = Uri.parse(
          "https://www.nfce.fazenda.rs.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx?p=352110455439150006966");

      expect(isNFeURL(url), true);
    });

    test('Non nfce fazenda url', () {
      final url = Uri.parse("https://portal.fazenda.sp.gov.br/");

      expect(isNFeURL(url), false);
    });

    test('Non fazenda url', () {
      final url = Uri.parse("https://anything.com/");

      expect(isNFeURL(url), false);
    });
  });
}
