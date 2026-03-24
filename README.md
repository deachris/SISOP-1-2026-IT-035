# SISOP-1-2026-IT-035

**Dikerjakan oleh: Dea Chrisna Butarbutar - 5027251035**

## Reporting

### Soal 1
**Argo Ngawi Jesgeges**

#### Penjelasan

Langkah pertama adalah memasukkan data penumpang ke dalam file `passenger.csv` yang sudah dibuat sebelumnya. 
```bash
$ wget -O passenger.csv "https://docs.google.com/spreadsheets/d/1NHmyS6wRO7To7ta-NLOOLHkPS6valvNaX7tawsv1zfE/export?format=csv&gid=0"
```
Maka, data penumpang sudah masuk ke dalam file *passenger.csv*

Untuk mengambil opsi antara a, b, c, d, dan e dari *awk -f KANJ.sh passenger.csv a/b/c/d/e*, maka perlu diambil dengan ARGV[2] untuk membaca opsinya. ARGV[2] adalah opsi a/b/c/d/e.

```bash
BEGIN {
FS = ","
opsi = ARGV[2]

if (opsi != "a" && opsi != "b" && opsi != "c" && opsi != "d" && opsi != "e") { 
print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
exit
}

ARGV[2] = "" # Agar tidak dianggap file
}
```

**Opsi a: Total Penumpang Kereta**

Untuk menghitung total penumpang di kereta, menjumlahkan semua baris di dalam file `passenger.csv`
```bash
NR > 1 {           # Tidak menghitung header
if (opsi == "a")
{count++}
```
**Opsi b: Jumlah Gerbong Kereta yang Beroperasi**

Jumlah gerbong yang beroperasi didapat dengan menghitung jumlah elemen yang berbeda di kolom ke-4 (nama gerbong). 
```bash
else if (opsi == "b"){
a[$4]}       # Mengambil setiap elemen yang berbeda di kolom ke-4
```
Kemudian di bagian END, jumlah dari setiap elemen yang berbeda dijumlahkan.
```bash
else if (opsi == "b")
{print "Jumlah gerbong penumpang KANJ adalah", length(a)}
```

**Opsi c: Penumpang dengan Usia Tertua di Kereta**

Cara menemukan penumpang tertua adalah dengan menemukan angka yang terbesar di kolom ke-2. 
```bash
else if (opsi == "c")
{if($2 > max) {max = $2; nama = $1}} # Angka yang lebih besar jika dibandingkan dengan angka saat ini adalah angka terbesar
END
{print nama, "adalah penumpang kereta tertua dengan usia", max}
```

**Opsi d: Rata-Rata Usia Penumpang (Pembulatan)**

Rata-rata usia penumpang dihitung dengan menjumlahkan seluruh angka di kolom ke-2, kemudian dibagi dengan jumlah barisnya. Untuk pembulatan ditambah dengan 0.5.
```bash
else if (opsi == "d")
{jumlah+=$2; count++}
END {
print "Rata-rata usia penumpang adalah", int(jumlah/count+0.5), "tahun"}
```

**Opsi e: Jumlah Penumpang Business Class**

Banyak penumpang di Business Class dihitung dengan menjumlahkan kata yang mengandung kata "Business" di kolom ke-3.
```bash
else if (opsi == "e"){
if ($3 == "Business") {count++}
END {
print "Jumlah penumpang business class ada", count, "orang"}
```

### Output
**Opsi a: Total Penumpang di Kereta**
<img width="909" height="79" alt="image" src="https://github.com/user-attachments/assets/bd220f2a-8e3d-43e9-8f22-0ec020a22d86" />

**Opsi b: Jumlah Gerbong Kereta yang Beroperasi**
<img width="908" height="84" alt="image" src="https://github.com/user-attachments/assets/d81a61b8-0702-47f3-b0f1-3fde8e1f5782" />

**Opsi c: Penumpang dengan Usia Tertua di Kereta**
<img width="909" height="80" alt="image" src="https://github.com/user-attachments/assets/d16e2c87-e6f8-4c31-ae1c-cd542e2e76be" />

**Opsi d: Rata-Rata Usia Penumpang**
<img width="896" height="78" alt="image" src="https://github.com/user-attachments/assets/1fef6d91-7bc0-410a-921e-f52adb3c8cea" />

