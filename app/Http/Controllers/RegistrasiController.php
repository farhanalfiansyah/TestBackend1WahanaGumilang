<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Model\Flag;
use App\Model\GroupFlagAngka;
use App\Model\GroupFlagText;
use App\Model\HasilDataLooger;
use App\Model\ItemPemeriksaan;
use App\Model\KategoriPemeriksaan;
use App\Model\NilaiRujukan;
use App\Model\PaketPemeriksaan;
use App\Model\PilihanHasil;
use App\Model\RPaketPemeriksaan;
use App\Model\SubKategoriPemeriksaan;
use App\Model\TItemPemeriksaan;
use App\Model\TPaketPemeriksaan;
use App\Model\TRegistrasi;
use Illuminate\Support\Facades\Validator;

class RegistrasiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public $total = 407;
    public function index()
    {
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->json()->all(), TRegistrasi::$rules);
        if ($validator->fails()) {
            return response()->json($validator->errors());
        }else{
            $req = $request->json()->all();
            $data = $req['data'];
            $page_size = count($data);
            foreach ($data as $key) {
                $jumlah = count($key);            
                if (isset($key['registrasi'])) {
                    $no_lab = $key['registrasi']['no_lab'];
                    $id_pemeriksaan = $key['registrasi']['id'];
                    $t_registrasi = [
                        'id' => $key['registrasi']['id'],
                        'no_lab' => $key['registrasi']['no_lab'],
                        'no_reg_rs' => $key['registrasi']['no_reg_rs'],
                        'diagnosa_awal' => $key['registrasi']['diagnosa_awal'],
                        'keterangan_klinis' => $key['registrasi']['keterangan_klinis'],
                        'expertise' => $key['registrasi']['expertise'],
                        'waktu_expertise' => $key['registrasi']['waktu_expertise'],
                        'status_terbit' => $key['registrasi']['status_terbit'],
                        'waktu_terbit' => $key['registrasi']['waktu_terbit'],
                        'status_registrasi' => $key['registrasi']['status_registrasi'],
                        'waktu_registrasi' => $key['registrasi']['waktu_registrasi'],
                        'total_bayar' => $key['registrasi']['total_bayar'],
                        'total_print' => $key['registrasi']['total_print']
                    ];
                }
                if (isset($key['pasien'])) {
                    $t_registrasi+=[
                        'pasien_no_rm' => $key['pasien']['no_rm'],
                        'pasien_nama' => $key['pasien']['nama'],
                        'pasien_jenis_kelamin' => $key['pasien']['jenis_kelamin'],
                        'pasien_tanggal_lahir' => $key['pasien']['tanggal_lahir'],
                        'pasien_alamat' => $key['pasien']['alamat'],
                        'pasien_no_telphone' => $key['pasien']['no_telphone'],
                        'pasien_umur_hari' => $key['pasien']['umur_hari'],
                        'pasien_umur_bulan' => $key['pasien']['umur_bulan'],
                        'pasien_umur_tahun' => $key['pasien']['umur_tahun']
                    ];
                }
                if (isset($key['dokter_pengirim'])) {
                    $t_registrasi+=[
                        'dokter_pengirim_nama' => $key['dokter_pengirim']['nama'],
                        'dokter_pengirim_kode' => $key['dokter_pengirim']['kode'],
                        'dokter_pengirim_alamat' => $key['dokter_pengirim']['alamat'],
                        'dokter_pengirim_no_telphone' => $key['dokter_pengirim']['no_telphone'],
                        'dokter_pengirim_spesialis_nama' => $key['dokter_pengirim']['spesialis_nama'],
                        'dokter_pengirim_spesialis_kode' => $key['dokter_pengirim']['spesialis_kode']
                    ];
                }
                if (isset($key['unit_asal'])) {
                    $t_registrasi +=[
                        'unit_asal_nama' => $key['unit_asal']['nama'],
                        'unit_asal_kode' => $key['unit_asal']['kode'],
                        'unit_asal_kelas' => $key['unit_asal']['kelas'],
                        'unit_asal_keterangan' => $key['unit_asal']['keterangan'],
                        'unit_asal_jenis_nama' => $key['unit_asal']['jenis_nama'],
                        'unit_asal_jenis_kode' => $key['unit_asal']['jenis_kode'],
                    ];
                }
                if (isset($key['penjamin'])) {
                    $t_registrasi +=[
                        'penjamin_nama' => $key['penjamin']['nama'],
                        'penjamin_kode' => $key['penjamin']['kode'],
                        'penjamin_jenis_nama' => $key['penjamin']['jenis_nama'],
                        'penjamin_jenis_kode' => $key['penjamin']['jenis_kode'],
                        'created' => date("Y-m-d H:i:s"),
                        'updated' => null
                    ];
                }
                if (isset($key['non_paket_pemeriksaans'])) {
                    
                    foreach ($key['non_paket_pemeriksaans'] as $value) {
                        $t_item_pemeriksaan = [
                            'id' => $value['id'],
                            'no_lab' => $no_lab,
                            'status_item_pemeriksaan' => $value['status_item_pemeriksaan'],
                            'waktu_pemeriksaan_di_isi' => $value['waktu_pemeriksaan_di_isi'],
                            'verifikasi' => $value['verifikasi'],
                            'waktu_verifikasi' => $value['waktu_verifikasi'],
                            'hasil_pemeriksaan' => $value['hasil_pemeriksaan'],
                            'keterangan' => $value['keterangan'],
                            'nilai_rujukan_tampilan_nilai_rujukan' => $value['tampilan_nilai_rujukan'],
                            'is_rekomendasi_nilai_rujukan' => $value['is_rekomendasi_nilai_rujukan'],
                            'item_pemeriksaan_kode' => $value['kode'],
                            'item_pemeriksaan_nama' => $value['nama'],
                            'item_pemeriksaan_satuan' => $value['satuan'],
                            'item_pemeriksaan_metode' => $value['metode'],
                            'item_pemeriksaan_no_urut' => $value['no_urut'],
                            'item_pemeriksaan_jenis_input' => $value['jenis_input'],
                            'item_pemeriksaan_harga' => $value['harga'],
                            'item_pemeriksaan_is_tampilkan_waktu_periksa' => $value['is_tampilkan_waktu_periksa'],
                            'item_pemeriksaan_is_flag_nilai_rujukan' => $value['is_flag_nilai_rujukan'],
                            'item_pemeriksaan_is_flag_nilai_kritis' => $value['is_flag_nilai_kritis'],
                            'kategori_pemeriksaan_nama' => $value['kategori_pemeriksaan']['nama'],
                            'kategori_pemeriksaan_kode' => $value['kategori_pemeriksaan']['kode'],
                            'kategori_pemeriksaan_no_urut' => $value['kategori_pemeriksaan']['no_urut'],
                            'sub_kategori_pemeriksaan_nama' => $value['sub_kategori_pemeriksaan']['nama'],
                            'sub_kategori_pemeriksaan_kode' => $value['sub_kategori_pemeriksaan']['kode'],
                            'sub_kategori_pemeriksaan_no_urut' => $value['sub_kategori_pemeriksaan']['no_urut'],
                            'flag_nama' => $value['flag']['nama'],
                            'flag_kode' => $value['flag']['kode'],
                            'flag_warna' => $value['flag']['warna'],
                            'flag_jenis_pewarnaan' => $value['flag']['jenis_pewarnaan'],
                            't_registrasi_id_as_non_paket_pemeriksaan_id' => $id_pemeriksaan,
                            't_registrasi_id' => $id_pemeriksaan,
                            'created' => date("Y-m-d H:i:s"),
                            'updated' => null
                        ];
                    }
                }
                if ($jumlah==7) {
                    $insert_t_registrasi = TRegistrasi::create($t_registrasi);
                    $insert_t_item_pemeriksaan = TItemPemeriksaan::create($t_item_pemeriksaan);
                    $success = true;
                }
                $properties = json_encode([
                    "page" => $page_size-1,
                    'total' => $this->total,
                    'page_size' => $page_size
                ]);
                $this->total++;
            }
            if ($success) {
                return response()->json([
                    "success" => true,
                    "message" => "tambah spesialis berhasil",
                    "properties" => [
                        "page" => $page_size-1,
                        'total' => $this->total,
                        'page_size' => $page_size
                    ],
                    'payload' => $data
                ]);
            }
            else {
                return response()->json([
                    "success" => false,
                    "message" => "Gagal menambah spesialis",
                    "properties" => null,
                    "payload" => $data
                ]);
            }
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
