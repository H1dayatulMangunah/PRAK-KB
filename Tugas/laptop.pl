% SISTEM PAKAR PEMILIHAN JENIS LAPTOP

% DATABASE
% Menyimpan data apakah X membutuhkan spesifikasi Y.
:- dynamic spesifikasi/2.

% ATURAN
% tipe_laptop(X, Y) menyatakan bahwa user X cocok menggunakan laptop tipe Y.

tipe_laptop(X, acer_gaming) :-
    spesifikasi(X, ram_16_gb),
    spesifikasi(X, storage_512gb),
    spesifikasi(X, harga_15jt),
    spesifikasi(X, gpu_gtx1660).

tipe_laptop(X, dell_office) :-
    spesifikasi(X, ram_8gb),
    spesifikasi(X, storage_256gb),
    spesifikasi(X, harga_10jt),
    spesifikasi(X, ringan_portabel).

tipe_laptop(X, asus_gaming) :-
    spesifikasi(X, ram_32gb),
    spesifikasi(X, storage_512gb),
    spesifikasi(X, harga_25jt),
    spesifikasi(X, gpu_rtx3060).

tipe_laptop(X, hp_multimedia) :-
    spesifikasi(X, ram_16gb),
    spesifikasi(X, storage_512gb),
    spesifikasi(X, harga_12jt),
    spesifikasi(X, layar_4k).

tipe_laptop(X, lenovo_office) :-
    spesifikasi(X, ram_8gb),
    spesifikasi(X, storage_128gb),
    spesifikasi(X, harga_8jt),
    spesifikasi(X, baterai_awet).
