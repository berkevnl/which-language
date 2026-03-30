# mini-scoreboard Projesi (V1)

## V0'dan V1'e Geçiş ve Değişiklik Özeti
Bu sürümde (V1), projenin altyapısına **while döngüleri** entegre edilmiş ve sistem statik veri yazmadan çıkıp dinamik veri okuma aşamasına geçmiştir.

**Tamamlanan Görevler (Tasks):**
1. **Teknik Borç Kapatıldı:** V0'da dosya satır sayısına göre (`\n` sayılarak) yapılan kırılgan ID üretimi, `while` döngüsü ile veritabanını satır satır okuyan ve boşlukları atlayan güvenli bir yapıya çevrildi.
2. **History Komutu:** `while` döngüsü yardımıyla `matches.dat` içerisindeki tüm maçlar okunarak formatlı bir şekilde ekrana basıldı.
3. **Team Komutu:** Girilen takım adına göre veritabanını `while` ile satır satır filtreleyen ve sadece eşleşen maçları getiren algoritma yazıldı.
4. **BONUS (Codex / AI Entegrasyonu):** `stats` komutu bir yapay zeka aracına (prompt mühendisliği ile) yazdırılıp sisteme başarıyla entegre edildi. Dosyadaki atılan tüm gollerin toplamını matematiksel olarak ekrana basmaktadır.