**Opsi e: Jumlah Penumpang Business Class**
<img width="904" height="82" alt="image" src="https://github.com/user-attachments/assets/caee184e-c707-4920-83a3-40c37a6efd01" />

**Opsi selain a, b, c, d, dan e**
<img width="900" height="78" alt="image" src="https://github.com/user-attachments/assets/e4f9a9dc-d513-4b69-bb71-6af07c342e07" />

**Beberapa Isi File `passenger.csv`**
<img width="905" height="774" alt="image" src="https://github.com/user-attachments/assets/6c35908f-fe31-400a-8f18-4fde573013e9" />

### Soal 2
**Ekspedisi Pesugihan Gunung Kawi**

#### Penjelasan

**1. Langkah pertama: Mencari file yang dibutuhkan.**

a. Download File Gdrive `peta-ekspedisi-amba.pdf` dan simpan ke folder `ekspedisi`
```bash
$ gdown -O ekspedisi/peta-ekspedisi-amba.pdf https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q
```

b. Masuk ke folder `ekspedisi` dan membuka file `peta-ekspedisi-amba.pdf` secara concatonate
```bash
$ cd ekspedisi
$ cat peta-ekspedisi-amba.pdf
```

c. Install tautan di dalam file `peta-ekspedisi-amba.pdf` paling bawah dengan menggunakan Git
```bash
$ git clone https://github.com/pocongcyber77/peta-gunung-kawi.git
```
Maka, di dalam file peta-gunung-kawi terdapat sebuah file `gsxtrack.json`
<img width="903" height="72" alt="image" src="https://github.com/user-attachments/assets/4baed59c-f7eb-4a93-ac7e-36fa47550a4e" />

**2. Mencari Titik Lokasi**

a. Membuat shell script dengan nama file `parserkoordinat.sh`

- Setelah masuk ke dalam file `peta-gunung-kawi`, kemudian membuat file `parserkoordinat.sh` untuk tempat shell script dan `titik-penting.txt` untuk tempat menyimpan hasilnya nanti.
```bash
$ mkdir parserkoordinat.sh
$ mkdir titik-penting.txt
```

- Membuat shell script untuk mengambil data `id`, `site_name`, `latitude`, dan `longitude` dari file `gsxtrack.json`.
```awk
awk -F'[:,]'   # Untuk mengambil data pada kolom yang dipisahkan dengan ":" dan ","
'/"id"/ {id=$2}    # Menjalankan perintah yang barisnya berisi "id" dan menyimpan kolom ke-2 ($2) ke variabel id 
/"site_name"/ {site_name=$2}
/"latitude"/ {latitude=$2}
/"longitude"/ {longitude=$2; print id "," site_name ","  latitude "," longitude}  # Membuat output yang dipisahkan dengan tanda koma
' gsxtrack.json | sed 's/[ "]*//g' >> titik-penting.txt # Diambil dari file gsxtrack.json
```
<img width="955" height="134" alt="image" src="https://github.com/user-attachments/assets/eb7ed486-fc97-4283-a620-89812a0baf5e" />

- Membuat program Shellscript `nemupusaka.sh` untuk menghitung titik tengah. Hasilnya dimasukkan ke file `posisipusaka.txt`
```bash
$ mkdir nemupusaka.sh
$ mkdir posisipusaka.txt
```

- Mencari titik pusat dari 4 titik yang sudah didapat dengan menggunakan rumus titik tengah persegi
Cara mencari titik pusatnya adalah dengan menggunakan `awk`, kolom ke-3 dari setiap baris dijumlahkan dan dimasukkan ke variabel `latitude`, begitu pula dengan `longitude` yang berada di kolom ke-4. Kemudian, barisnya dihitung menggunakan `count++`.
```awk
awk -F',' 'NR<=4 {latitude+=$3; longitude+=$4; count++}
```
Kemudian, outputnya adalah variabel `latitude` dan `longitude` dibagi dengan jumlah baris (count). 
```awk
END {print latitude/count "," longitude/count}' titik-penting.txt |
```
Untuk membacanya, isi yang dipisahkan oleh koma dimasukkan ke variabel `long` dan `lat` dan akan menghasilkan titik koordinat pusat. Hasilnya nanti dimasukkan ke file `posisipusaka.txt`.
```bash
while IFS=',' read long lat; do
echo "Koordinat pusat:
($long, $lat)" >> posisipusaka.txt
done
```
Hasilnya adalah sebagai berikut.
<img width="970" height="98" alt="image" src="https://github.com/user-attachments/assets/19092a10-7d17-4b6e-93c5-525502f7375b" />

