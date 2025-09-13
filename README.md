#Case'in kısa bir tanıtım videosu---

https://drive.google.com/file/d/1LRXm6qeIvmBItYt0T9qPVJ_BGZ2Wy_73/view?usp=sharing



#Temel Özellikler---

Kimlik Doğrulama: Giriş ve kayıt işlemleri, güvenli oturum token depolama ve başarılı giriş sonrası ana sayfaya otomatik yönlendirme.
Ana Sayfa: Sayfa başına 5 film ile sonsuz kaydırma, otomatik yükleme göstergesi, pull-to-refresh ve favori filmler için gerçek zamanlı UI güncellemeleri.
Kullanıcı Profili: Kullanıcı bilgilerini görüntüleme, favori filmleri yönetme ve profil fotoğrafı yükleme.
Navigasyon: Alt navigasyon çubuğu, akıcı sayfa geçişleri, state management ve sekmeler arası state korunumu.
Mimari & Kod: Clean Architecture, MVVM ve Bloc state management ile sürdürülebilir ve ölçeklenebilir kod yapısı.



#Ekstra Özellikler---

Özel tema & navigasyon servisi
Çoklu dil desteği (İngilizce & Türkçe)
Debug için logger servisi
Hafif Firebase Crashlytics & Analytics entegrasyonu
Lottie ile animasyonlar
Splash ekran ve uygulama ikonu



#Test-Case & Demo---

Giriş, sonsuz kaydırma, favoriler ve profil güncellemeleri gibi temel akışları gösterir.
Uygulamanın tam test edilebilir UI ve fonksiyonelliği, video demo ile gösterilmektedir.



#Projenin klasör yapısı---

shartflix_movie_app_case/
└── lib/
    ├── connectivity/
    ├── core/
    │   ├── constants/
    │   ├── extensions/
    │   ├── services/
    │   ├── themes/
    │   ├── utils/
    │   └── widgets/
    ├── features/
    │   ├── auth/
    │   │   ├── model/
    │   │   ├── view/
    │   │   └── viewmodel/
    │   ├── movie/
    │   │   ├── model/
    │   │   ├── view/
    │   │   └── viewmodel/
    │   ├── photo/
    │   │   ├── view/
    │   │   └── viewmodel/
    │   ├── settings/
    │   │   ├── view/
    │   │   └── viewmodel/
    │   └── splash/
    └── main.dart
