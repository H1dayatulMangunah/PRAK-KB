% SISTEM PAKAR PEMILIHAN JENIS LAPTOP DENGAN TANYA JAWAB

% DATABASE DINAMIS
:- dynamic spesifikasi_pos/1.
:- dynamic spesifikasi_neg/1.

% TAMPILAN PERTANYAAN
pertanyaan(ram_8gb) :- write("Apakah Anda membutuhkan RAM 8 GB?").
pertanyaan(ram_16gb) :- write("Apakah Anda membutuhkan RAM 16 GB?").
pertanyaan(ram_32gb) :- write("Apakah Anda membutuhkan RAM 32 GB?").
pertanyaan(storage_128gb) :- write("Apakah Anda membutuhkan storage 128 GB?").
pertanyaan(storage_256gb) :- write("Apakah Anda membutuhkan storage 256 GB?").
pertanyaan(storage_512gb) :- write("Apakah Anda membutuhkan storage 512 GB?").
pertanyaan(harga_8jt) :- write("Apakah Anda memiliki budget sekitar Rp8 juta?").
pertanyaan(harga_10jt) :- write("Apakah Anda memiliki budget sekitar Rp10 juta?").
pertanyaan(harga_12jt) :- write("Apakah Anda memiliki budget sekitar Rp12 juta?").
pertanyaan(harga_15jt) :- write("Apakah Anda memiliki budget sekitar Rp15 juta?").
pertanyaan(harga_25jt) :- write("Apakah Anda memiliki budget sekitar Rp25 juta?").
pertanyaan(gpu_gtx1660) :- write("Apakah Anda membutuhkan kartu grafis GTX 1660?").
pertanyaan(gpu_rtx3060) :- write("Apakah Anda membutuhkan kartu grafis RTX 3060?").
pertanyaan(ringan_portabel) :- write("Apakah Anda butuh laptop ringan dan portabel?").
pertanyaan(layar_4k) :- write("Apakah Anda membutuhkan layar 4K?").
pertanyaan(baterai_awet) :- write("Apakah Anda butuh baterai yang tahan lama?").

% DIAGNOSA: Menanyakan dan menyimpan kebutuhan
diagnosa(S) :-
    pertanyaan(S), writeln(" (y/t)"), read(Jawaban), Jawaban == y,
    assertz(spesifikasi_pos(S)).

diagnosa(S) :-
    assertz(spesifikasi_neg(S)), fail.

% CEK SPESIFIKASI
spesifikasi(S) :- spesifikasi_pos(S), !.
spesifikasi(S) :- spesifikasi_neg(S), !, fail.
spesifikasi(S) :- diagnosa(S).

% ATURAN TIPE LAPTOP
tipe_laptop(acer_gaming) :-
    spesifikasi(ram_16gb),
    spesifikasi(storage_512gb),
    spesifikasi(harga_15jt),
    spesifikasi(gpu_gtx1660),
    hasil("Laptop yang cocok adalah: Acer Gaming").

tipe_laptop(dell_office) :-
    spesifikasi(ram_8gb),
    spesifikasi(storage_256gb),
    spesifikasi(harga_10jt),
    spesifikasi(ringan_portabel),
    hasil("Laptop yang cocok adalah: Dell Office").

tipe_laptop(asus_gaming) :-
    spesifikasi(ram_32gb),
    spesifikasi(storage_512gb),
    spesifikasi(harga_25jt),
    spesifikasi(gpu_rtx3060),
    hasil("Laptop yang cocok adalah: Asus Gaming").

tipe_laptop(hp_multimedia) :-
    spesifikasi(ram_16gb),
    spesifikasi(storage_512gb),
    spesifikasi(harga_12jt),
    spesifikasi(layar_4k),
    hasil("Laptop yang cocok adalah: HP Multimedia").

tipe_laptop(lenovo_office) :-
    spesifikasi(ram_8gb),
    spesifikasi(storage_128gb),
    spesifikasi(harga_8jt),
    spesifikasi(baterai_awet),
    hasil("Laptop yang cocok adalah: Lenovo Office").

% OUTPUT
hasil(Pesan) :-
    nl, write(">>> "), writeln(Pesan), !.

% START
mulai :-
    retractall(spesifikasi_pos(_)),
    retractall(spesifikasi_neg(_)),
    (tipe_laptop(_); write(">>> Maaf, tidak ada laptop yang cocok dengan kebutuhan Anda.")), nl.
