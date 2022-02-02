bool isNFeURL(Uri url) {
  return url.host.contains('fazenda') 
      && (url.host.contains('nfce') || url.host.contains('nfe'));
}