import 'package:flutter/material.dart';
import 'package:flutter_getx/app/modules/dashboard/views/detail_news.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/entertainment_response.dart';
import '../../../data/headline_response.dart';
import '../../../data/sports_response.dart';
import '../../../data/technology_response.dart';
import '../../home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();
    // Mendefinisikan sebuah widget bernama build dengan tipe StatelessWidget yang memerlukan BuildContext.
    return SafeArea(
      // Widget SafeArea menempatkan semua konten widget ke dalam area yang aman (safe area) dari layar.
      child: DefaultTabController(
        length: 5,
        // Widget DefaultTabController digunakan untuk mengatur tab di aplikasi.
        child: Scaffold(
          // Widget Scaffold digunakan sebagai struktur dasar aplikasi.
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await auth.erase();
              Get.offAll(() => HomeView());
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.logout_rounded),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            // Widget PreferredSize digunakan untuk menyesuaikan tinggi appBar.
            child: Column(
              // Widget Column adalah widget yang menyatukan widget-childnya secara vertikal.
              children: [
                ListTile(
                  leading: Text(
                    'NEWS',
                    style: GoogleFonts.smokum(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                    ),
                  ),
                  // Widget ListTile digunakan untuk menampilkan tampilan list sederhana.
                  title: const Text(
                    "Hallo!",
                    textAlign: TextAlign.end,
                    // Properti textAlign digunakan untuk menentukan perataan teks.
                  ),
                  subtitle: Text(
                    auth.read('full_name').toString(),
                    textAlign: TextAlign.end,
                  ),
                  trailing: Container(
                    // Widget Container digunakan untuk mengatur tampilan konten dalam kotak.
                    margin: const EdgeInsets.only(right: 10),
                    // Properti margin digunakan untuk menentukan jarak dari tepi kontainer ke tepi widget yang di dalamnya.
                    width: 50.0,
                    height: 50.0,
                    child: Lottie.network(
                      // Widget Lottie.network digunakan untuk menampilkan animasi Lottie dari suatu URL.
                      'https://assets10.lottiefiles.com/packages/lf20_8pL7DHZXvo.json',
                      fit: BoxFit.cover,
                      // Properti fit digunakan untuk menyesuaikan ukuran konten agar sesuai dengan kontainer.
                    ),
                  ),
                ),
                const Align(
                  // Widget Align digunakan untuk menempatkan widget pada posisi tertentu di dalam widget induk.
                  alignment: Alignment.topLeft,
                  // Properti alignment digunakan untuk menentukan letak widget di dalam widget induk.
                  child: TabBar(
                    // Widget TabBar digunakan untuk menampilkan tab di aplikasi.
                    labelColor: Colors.black,
                    // Properti labelColor digunakan untuk menentukan warna teks tab yang dipilih.
                    indicatorSize: TabBarIndicatorSize.label,
                    // Properti indicatorSize digunakan untuk menentukan ukuran indikator tab yang dipilih.
                    isScrollable: true,
                    // Properti isScrollable digunakan untuk menentukan apakah tab dapat di-scroll atau tidak.
                    indicatorColor: Colors.white,
                    // Properti indicatorColor digunakan untuk menentukan warna indikator tab yang dipilih.
                    tabs: [
                      // Properti tabs digunakan untuk menentukan teks yang akan ditampilkan pada masing-masing tab.
                      Tab(text: "Headline"),
                      Tab(text: "Teknologi"),
                      Tab(text: "Olahraga"),
                      Tab(text: "Hiburan"),
                      Tab(text: "Profile"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            // Widget TabBarView digunakan untuk menampilkan konten yang terkait dengan masing-masing tab.
            children: [
              // Properti children digunakan untuk menentukan konten yang akan ditampilkan pada masing-masing tab.
              headline(controller, scrollController),
              technology(controller, scrollController),
              sports(controller, scrollController),
              entertainment(controller, scrollController),
              profile(),
            ],
          ),
        ),
      ),
    );
  }

  Center profile() {
    final auth = GetStorage();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: HexColor('#feeee8'),
              child: Lottie.network(
                "https://assets10.lottiefiles.com/packages/lf20_8pL7DHZXvo.json",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                auth.read('full_name').toString(),
                style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 14),
              child: Text(
                'Developer',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: FloatingActionButton(
                    onPressed: () =>
                        launch('https://facebook.com/Gerd%20Young'),
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: FloatingActionButton(
                    onPressed: () =>
                        launch('https://github.com/GeraAnggaraPutra'),
                    child: Icon(
                      FontAwesomeIcons.github,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: FloatingActionButton(
                    onPressed: () => launch('https://instagram.com/g_raap1'),
                    child: Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.purpleAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: FloatingActionButton(
                    onPressed: () => launch('https://twitter.com/bg_gd1'),
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blueAccent
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 13,
                    bottom: 10,
                  ),
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                Text(
                  "Hi, my name is Gera Anggara Putra. I am developer from Bandung, Indonesia. I like learning programming languages. I like to make applications using the Laravel framework, I'm also currently exploring React JS.",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://laravel.com/'),
                      child: Icon(
                        FontAwesomeIcons.laravel,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://getbootstrap.com/'),
                      child: Icon(
                        FontAwesomeIcons.bootstrap,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://reactjs.org/'),
                      child: Icon(
                        FontAwesomeIcons.react,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://html.com/'),
                      child: Icon(
                        FontAwesomeIcons.html5,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://www.w3.org/Style/CSS/'),
                      child: Icon(
                        FontAwesomeIcons.css3,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://www.php.net/'),
                      child: Icon(
                        FontAwesomeIcons.php,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: FloatingActionButton.small(
                      onPressed: () => launch('https://www.javascript.com/'),
                      child: Icon(
                        Icons.javascript,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(137, 226, 2, 2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<HeadlineResponse> headline(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<HeadlineResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getHeadline(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://assets6.lottiefiles.com/packages/lf20_x62chJ.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: InkWell(
                onTap: () {
                  Get.to(DetailNews(), arguments: snapshot.data!.data![index]);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          snapshot.data!.data![index].urlToImage.toString(),
                          height: 130,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                            Text(
                              snapshot.data!.data![index].title.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Author : ${snapshot.data!.data![index].author}'),
                                Text(
                                    'Sumber :${snapshot.data!.data![index].name}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<TechnologyResponse> technology(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<TechnologyResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getTechnology(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: InkWell(
                onTap: () {
                  Get.to(DetailNews(), arguments: snapshot.data!.data![index]);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Sumber :${snapshot.data!.data![index].name}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<EntertainmentResponse> entertainment(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<EntertainmentResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getEntertainment(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: InkWell(
                onTap: () {
                  Get.to(DetailNews(), arguments: snapshot.data!.data![index]);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Sumber :${snapshot.data!.data![index].name}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<SportsResponse> sports(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<SportsResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getSports(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: InkWell(
                onTap: () {
                  Get.to(DetailNews(), arguments: snapshot.data!.data![index]);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Sumber :${snapshot.data!.data![index].name}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