### Soal 3

**Kos Slebew Ambatukam**

#### Penjelasan

- Membuat menu Sistem Manajemen Kost Slebew
Tampilan menu dimasukkan ke dalam variabel `menu` dan meminta input opsi menu dari user.
Menu akan terus ditampilkan sampai user memilih menu 7 (Keluar dari program).
```bash
menu="============================ SISTEM MANAJEMEN ============================
 _  ___  ___   ___  _____    ___   _     ____  ____   ____  _         _
| |/  / / _ \\ / __||_   _|  / __| | |   |  __||  _ \\ |  __|| |  ___  | |
| '  / / / \ \\\__ \  | |    \\__ \ | |   | |__ | |_) || |__ | | |   | | |
   𝓴      𝓸     𝓼     𝓽       𝓼    𝓵      𝓮      𝓫      𝓮       𝔀
| .  \\ \\ \\_/ / __) / | |     __) )| |__ | |__ | |_) || |__ \\ \\/ / \\ \\/ /
|_|\\__\\ \\___/ |___/  |_|    |___/ |____||____||_____/|____| \\__/   \\__/

==========================================================================
 ID | OPSI
--------------------------------------------------------------------------
 1 | Tambah Penghuni Baru
 2 | Hapus Penghuni
 3 | Tampilkan Daftar Penghuni
 4 | Update Status Penghuni
 5 | Cetak Laporan Keuangan
 6 | Kelola Cron (Pengingat Tagihan)
 7 | Exit Program
==========================================================================
Masukkan opsi menu [1-7]: "

opsi=""

until [ "$opsi" = "7" ]
do
echo "$menu"
read opsi
```

**Menu 1: Tambah Penghuni Baru**
Untuk membuat menu tambah penghuni, diperlukan beberapa fungsi untuk memeriksa kesesuaian input dari user.

- Untuk memeriksa apakah nomor kamar yang diinput sudah terisi oleh penghuni lain atau belum.
```bash
checkKamar() {
local tambahKamar="$1"
local cekKamar
local Nama

while IFS="|" read -r Nama cekKamar sewa masuk status
do
if [[ "$cekKamar" == "$tambahKamar" ]]
then
echo "Kamar $tambahKamar sudah terisi. Silakan pilih kamar lain!"
return 1
fi
done < "/home/ubuntu/SISOP-1-2026-IT-035/soal_3/data/penghuni.csv"
return 0
}
```
Dari kode di atas, terdapat variabel `local` yang hanya bisa diakses di fungsi tersebut. Kegunaannya adalah agar ketika menginput nomor kamar yang sama, variabel nama dan kamar tidak berubah menjadi kosong. 
Pertama, data dibaca dari file `penghuni.csv` dengan pemisah "|" dan dimasukkan ke dalam setiap variabel yang tertera. Jika nomor kamar sama dengan yang sudah ada di dalam data, maka harus memilih kamar yang lain. Jika berbeda, maka akan keluar dari loop.

- Untuk memeriksa harga sewa yang diinput adalah angka positif.
```bash
checkSewa() {
if [[ $sewa -le 1 ]]
then
echo "Harga sewa tidak valid!"
return 1
fi
return 0
}
```
Jika harga sewa yang diinput user kurang dari angka 1 (sewa < 1), maka harus input harga sewa sampai benar yaitu lebih dari 0 (angka positif). Jika sudah benar, maka akan keluar dari loop.

- Untuk memeriksa kesesuaian formal tanggal dan tanggal bukan di masa depan.
```bash
checkTanggal() {
if ! [[ $masuk =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
then
echo "Tanggal tidak valid! Format tanggal harus YYYY-MM-DD."
return 1
fi
```
Kode di atas berarti, jika input user bukan format YYYY-MM-DD, maka harus menginput format tanggal sampai benar.

