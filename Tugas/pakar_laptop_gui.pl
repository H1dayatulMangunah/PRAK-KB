% SISTEM PAKAR PEMILIHAN JENIS LAPTOP

% DATABASE
:- dynamic spesifikasi_pos/1.
:- dynamic spesifikasi_neg/1.

% FAKTA TIPE LAPTOP
laptop("Acer Gaming").
laptop("Dell Office").
laptop("Asus Gaming").
laptop("HP Multimedia").
laptop("Lenovo Office").

% HUBUNGAN SPESIFIKASI - TIPE LAPTOP
spesifikasi(ram_16gb, "Acer Gaming").
spesifikasi(storage_512gb, "Acer Gaming").
spesifikasi(harga_15jt, "Acer Gaming").
spesifikasi(gpu_gtx1660, "Acer Gaming").

spesifikasi(ram_8gb, "Dell Office").
spesifikasi(storage_256gb, "Dell Office").
spesifikasi(harga_10jt, "Dell Office").
spesifikasi(ringan_portabel, "Dell Office").

spesifikasi(ram_32gb, "Asus Gaming").
spesifikasi(storage_512gb, "Asus Gaming").
spesifikasi(harga_25jt, "Asus Gaming").
spesifikasi(gpu_rtx3060, "Asus Gaming").

spesifikasi(ram_16gb, "HP Multimedia").
spesifikasi(storage_512gb, "HP Multimedia").
spesifikasi(harga_12jt, "HP Multimedia").
spesifikasi(layar_4k, "HP Multimedia").

spesifikasi(ram_8gb, "Lenovo Office").
spesifikasi(storage_128gb, "Lenovo Office").
spesifikasi(harga_8jt, "Lenovo Office").
spesifikasi(baterai_awet, "Lenovo Office").

% PERTANYAAN UNTUK SETIAP SPESIFIKASI
pertanyaan(ram_8gb, Y) :-
    Y = "Apakah Anda membutuhkan RAM 8 GB?".

pertanyaan(ram_16gb, Y) :-
    Y = "Apakah Anda membutuhkan RAM 16 GB?".

pertanyaan(ram_32gb, Y) :-
    Y = "Apakah Anda membutuhkan RAM 32 GB?".

pertanyaan(storage_128gb, Y) :-
    Y = "Apakah Anda membutuhkan storage 128 GB?".

pertanyaan(storage_256gb, Y) :-
    Y = "Apakah Anda membutuhkan storage 256 GB?".

pertanyaan(storage_512gb, Y) :-
    Y = "Apakah Anda membutuhkan storage 512 GB?".

pertanyaan(harga_8jt, Y) :-
    Y = "Apakah budget Anda sekitar Rp8 juta?".

pertanyaan(harga_10jt, Y) :-
    Y = "Apakah budget Anda sekitar Rp10 juta?".

pertanyaan(harga_12jt, Y) :-
    Y = "Apakah budget Anda sekitar Rp12 juta?".

pertanyaan(harga_15jt, Y) :-
    Y = "Apakah budget Anda sekitar Rp15 juta?".

pertanyaan(harga_25jt, Y) :-
    Y = "Apakah budget Anda sekitar Rp25 juta?".

pertanyaan(gpu_gtx1660, Y) :-
    Y = "Apakah Anda membutuhkan GPU GTX 1660?".

pertanyaan(gpu_rtx3060, Y) :-
    Y = "Apakah Anda membutuhkan GPU RTX 3060?".

pertanyaan(ringan_portabel, Y) :-
    Y = "Apakah Anda membutuhkan laptop yang ringan dan portabel?".

pertanyaan(layar_4k, Y) :-
    Y = "Apakah Anda membutuhkan layar 4K?".

pertanyaan(baterai_awet, Y) :-
    Y = "Apakah Anda membutuhkan baterai yang tahan lama?".
