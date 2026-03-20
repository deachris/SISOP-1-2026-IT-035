BEGIN {
FS = ","
opsi = ARGV[2]

if (opsi != "a" && opsi != "b" && opsi != "c" && opsi != "d" && opsi != "e") { 
print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
exit
}

ARGV[2] = ""
}

NR > 1 {
if (opsi == "a")
{count++}
else if (opsi == "b"){
a[$4]}
else if (opsi == "c")
{if($2 > max) {max = $2; nama = $1}}
else if (opsi == "d")
{jumlah+=$2; count++}
else if (opsi == "e"){
if ($3 == "Business") {count++}
}}

END {
if (opsi == "a")
{print "Jumlah seluruh penumpang KANJ adalah", count, "orang"}
else if (opsi == "b")
{print "Jumlah gerbong penumpang KANJ adalah", length(a)}
else if (opsi == "c")
{print nama, "adalah penumpang kereta tertua dengan usia", max}
else if (opsi == "d")
{print "Rata-rata usia penumpang adalah", int(jumlah/count+0.5), "tahun"}
else if (opsi == "e")
{print "Jumlah penumpang business class ada", count, "orang"}
}