```bash
today=$(date +%Y-%m-%d)
if [[ "$masuk" > "$today" ]]
then
echo "Tanggal tidak boleh melebihi hari ini. Silakan pilih tanggal hari ini/sebelumnya!"
return 1
fi
return 0
}
```
Kode di atas adalah untuk memeriksa tanggal yang diinput sudah melewati hari ini atau belum. 
Terdapat variabel `today` yang mengambil tanggal pada hari ini. Jika tanggal yang diinput melebihi tanggal hari ini, maka harus menginput kembali sesuai perintah.

- Untuk memeriksa status yang diinput oleh user, hanya bisa "Aktif" atau "Menunggak"
```bash
checkStatus() {
if ! [[ $status = "Aktif" || $status = "Menunggak" ]]
then
echo "Status tidak valid! Silakan pilih status Aktif atau Menunggak."
return 1
fi
return 0
}
```
Jika status yang diinput user selain dari "Aktif" dan "Menunggak", maka harus menginput ulang sampai status yang diinput antara "Aktif" atau "Menunggak". Jika sudah sesuai, maka akan keluar dari loop.

Kemudian, kode berikut adalah untuk menerima input data-data penghuni dan memanggil setiap fungsi pengecekan tadi. Setiap data memakai loop `while do`, yang mana jika fungsi yang dipanggil masih belum sesuai, penerimaan input akan terus ditampilkan.
```bash
case "$opsi" in
1)
echo "================================================"
echo "              TAMBAH PENGHUNI                   "
echo "================================================"
read -p "Masukkan nama: " nama

while true
do
read -p "Masukkan nomor kamar: " kamar
if checkKamar "$kamar"
then
break
fi
done

while true
do
read -p "Masukkan harga sewa: Rp" sewa
if checkSewa
then
break
fi
done

while true
do
read -p "Masukkan tanggal masuk (YYYY-MM-DD): " masuk
if checkTanggal
then
break
fi
done

while true
do
read -p "Masukkan status awal (Aktif/Menunggak): " status
if checkStatus
then
break
fi
done
```

Selanjutnya, kode berikut adalah untuk memasukkan setiap variabel yang dipisahkan dengan tanda "|" ke dalam file `penghuni.csv` dan memberikan informasi bahwa penghuni berhasil ditambahkan.
```bash
echo "$nama|$kamar|$sewa|$masuk|$status" >> data/penghuni.csv
echo ""
echo "[✔] Penghuni $nama berhasil ditambahkan ke kamar $kamar dengan status $status."

read -p "Tekan [Enter] untuk kembali ke menu."
;;
```
Untuk kembali ke menu utama, cukup tekan Enter dan tampilan akan menunjukkan menu kembali.

**Menu 2: Hapus Penghuni**

Untuk menghapus penghuni, perlu untuk menginput nama penghuni yang datanya ingin dihapus.
Kemudian, dengan memakai `sed`, awal baris yang berisi nama yang diinput akan dihapus.
Untuk tanggal penghapusan adalah dengan mengambil tanggal hari ini. Kemudian, data dari penghuni yang telah dihapus termasuk tanggal penghapusan yang diletakkan di kolom terakhir, disimpan ke dalam file `sampah/history_hapus.csv`.
```bash
2)
echo "================================================"
echo "                HAPUS PENGHUNI                  "
echo "================================================"
read -p "Masukkan nama penghuni yang ingin dihapus: " nama
sed -i "/^$nama|/d" data/penghuni.csv
tgl_hapus=$(date +%d-%m-%Y)
echo "$nama|$kamar|$sewa|$masuk|$status|$tgl_hapus" >> sampah/history_hapus.csv
echo ""
echo "[✔] Data penghuni "$nama" berhasil diarsipkan ke sampah/history_hapus.csv dan dihapus dari sistem."
read -p "Tekan [Enter] untuk kembali ke menu."
;;
```

**Menu 3: Tampilkan Daftar Penghuni**

