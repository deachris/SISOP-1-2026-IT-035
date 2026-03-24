# SISOP-1-2026-IT-035

**Dikerjakan oleh: Dea Chrisna Butarbutar - 5027251035**

## Reporting

### Soal 1

#### Penjelasan

Langkah pertama adalah memasukkan data penumpang ke dalam file passenger.csv yang sudah dibuat sebelumnya. 
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

Untuk menghitung total penumpang di kereta, menjumlahkan semua baris di dalam file *passenger.csv*
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

**Beberapa Isi File passenger.csv**
<img width="905" height="774" alt="image" src="https://github.com/user-attachments/assets/6c35908f-fe31-400a-8f18-4fde573013e9" />
