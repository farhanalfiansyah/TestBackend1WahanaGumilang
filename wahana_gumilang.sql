-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Sep 2020 pada 03.16
-- Versi server: 10.4.13-MariaDB
-- Versi PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wahana_gumilang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_flag`
--

CREATE TABLE `m_flag` (
  `id` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `warna` varchar(45) NOT NULL,
  `jenis_pewarnaan` varchar(45) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `m_flag`
--

INSERT INTO `m_flag` (`id`, `kode`, `nama`, `warna`, `jenis_pewarnaan`, `status`, `created`, `updated`) VALUES
(1, 'E12', 'Alfin', 'Merah', 'extrak', 1, '2020-09-06 20:00:21', '2020-09-06 20:00:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_group_flag_angka`
--

CREATE TABLE `m_group_flag_angka` (
  `id` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `m_flag_id_nilai_rujukan_bawah` int(11) NOT NULL,
  `m_flag_id_nilai_rujukan_atas` int(11) NOT NULL,
  `m_flag_id_normal` int(11) NOT NULL,
  `m_flag_id_nilai_kritis_bawah` int(11) NOT NULL,
  `m_flag_id_nilai_kritis_atas` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_group_flag_text`
--

CREATE TABLE `m_group_flag_text` (
  `id` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `m_flag_id_normal` int(11) NOT NULL,
  `m_flag_id_tidak_normal` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_item_pemeriksaan`
--

CREATE TABLE `m_item_pemeriksaan` (
  `id` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `satuan` varchar(45) NOT NULL,
  `metode` varchar(45) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `jenis_input` varchar(1) NOT NULL,
  `format_hasil_cetak` varchar(45) NOT NULL,
  `is_tampilkan_waktu_periksa` tinyint(4) NOT NULL,
  `is_flag_nilai_rujukan` tinyint(4) NOT NULL,
  `is_flag_nilai_kritis` tinyint(4) NOT NULL,
  `harga` bigint(20) NOT NULL,
  `status` int(11) NOT NULL,
  `m_kategori_pemeriksaan_id` int(11) NOT NULL,
  `m_sub_kategori_pemeriksaan_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_kategori_pemeriksaan`
--

CREATE TABLE `m_kategori_pemeriksaan` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_nilai_rujukan`
--

CREATE TABLE `m_nilai_rujukan` (
  `id` int(11) NOT NULL,
  `tampilan_nilai_rujukan` varchar(45) NOT NULL,
  `jenis_rule` varchar(1) NOT NULL,
  `m_item_pemeriksaan_id` int(11) NOT NULL,
  `rule_batas_umur_atas_tahun` int(11) NOT NULL,
  `rule_batas_umur_atas_bulan` int(11) NOT NULL,
  `rule_batas_umur_atas_hari` int(11) NOT NULL,
  `rule_batas_umur_bawah_tahun` int(11) NOT NULL,
  `rule_batas_umur_bawah_bulan` int(11) NOT NULL,
  `rule_batas_umur_bawah_hari` int(11) NOT NULL,
  `rule_jenis_kelamin` varchar(1) NOT NULL,
  `rule_nilai_angka_rujukan_bawah` double NOT NULL,
  `rule_nilai_angka_rujukan_atas` double NOT NULL,
  `rule_nilai_angka_kritis_atas` double NOT NULL,
  `rule_nilai_angka_kritis_bawah` double NOT NULL,
  `rule_nilai_text_nilai_rujukan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`rule_nilai_text_nilai_rujukan`)),
  `m_group_flag_angka_id` int(11) NOT NULL,
  `m_group_flag_text_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_paket_pemeriksaan`
--