Untuk menghitung jumlah penghuni yang statusnya aktif atau menunggak dan jumlah penghuni, perlu untuk menginisialisasi variabel aktif, menunggak, dan count = 0. 
Jika datanya lengkap (> 1 kolom), maka akan menampilkan daftar penghuni kost. Kemudian, `ada==0` digunakan agar header ditampilkan sekali saja. Jika datanya belum ada (< 1 kolom), maka akan menampilkan informasi, "Belum ada data penghuni yang terdaftar." Untuk data penghuni ini, diambil dari file `penghuni.csv`.
```bash
3)
awk -F"|" '
BEGIN {
aktif=0; nunggak=0; count=0; ada=0
}
{
if (NF>1){
if (ada==0) {
printf "=========================================================================\n"
printf "                       DAFTAR PENGHUNI KOST SLEBEW                       \n"
printf "=========================================================================\n"
printf " %-3s | %-10s | %-10s | %-10s | %-13s | %-13s\n", "No", "Nama","No. Kamar", "Harga Sewa", "Tanggal Masuk","Status"
printf "-------------------------------------------------------------------------\n"
ada=1
}
printf " %-3d | %-10s | %-10s | Rp%-10s | %-13s | %-13s\n", NR, $1, $2, $3, $4, $5
count++

if ($5=="Aktif") {aktif++}
if ($5=="Menunggak") {nunggak++}
}
}
END {
if (ada==1) {
printf "-------------------------------------------------------------------------\n"
printf "Total: %d penghuni | Aktif: %d | Menunggak: %d\n", count, aktif, nunggak
printf "=========================================================================\n"
} else {
printf "\nBelum ada data penghuni yang terdaftar.\n"
}
}
' data/penghuni.csv
read -p "Tekan [Enter] untuk kembali ke menu."
;;
```

**Menu 4: Update Status**

Update status berarti, mengubah status "Aktif" menjadi "Menunggak", ataupun sebaliknya.
Pertama, nama penghuni yang statusnya ingin diupdate diinput oleh user. Kemudian, input status tersebut dicek kesesuaiannya dengan fungsi `checkStatus()`. Jika sudah benar, maka status baru akan disimpan ke dalam file `penghuni.csv`.
```bash
4)
echo "========================================================="
echo "                  UPDATE STATUS TAGIHAN                  "
echo "========================================================="
read -p "Masukkan nama penghuni: " nama

while true
do
read -p "Masukkan status baru (Aktif/Menunggak): " status
if checkStatus
then
awk -F"|" -v nama="$nama" -v status_baru="$status" '
BEGIN { OFS="|" }

$1 == nama { $5 = status_baru }

{ print }
' data/penghuni.csv > tmp && mv tmp data/penghuni.csv
echo ""
echo "[✔] Status $nama berhasil diubah menjadi: $status."
break
fi
done
echo ""
read -p "Tekan [Enter] untuk kembali ke menu."
;;
```

**Menu 5: Laporan Keuangan Kost Slebew**

Untuk membuat laporan keuangan, diperlukan variabel untuk menghitung jumlah total status yang aktif dan menunggak, yaitu dengan menjumlahkan kolom yang berisi kata "Aktif" atau "Menunggak". Laporan bulanan ini dimasukkan ke dalam file `laporan_bulanan.txt`. Laporan ini juga mencakup daftar siapa saja penghuni yang statusnya menunggak.
```bash
5)
echo ""
echo "========================================================="
echo "              LAPORAN KEUANGAN KOST SLEBEW               "
echo "========================================================="

total_aktif=$(awk -F"|" '$5=="Aktif" {sum += $3} END {print sum+0}' data/penghuni.csv)
total_nunggak=$(awk -F"|" '$5=="Menunggak" {sum += $3} END {print sum+0}' data/penghuni.csv)
count=$(awk 'END {print NR}' data/penghuni.csv)
echo "============ LAPORAN BULANAN KOST SLEBEW ============
 Total pemasukan (Aktif) : $total_aktif
 Total tunggakan         : $total_nunggak
 Jumlah penghuni         : $count
=====================================================" >> rekap/laporan_bulanan.txt
printf " Total pemasukan (Aktif) : %d\n" "$total_aktif"
printf " Total tunggakan         : %d\n" "$total_nunggak"
printf " Jumlah penghuni         : %d\n" "$count"
echo  "---------------------------------------------------------"
printf " Daftar penghuni menunggak: \n"
awk -F"|" '
BEGIN {
ada=0
no=1}

$5=="Menunggak" {
if (ada==0) {
printf " %-3s | %-8s | %-10s | %-13s\n", "No", "Nama","No. Kamar", "Tunggakan"
printf "---------------------------------------------------------\n"
ada=1
}
printf " %-3d | %-8s | %-10s | %-13s\n", no, $1, $2, $3, $4
((no++))
}

END {
if (ada==0) {
printf "Tidak ada penghuni yang menunggak.\n"
printf "=======================================================\n"
} else {
printf "--------------------------------------------------------\n"
}
}' data/penghuni.csv
echo ""
echo "[✔] Laporan berhasil disimpan ke rekap/laporan_bulanan.txt"
echo ""
read -p "Tekan [Enter] untuk kembali ke menu."
;;
```

