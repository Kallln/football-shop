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


Tugas 8
1. Jelaskan perbedaan antara Navigator.push() dan Navigator. pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
  - Perbedaan Navigator.push() dan Navigator.pushReplacement():
  push() akan menambahkan route baru diatas route yang sudah ada sebelumnya pada atas stack, sedangkan pushReplacement() menggantikan rute yang sudah ada pada atas stack dengan route baru tersebut. 
  - Navigator.push() digunakan ketika ingin menampilkan halaman baru, dan dapat kembali ke halaman sebelumnya dengan tombol back. Contoh: Navigasi dari halaman All Products dan halaman detail product.
  - Navigator.pushReplacement() digunakan ketika ingin menampilkan halaman baru, tapi user tidak dapat ke halaman sebelumnya. Contoh: User berhasil login, pindah ke halaman utama tanpa bisa kembali ke halaman login.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
  ```dart
  Scaffold(
    appBar: AppBar(),
    drawer: LeftDrawer(),
  );
  ```
  Scaffold sebagai kerangka utamanya, menyediakan slot untuk elemen-elemen, seperti appBar, drawer, body, dll.
  AppBar memberikan konsistensi visual (warna, gaya teks) dan navigasi global untuk halaman tersebut, misalnya tombol kembali.
  Drawer digunakan untuk navigaasi antar halaman yang dapat diakses dari manapun.
  Supaya hierarcy widget tersebut dapat dimanfaatkan untuk struktur halaman yang konsisten bisa dibuat class baru yang meng-*extends* statelesswidget, dan di dalamnya terdapat Widget Build dengan kode di atas yang nantinya disesuaikan dengan aplikasi yang dibuat.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
  - Padding digunakan untuk memberi jarak antar elemen agar tampilan yang dihasilkan berjarak, tidak terlalu rapat, dan nyaman untuk dilihat. Contohnya: pembuatan tiap form, seperti nama, harga, deskripsis, untuk produk di productlist_form.dart
  - SingleChildScrollView membuat seluruh isi halaman dapat di-*scroll* secara vertikal ataupun horizontal, widget ini membantu untuk terhindar dari overflow saat form terlalu panjang. Contohnya: Di productlist_form, SingleChildScrollView sebagai parent dari column yang berisi padding-padding nama, harga, dan lain-lain.
  - ListView merupakan widget yang mirip gabungan SingleChildScrollView dan Column, tapi lebih efisien dan fleksibel, terutama saat harus menambilkan banyak elemen yang bisa dinamis, widget ini mendukung scroll otomatis tanpa perlu widget baru. Contohnya: Pembuatan drawer seperti di leftdrawer.dart

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
  Saya menggunakan warna biru sebagai warna tema utama Football Shop yang memberi kesan modern dan nyaman sehingga pengguna merasa yakin saat berbelanja di aplikasi ini. Hal itu saya sesuaikan dengan membuat palet warna aplikasi secara keseluruhan dan menetapkan tema secara konsisten.