CREATE TABLE `m_paket_pemeriksaan` (
  `id` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `harga` bigint(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_pilihan_hasil`
--

CREATE TABLE `m_pilihan_hasil` (
  `id` int(11) NOT NULL,
  `nilai` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`nilai`)),
  `m_item_pemeriksaan_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_r_paket_pemeriksaan`
--

CREATE TABLE `m_r_paket_pemeriksaan` (
  `id` int(11) NOT NULL,
  `m_item_pemeriksaan_id` int(11) NOT NULL,
  `m_paket_pemeriksaan_id` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT current_timestamp(),
  `updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_sub_kategori_pemeriksaan`
--

CREATE TABLE `m_sub_kategori_pemeriksaan` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `m_kategori_pemeriksaan_id` int(11) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_hasil_data_looger`
--

CREATE TABLE `t_hasil_data_looger` (
  `id` int(11) NOT NULL,
  `no_lab` varchar(45) NOT NULL,
  `waktu_dataloger` datetime NOT NULL,
  `waktu_diterima` datetime NOT NULL,
  `hasil_pemeriksaan` varchar(45) NOT NULL,
  `merk` varchar(45) NOT NULL,
  `t_item_pemeriksaan_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_item_pemeriksaan`
--

CREATE TABLE `t_item_pemeriksaan` (
  `id` int(11) NOT NULL,
  `no_lab` varchar(45) NOT NULL,
  `status_item_pemeriksaan` int(11) NOT NULL,
  `waktu_pemeriksaan_di_isi` datetime DEFAULT NULL,
  `verifikasi` tinyint(4) NOT NULL,
  `waktu_verifikasi` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hasil_pemeriksaan` varchar(500) DEFAULT NULL,
  `keterangan` varchar(45) DEFAULT NULL,
  `nilai_rujukan_tampilan_nilai_rujukan` varchar(100) NOT NULL,
  `is_duplo` tinyint(4) DEFAULT NULL,
  `is_rekomendasi_nilai_rujukan` tinyint(4) NOT NULL,
  `item_pemeriksaan_kode` varchar(45) NOT NULL,
  `item_pemeriksaan_nama` varchar(45) NOT NULL,
  `item_pemeriksaan_satuan` varchar(45) NOT NULL,
  `item_pemeriksaan_metode` varchar(45) NOT NULL,
  `item_pemeriksaan_no_urut` int(11) NOT NULL,
  `item_pemeriksaan_jenis_input` varchar(1) NOT NULL,
  `item_pemeriksaan_harga` bigint(20) NOT NULL,
  `item_pemeriksaan_is_tampilkan_waktu_periksa` tinyint(4) NOT NULL,
  `item_pemeriksaan_is_flag_nilai_rujukan` tinyint(4) NOT NULL,
  `item_pemeriksaan_is_flag_nilai_kritis` tinyint(4) NOT NULL,
  `kategori_pemeriksaan_nama` varchar(45) NOT NULL,
  `kategori_pemeriksaan_kode` varchar(45) NOT NULL,
  `kategori_pemeriksaan_no_urut` int(11) NOT NULL,
  `sub_kategori_pemeriksaan_nama` varchar(45) DEFAULT NULL,
  `sub_kategori_pemeriksaan_kode` varchar(45) DEFAULT NULL,
  `sub_kategori_pemeriksaan_no_urut` int(11) DEFAULT NULL,
  `flag_nama` varchar(45) DEFAULT NULL,
  `flag_kode` varchar(45) DEFAULT NULL,
  `flag_warna` varchar(45) DEFAULT NULL,
  `flag_jenis_pewarnaan` varchar(45) DEFAULT NULL,
  `m_item_periksaan_id` int(11) DEFAULT NULL,
  `t_registrasi_id` int(11) NOT NULL,
  `t_paket_pemeriksaan_id` int(11) DEFAULT NULL,
  `t_registrasi_id_as_non_paket_pemeriksaan_id` int(11) NOT NULL,
  `m_nilai_rujukan_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_paket_pemeriksaan`
--

CREATE TABLE `t_paket_pemeriksaan` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kode` varchar(45) NOT NULL,
  `no_lab` varchar(45) NOT NULL,
  `harga` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `t_registrasi_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_registrasi`
--

CREATE TABLE `t_registrasi` (
  `id` int(11) NOT NULL,
  `no_lab` varchar(45) NOT NULL,
  `no_reg_rs` varchar(45) NOT NULL,
  `diagnosa_awal` text NOT NULL,
  `keterangan_klinis` text NOT NULL,
  `keterangan_hasil` text DEFAULT NULL,
  `expertise` varchar(500) DEFAULT NULL,
  `waktu_expertise` datetime DEFAULT NULL,
  `status_terbit` int(11) NOT NULL,
  `waktu_terbit` datetime DEFAULT NULL,
  `status_registrasi` int(11) NOT NULL,
  `waktu_registrasi` datetime NOT NULL,
  `total_bayar` bigint(20) NOT NULL,
  `total_print` int(11) NOT NULL,
  `pasien_no_rm` varchar(45) NOT NULL,
  `pasien_nama` varchar(150) NOT NULL,
  `pasien_jenis_kelamin` varchar(1) NOT NULL,
  `pasien_tanggal_lahir` date NOT NULL,
  `pasien_alamat` varchar(100) NOT NULL,
  `pasien_no_telphone` varchar(15) NOT NULL,
  `pasien_umur_hari` int(11) NOT NULL,
  `pasien_umur_bulan` int(11) NOT NULL,
  `pasien_umur_tahun` int(11) NOT NULL,
  `dokter_pengirim_nama` varchar(100) DEFAULT NULL,
  `dokter_pengirim_kode` varchar(50) DEFAULT NULL,
  `dokter_pengirim_alamat` varchar(200) DEFAULT NULL,
  `dokter_pengirim_no_telphone` varchar(15) DEFAULT NULL,
  `dokter_pengirim_spesialis_nama` varchar(200) DEFAULT NULL,
  `dokter_pengirim_spesialis_kode` varchar(45) DEFAULT NULL,
  `unit_asal_nama` varchar(200) DEFAULT NULL,
  `unit_asal_kode` varchar(50) DEFAULT NULL,
  `unit_asal_kelas` varchar(45) DEFAULT NULL,
  `unit_asal_keterangan` varchar(45) DEFAULT NULL,
  `unit_asal_jenis_nama` varchar(45) DEFAULT NULL,
  `unit_asal_jenis_kode` varchar(45) DEFAULT NULL,
  `penjamin_nama` varchar(45) DEFAULT NULL,
  `penjamin_kode` varchar(45) DEFAULT NULL,
  `penjamin_jenis_nama` varchar(200) DEFAULT NULL,
  `penjamin_jenis_kode` varchar(45) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `m_flag`
--
ALTER TABLE `m_flag`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_group_flag_angka`
--
ALTER TABLE `m_group_flag_angka`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_flag_id_nilai_rujukan_bawah` (`m_flag_id_nilai_rujukan_bawah`),
  ADD KEY `m_flag_id_nilai_rujukan_atas` (`m_flag_id_nilai_rujukan_atas`),
  ADD KEY `m_flag_id_normal` (`m_flag_id_normal`),
  ADD KEY `m_flag_id_nilai_kritis_bawah` (`m_flag_id_nilai_kritis_bawah`),
  ADD KEY `m_flag_id_nilai_kritis_atas` (`m_flag_id_nilai_kritis_atas`);

--
-- Indeks untuk tabel `m_group_flag_text`
--
ALTER TABLE `m_group_flag_text`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_flag_id_normal` (`m_flag_id_normal`),
  ADD KEY `m_flag_id_tidak_normal` (`m_flag_id_tidak_normal`);

--
-- Indeks untuk tabel `m_item_pemeriksaan`
--
ALTER TABLE `m_item_pemeriksaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_kategori_pemeriksaan_id` (`m_kategori_pemeriksaan_id`),
  ADD KEY `m_sub_kategori_pemeriksaan_id` (`m_sub_kategori_pemeriksaan_id`);

--
-- Indeks untuk tabel `m_kategori_pemeriksaan`
--
ALTER TABLE `m_kategori_pemeriksaan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_nilai_rujukan`
--
ALTER TABLE `m_nilai_rujukan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_item_pemeriksaan_id` (`m_item_pemeriksaan_id`),
  ADD KEY `m_group_flag_angka_id` (`m_group_flag_angka_id`),
  ADD KEY `m_group_flag_text_id` (`m_group_flag_text_id`);

--
-- Indeks untuk tabel `m_paket_pemeriksaan`
--
ALTER TABLE `m_paket_pemeriksaan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_pilihan_hasil`
--
ALTER TABLE `m_pilihan_hasil`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_item_pemeriksaan_id` (`m_item_pemeriksaan_id`);

--
-- Indeks untuk tabel `m_r_paket_pemeriksaan`
--
ALTER TABLE `m_r_paket_pemeriksaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_item_pemeriksaan_id` (`m_item_pemeriksaan_id`),
  ADD KEY `m_paket_pemeriksaan_id` (`m_paket_pemeriksaan_id`);

--
-- Indeks untuk tabel `m_sub_kategori_pemeriksaan`
--
ALTER TABLE `m_sub_kategori_pemeriksaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_kategori_pemeriksaan_id` (`m_kategori_pemeriksaan_id`);

--
-- Indeks untuk tabel `t_hasil_data_looger`
--
ALTER TABLE `t_hasil_data_looger`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_item_pemeriksaan_id` (`t_item_pemeriksaan_id`);

--
-- Indeks untuk tabel `t_item_pemeriksaan`
--
ALTER TABLE `t_item_pemeriksaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `m_item_periksaan_id` (`m_item_periksaan_id`),
  ADD KEY `t_registrasi_id` (`t_registrasi_id`),
  ADD KEY `t_paket_pemeriksaan_id` (`t_paket_pemeriksaan_id`),
  ADD KEY `m_nilai_rujukan_id` (`m_nilai_rujukan_id`);

--
-- Indeks untuk tabel `t_paket_pemeriksaan`
--
ALTER TABLE `t_paket_pemeriksaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_registrasi_id` (`t_registrasi_id`);

--
-- Indeks untuk tabel `t_registrasi`
--
ALTER TABLE `t_registrasi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `m_kategori_pemeriksaan`
--
ALTER TABLE `m_kategori_pemeriksaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `m_group_flag_angka`
--
ALTER TABLE `m_group_flag_angka`
  ADD CONSTRAINT `fk_m_flag_id_nilai_kritis_atas` FOREIGN KEY (`m_flag_id_nilai_kritis_atas`) REFERENCES `m_flag` (`id`),
  ADD CONSTRAINT `fk_m_flag_id_nilai_kritis_bawah` FOREIGN KEY (`m_flag_id_nilai_kritis_bawah`) REFERENCES `m_flag` (`id`),
  ADD CONSTRAINT `fk_m_flag_id_nilai_rujukan_atas` FOREIGN KEY (`m_flag_id_nilai_rujukan_atas`) REFERENCES `m_flag` (`id`),
  ADD CONSTRAINT `fk_m_flag_id_nilai_rujukan_bawah` FOREIGN KEY (`m_flag_id_nilai_rujukan_bawah`) REFERENCES `m_flag` (`id`),
  ADD CONSTRAINT `fk_m_flag_id_normal` FOREIGN KEY (`m_flag_id_normal`) REFERENCES `m_flag` (`id`);

--
-- Ketidakleluasaan untuk tabel `m_group_flag_text`
--
ALTER TABLE `m_group_flag_text`
  ADD CONSTRAINT `fk_m_flag_id_normal_flag_text` FOREIGN KEY (`m_flag_id_normal`) REFERENCES `m_flag` (`id`),
  ADD CONSTRAINT `fk_m_flag_id_tidak_normal` FOREIGN KEY (`m_flag_id_tidak_normal`) REFERENCES `m_flag` (`id`);

--
-- Ketidakleluasaan untuk tabel `m_item_pemeriksaan`
--
ALTER TABLE `m_item_pemeriksaan`
  ADD CONSTRAINT `fk_m_kategori_pemeriksaan_id` FOREIGN KEY (`m_kategori_pemeriksaan_id`) REFERENCES `m_kategori_pemeriksaan` (`id`),
  ADD CONSTRAINT `fk_m_sub_kategori_pemeriksaan_id` FOREIGN KEY (`m_sub_kategori_pemeriksaan_id`) REFERENCES `m_sub_kategori_pemeriksaan` (`id`);

--
-- Ketidakleluasaan untuk tabel `m_pilihan_hasil`
--
ALTER TABLE `m_pilihan_hasil`
  ADD CONSTRAINT `fk_m_item_pemeriksaan_id` FOREIGN KEY (`m_item_pemeriksaan_id`) REFERENCES `m_item_pemeriksaan` (`id`);

--
-- Ketidakleluasaan untuk tabel `m_r_paket_pemeriksaan`
--
ALTER TABLE `m_r_paket_pemeriksaan`
  ADD CONSTRAINT `fk_m_item_pemeriksaan_id_m_r_paket` FOREIGN KEY (`m_item_pemeriksaan_id`) REFERENCES `m_item_pemeriksaan` (`id`),
  ADD CONSTRAINT `fk_m_paket_pemeriksaan_id` FOREIGN KEY (`m_paket_pemeriksaan_id`) REFERENCES `m_paket_pemeriksaan` (`id`);

--
-- Ketidakleluasaan untuk tabel `m_sub_kategori_pemeriksaan`
--
ALTER TABLE `m_sub_kategori_pemeriksaan`
  ADD CONSTRAINT `m_kategori_pemeriksaan_id` FOREIGN KEY (`m_kategori_pemeriksaan_id`) REFERENCES `m_kategori_pemeriksaan` (`id`);

--
-- Ketidakleluasaan untuk tabel `t_hasil_data_looger`
--
ALTER TABLE `t_hasil_data_looger`
  ADD CONSTRAINT `fk_t_item_pemeriksaan_id` FOREIGN KEY (`t_item_pemeriksaan_id`) REFERENCES `t_item_pemeriksaan` (`id`);

--
-- Ketidakleluasaan untuk tabel `t_item_pemeriksaan`
--
ALTER TABLE `t_item_pemeriksaan`
  ADD CONSTRAINT `fk_m_item_perksaan_id` FOREIGN KEY (`m_item_periksaan_id`) REFERENCES `m_item_pemeriksaan` (`id`),
  ADD CONSTRAINT `fk_m_nilai_rujukan_id` FOREIGN KEY (`m_nilai_rujukan_id`) REFERENCES `m_nilai_rujukan` (`id`),
  ADD CONSTRAINT `fk_t_paket_pemeriksaan_id` FOREIGN KEY (`t_paket_pemeriksaan_id`) REFERENCES `t_paket_pemeriksaan` (`id`),
  ADD CONSTRAINT `fk_t_registrasi_id` FOREIGN KEY (`t_registrasi_id`) REFERENCES `t_registrasi` (`id`);

--
-- Ketidakleluasaan untuk tabel `t_paket_pemeriksaan`
--
ALTER TABLE `t_paket_pemeriksaan`
  ADD CONSTRAINT `fk_t_registrasi_id_t_paket_pemeriksaan` FOREIGN KEY (`t_registrasi_id`) REFERENCES `t_registrasi` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