**Menu 6: Menu Kelola Cron**
- Menu ini adalah menu khusus untuk pengingat harian bagi penghuni yang masih dalam status "Menunggak". Untuk membuatnya, pertama, menu kelola cron ditampilkan dengan menggunakan loop `while do`. Menu ini akan terus ditampilkan sampai user memilih menu 4 untuk kembali ke menu utama. 
```bash
kelolaCron() {
while true
do
echo "========================================================="
echo "                    MENU KELOLA CRON                     "
echo "========================================================="
echo " 1. Lihat Cron Job Aktif"
echo " 2. Daftarkan Cron Job Pengingat"
echo " 3. Hapus Cron Job Pengingat"
echo " 4. Kembali ke Menu Utama"
echo " ========================================================"
read -p "Pilih menu [1-4]: "  menuCron
```

- Menu 1 adalah menampilkan daftar cron job yang sudah dibuat. Di sini, meenggunakan perintah `crontab -l` untuk menampilkan daftar cron job. Jika cron job tidak ada, maka output akan dibuang ke sampah dan menampilkan informasi tidak ada cron job.
```bash
case "$menuCron" in
"1")
echo "========== DAFTAR CRON JOB PENGINGAT TAGIHAN =========="
crontab -l 2>/dev/null || echo "Tidak ada cron job."
echo ""
read -p "Tekan [Enter] untuk kembali ke Menu Kelola Cron."
;;
```

- Menu 2 adalah untuk menambah cron job pengingat tagihan. Pertama, user menginput jam, lalu menit. Kemudian, disimpan ke dalam daftar cron job.
```bash
"2")
read -p "Masukkan jam (00-23): " jam
read -p "Masukkan menit (00-59): " menit
echo "$menit $jam * * * /home/ubuntu/SISOP-1-2026-IT-035/soal_3/kost_slebew.sh --check-tagihan >> /home/ubuntu/SISOP-1-2026-IT-035/soal_3/log/tagihan.log" | crontab -
echo ""
echo "[✔] Cron job berhasil ditambahkan pada pukul $jam:$menit!"
echo ""
read -p "Tekan [Enter] untuk kembali ke Menu Kelola Cron."
;;
```

- Menu 3 adalah untuk menghapus cron job yang sudah dibuat sebelumnya, dengan menggunakan `crontab -r` yang berfungsi untuk menghapus cron job yang terdaftar.
```bash
"3")
crontab -r
echo ""
echo "[✔] Cron job pengingat tagihan berhasil dihapus!"
echo ""
read -p "Tekan [Enter] untuk kembali ke Menu Kelola Cron."
;;
```

- Menu 4 adalah keluar dari Menu Kelola Cron
```bash
"4")
echo "Keluar dari Menu Kelola Cron..."
break
;;
```

- Menu selain 1, 2, 3, dan 4, akan memberitahu bahwa menu tidak valid.
```bash
*)
echo "Menu tidak valid!"
;;
esac
done
}
```

- Untuk menjalankan fungsi checkTagihan
```bash
if [ "$1" = "--check-tagihan" ]
then
checkTagihan
exit 0
fi
```

- Fungsi checkTagihan adalah sebagai berikut. Fungsi ini untuk menampilkan pengingat tagihan pada waktu yang sudah didaftarkan oleh user sebelumnya. 
```bash
checkTagihan() {
while IFS="|" read -r nama kamar sewa masuk status
do
if [ "$status" = "Menunggak" ]
then
echo "[$(date +%Y-%m-%d) $(date +%H:%M:%S)] TAGIHAN: $nama (Kamar $kamar) - Menunggak Rp$sewa" >> "/home/ubuntu/SISOP-1-2026-IT-035/soal_3/log/tagihan.log"
echo ""
fi
done < "/home/ubuntu/SISOP-1-2026-IT-035/soal_3/data/penghuni.csv"
}
```

