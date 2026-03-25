
#!/bin/bash

checkNama() {
local tambahNama="$1"
local cekNama

while IFS="|" read -r cekNama kamar sewa masuk status
do
if [[ "$cekNama" == "$tambahNama" ]]
then
echo "Nama sudah ada! Silakan buat nama lain."
return 1
fi
done < "/home/ubuntu/SISOP-1-2026-IT-035/soal_3/data/penghuni.csv"
return 0
}

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


checkSewa() {
if [[ $sewa -le 1 ]]
then
echo "Harga sewa tidak valid!"
return 1
fi
return 0
}

checkTanggal() {
if ! [[ $masuk =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
then
echo "Tanggal tidak valid! Format tanggal harus YYYY-MM-DD."
return 1
fi

today=$(date +%Y-%m-%d)
if [[ "$masuk" > "$today" ]]
then
echo "Tanggal tidak boleh melebihi hari ini. Silakan pilih tanggal hari ini/sebelumnya!"
return 1
fi
return 0
}

checkStatus() {
if ! [[ $status = "Aktif" || $status = "Menunggak" ]]
then
echo "Status tidak valid! Silakan pilih status Aktif atau Menunggak."
return 1
fi
return 0
}

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

case "$menuCron" in
"1")
echo "========== DAFTAR CRON JOB PENGINGAT TAGIHAN =========="
crontab -l 2>/dev/null || echo "Tidak ada cron job."
echo ""
read -p "Tekan [Enter] untuk kembali ke Menu Kelola Cron."
;;

"2")
read -p "Masukkan jam (00-23): " jam
read -p "Masukkan menit (00-59): " menit
echo "$menit $jam * * * /home/ubuntu/SISOP-1-2026-IT-035/soal_3/kost_slebew.sh --check-tagihan >> /home/ubuntu/SISOP-1-2026-IT-035/soal_3/log/tagihan.log" | crontab -
echo ""
echo "[✔] Cron job berhasil ditambahkan pada pukul $jam:$menit!"
echo ""
read -p "Tekan [Enter] untuk kembali ke Menu Kelola Cron."
;;

"3")
crontab -r
echo ""
echo "[✔] Cron job pengingat tagihan berhasil dihapus!"
echo ""
read -p "Tekan [Enter] untuk kembali ke Menu Kelola Cron."
;;

"4")
echo "Keluar dari Menu Kelola Cron..."
break
;;

*)
echo "Menu tidak valid!"
;;
esac
done
}

if [ "$1" = "--check-tagihan" ]
then
checkTagihan
exit 0
fi

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

total_aktif=0
total_nunggak=0
count=0

case "$opsi" in
1)
echo "================================================"
echo "              TAMBAH PENGHUNI                   "
echo "================================================"

while true
do
read -p "Masukkan nama: " nama
if checkNama "$nama"
then
break
fi
done

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

echo "$nama|$kamar|$sewa|$masuk|$status" >> data/penghuni.csv
echo ""
echo "[✔] Penghuni $nama berhasil ditambahkan ke kamar $kamar dengan status $status."

read -p "Tekan [Enter] untuk kembali ke menu."
;;

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

5)
total_aktif=$(awk -F"|" '$5=="Aktif" {sum += $3} END {print sum+0}' data/penghuni.csv)
total_nunggak=$(awk -F"|" '$5=="Menunggak" {sum += $3} END {print sum+0}' data/penghuni.csv)
count=$(awk 'END {print NR}' data/penghuni.csv)

laporan=$(
echo "========================================================="
echo "              LAPORAN KEUANGAN KOST SLEBEW               "
echo "========================================================="
printf " Total pemasukan (Aktif) : %d\n" "$total_aktif"
printf " Total tunggakan         : %d\n" "$total_nunggak"
printf " Jumlah penghuni         : %d\n" "$count"
echo  "---------------------------------------------------------"
printf " Daftar penghuni menunggak: \n"
printf "--------------------------------------------------------"
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
)

echo "$laporan"
echo "$laporan" > rekap/laporan_bulanan.txt
echo ""
echo "[✔] Laporan berhasil disimpan ke rekap/laporan_bulanan.txt"
echo ""
read -p "Tekan [Enter] untuk kembali ke menu."
;;

6)
kelolaCron
;;

7)
echo "Keluar dari program..."
exit 0
;;

*)
echo "Opsi tidak valid!" ;;
esac
done
