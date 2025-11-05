# football_shop

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
  Widget tree adalah representasi hierarki widget yang menyusun tampilan antarmuka sebuah aplikasi Flutter. Widget parent memberikan constraints (batasan ukuran dan aturan tata letak) dan mengatur posisi widget child; widget child menyesuaikan dirinya berdasarkan constraints tersebut. Data biasanya diteruskan dari parent ke child lewat konstruktor, sedangkan aksi atau event dikembalikan ke parent melalui callback. Contoh: `Row` menata anaknya secara horizontal.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
  - Custom widgets: `MyHomePage`, `InfoCard`, `ItemCard`.
    - `MyHomePage`: menampilkan halaman utama aplikasi (AppBar, info user, pesan sambutan, dan grid menu).
    - `InfoCard`: kartu kecil untuk menampilkan pasangan title + content (dipakai 3 kali di baris atas).
    - `ItemCard`: kartu berwarna yang menampilkan ikon dan nama fitur; merespons tap (menampilkan SnackBar).
  - Model data (bukan widget): `ItemHomepage` (menyimpan name, icon, color).
  - Beberapa widget built-in yang digunakan: `Scaffold`, `AppBar`, `Text`, `Padding`, `Column`, `Row`, `SizedBox`, `Center`, `GridView.count`, `Card`, `Container`, `Material`, `InkWell`, `SnackBar`, `Icon`.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
  `MaterialApp` adalah wrapper yang menyiapkan konfigurasi aplikasi tingkat-atas bagi widget Material. Dengan menaruh `MaterialApp` di root, descendant mendapat akses ke layanan penting seperti `Theme` (`Theme.of(context)`), `Navigator`/routing, `MediaQuery`/`Directionality`, serta dukungan lokalization dan `Scaffold`/overlay services (mis. `ScaffoldMessenger`). Karena mengumpulkan pengaturan penting (theme, routes, localization) di satu tempat dan menyediakan inherited widgets yang dibutuhkan oleh widget Material, `MaterialApp` biasanya dipakai sebagai widget root pada aplikasi yang mengikuti Material Design.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
  - StatelessWidget
    - Tidak memiliki state internal yang berubah setelah dibuat.
    - Hanya bergantung pada properti yang diteruskan lewat konstruktor dan `BuildContext`.
    - Cocok untuk komponen presentasional yang deterministik.
  - StatefulWidget
    - Memiliki objek `State` terpisah yang menyimpan data yang bisa berubah.
    - Memungkinkan pemanggilan `setState()` untuk memicu rebuild bagian yang berubah.
    - Cocok untuk UI yang bereaksi terhadap interaksi pengguna, animasi, atau data yang berubah seiring waktu.
  Pilih `StatelessWidget` bila tidak perlu menyimpan state lokal. Pilih `StatefulWidget` bila butuh lifecycle hooks (`initState`, `didChangeDependencies`, `dispose`) atau perlu menyimpan/memanipulasi state lokal.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
  `BuildContext` adalah objek yang merepresentasikan lokasi sebuah widget di dalam element/widget tree. `build(BuildContext context)` menerima `context` karena melalui context widget dapat mengakses inherited widgets dan layanan aplikasi—misalnya `Theme.of(context)`, `MediaQuery.of(context)`, dan `Navigator.of(context)`. `BuildContext` juga dipakai untuk mencari ancestor/descendant di tree. Perhatian: jangan menyimpan `BuildContext` dan menggunakannya setelah widget di-dispose; untuk operasi asinkron di `State`, periksa `mounted` sebelum memakai `context`.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
  - Hot reload: menerapkan perubahan kode ke aplikasi yang sedang berjalan dan membangun ulang widget tree sambil mempertahankan state aplikasi. Cepat dan berguna saat mengubah tampilan UI.
  - Hot restart: memulai ulang aplikasi (VM) dan memuat ulang semua kode sehingga state aplikasi ter-reset. Diperlukan untuk perubahan yang memengaruhi inisialisasi global atau tipe state.