Untuk menjalankan menu 6:
```bash
6)
kelolaCron
;;
```

**Menu 7: Keluar dari Program**

Keluar dari program dilakukan dengan exit.
```bash
7)
echo "Keluar dari program..."
exit 0
;;
```

**Menu selain 1-7**

Jika input user selain menu 1-7, maka akan mencetak output "Opsi tidak valid!" dan menampilkan ulang menu utama dan input kembali.
```bash
*)
echo "Opsi tidak valid!" ;;
esac
done
```

### Output
**Tampilan Menu Utama**
<img width="854" height="504" alt="image" src="https://github.com/user-attachments/assets/8be7c20a-b45a-4ba6-94df-a8b1d56f927d" />

Menu 1: Tambah Penghuni Baru
<img width="865" height="291" alt="image" src="https://github.com/user-attachments/assets/dc7bb982-3a95-482a-a126-2bdefaf2edbc" />

- Jika nomor kamar sudah terisi, harga sewa < Rp1, tanggal dan status tidak sesuai:
<img width="861" height="516" alt="image" src="https://github.com/user-attachments/assets/f01af013-55a5-441e-9596-2d038fbd30de" />

Menu 2: Hapus Penghuni
<img width="959" height="205" alt="image" src="https://github.com/user-attachments/assets/88bd6e67-7536-42d2-a953-e7559f2a863d" />

Isi File `sampah/history_hapus.csv`
<img width="911" height="69" alt="image" src="https://github.com/user-attachments/assets/5bca22ec-b82b-446f-a9af-cc19c9d84ab7" />

Menu 3: Tampilkan Daftar Penghuni
<img width="956" height="272" alt="image" src="https://github.com/user-attachments/assets/aeeb1a04-a001-4187-b51e-407945b22f31" />

Menu 4: Update Status Penghuni
<img width="961" height="254" alt="image" src="https://github.com/user-attachments/assets/f4dcf6a6-34e6-451f-a91e-bc00096aa328" />

Menu 5: Cetak Laporan Keuangan
- Jika tidak ada penghuni yang menunggak:
<img width="954" height="381" alt="image" src="https://github.com/user-attachments/assets/54198194-2a5d-4ff8-8f91-dbbd46b23f63" />

- Jika ada penghuni yang menunggak:
<img width="963" height="427" alt="image" src="https://github.com/user-attachments/assets/83c097e7-d3a6-4639-874d-1e66b7fa4013" />

Isi File `rekap/laporan_bulanan.txt`
<img width="902" height="164" alt="image" src="https://github.com/user-attachments/assets/f178f748-9bf8-4e2b-9610-1c5b72d33188" />

Menu 6: Kelola Cron (Pengingat Tagihan)
- Tampilan Menu Kelola Cron
<img width="957" height="248" alt="image" src="https://github.com/user-attachments/assets/794b7f59-1019-4e8f-a2cb-3b73f8aba8dd" />

- Menu 1 Cron Job: Lihat Cron Job Aktif
<img width="788" height="160" alt="image" src="https://github.com/user-attachments/assets/d6ec806e-01a6-481d-acfc-c69b26194cd4" />

- Menu 2 Cron Job: Daftarkan Cron Job Pengingat
<img width="780" height="334" alt="image" src="https://github.com/user-attachments/assets/88d9d284-120d-44f2-a3f8-66db94f4611a" />

Ketika cron job ditambah lagi, cron job yang lama sudah otomatis terhapus.
<img width="782" height="160" alt="image" src="https://github.com/user-attachments/assets/12df5071-68c4-4379-be65-c0e45b0b9a45" />

Isi File 'log/tagihan.log`
<img width="919" height="51" alt="image" src="https://github.com/user-attachments/assets/bca1f523-40a0-4e6a-8c29-2c92e9fbebe5" />

- Menu 3 Cron Job: Hapus Cron Job Pengingat
<img width="916" height="293" alt="image" src="https://github.com/user-attachments/assets/9aae5f6b-20e1-440e-9183-bc0c173b099d" />

- Menu 4 Cron Job: Kembali ke Menu Utama
<img width="920" height="668" alt="image" src="https://github.com/user-attachments/assets/b731cf29-db24-4811-95ff-1807de5c2e4c" />
