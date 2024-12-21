#!/bin/bash

# Proje dizinindeki tüm .g.dart dosyalarını bul ve sil
find . -type f -name "*.g.dart" -exec rm -v {} +

# İşlem tamamlandı mesajı
echo "All .g.dart files have been deleted."
