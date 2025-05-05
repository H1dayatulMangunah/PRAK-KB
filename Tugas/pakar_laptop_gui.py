import tkinter as tk
from tkinter import ttk
from pyswip import Prolog
from tkinter import messagebox


# Inisialisasi Prolog
prolog = Prolog()
prolog.consult("pakar_laptop_gui.pl")

# Ambil daftar laptop dari basis pengetahuan
laptop_list = [
    res["X"].decode("utf-8") if isinstance(res["X"], bytes) else res["X"]
    for res in prolog.query("laptop(X)")
]

# Ambil spesifikasi yang dibutuhkan tiap laptop
spesifikasi_laptop = {}
for l in laptop_list:
    result = prolog.query(f'spesifikasi(K, "{l}")')
    spesifikasi_laptop[l] = [r["K"] for r in result]
    print(f"{l} -> {spesifikasi_laptop[l]}")

# Variabel untuk pelacakan posisi
index_laptop = 0
index_kriteria = -1
current_laptop = ""
current_kriteria = ""

# Tampilkan pertanyaan ke user
def tampilkan_pertanyaan(teks):
    kotak_pertanyaan.config(state=tk.NORMAL)
    kotak_pertanyaan.delete(1.0, tk.END)
    kotak_pertanyaan.insert(tk.END, teks)
    kotak_pertanyaan.config(state=tk.DISABLED)

# Tampilkan hasil akhir rekomendasi laptop
def tampilkan_rekomendasi(laptop_terpilih=""):
    if laptop_terpilih:
        messagebox.showinfo("Rekomendasi Laptop", f"Laptop yang cocok untuk Anda adalah:\n{laptop_terpilih}.")
    else:
        messagebox.showinfo("Rekomendasi Laptop", "Tidak ditemukan laptop yang sesuai dengan kebutuhan Anda.")
    yes_btn.config(state=tk.DISABLED)
    no_btn.config(state=tk.DISABLED)
    start_btn.config(state=tk.NORMAL)

# Proses spesifikasi berikutnya
def spesifikasi_selanjutnya(ganti_laptop=False):
    global index_laptop, index_kriteria, current_laptop, current_kriteria

    if ganti_laptop:
        index_laptop += 1
        index_kriteria = -1

    if index_laptop >= len(laptop_list):
        tampilkan_rekomendasi()
        return

    current_laptop = laptop_list[index_laptop]
    index_kriteria += 1

    if index_kriteria >= len(spesifikasi_laptop[current_laptop]):
        tampilkan_rekomendasi(current_laptop)
        return

    current_kriteria = spesifikasi_laptop[current_laptop][index_kriteria]

    if list(prolog.query(f"spesifikasi_pos({current_kriteria})")):
        spesifikasi_selanjutnya()
        return
    elif list(prolog.query(f"spesifikasi_neg({current_kriteria})")):
        spesifikasi_selanjutnya(ganti_laptop=True)
        return

    pertanyaan = list(prolog.query(f"pertanyaan({current_kriteria}, Y)"))[0]["Y"]
    tampilkan_pertanyaan(pertanyaan)

# Proses jawaban user
def proses_jawaban(jawaban_user):
    if jawaban_user:
        prolog.assertz(f"spesifikasi_pos({current_kriteria})")
        spesifikasi_selanjutnya()
    else:
        prolog.assertz(f"spesifikasi_neg({current_kriteria})")
        spesifikasi_selanjutnya(ganti_laptop=True)

# Fungsi mulai proses pemilihan
def mulai_pemilihan_laptop():
    global index_laptop, index_kriteria
    prolog.retractall("spesifikasi_pos(_)")
    prolog.retractall("spesifikasi_neg(_)")
    index_laptop = 0
    index_kriteria = -1
    yes_btn.config(state=tk.NORMAL)
    no_btn.config(state=tk.NORMAL)
    start_btn.config(state=tk.DISABLED)
    spesifikasi_selanjutnya()

# ==== GUI Layout ====
root = tk.Tk()
root.title("Sistem Pakar Pemilihan Jenis Laptop")

mainframe = ttk.Frame(root, padding="10 10 20 20")
mainframe.grid(column=0, row=0, sticky=(tk.N, tk.W, tk.E, tk.S))
root.columnconfigure(0, weight=1)
root.rowconfigure(0, weight=1)

ttk.Label(mainframe, text="Aplikasi Rekomendasi Jenis Laptop", font=("Arial", 16)).grid(column=0, row=0, columnspan=3)
ttk.Label(mainframe, text="Pertanyaan Spesifikasi:").grid(column=0, row=1)

kotak_pertanyaan = tk.Text(mainframe, height=4, width=60, state=tk.DISABLED)
kotak_pertanyaan.grid(column=0, row=2, columnspan=3)

no_btn = ttk.Button(mainframe, text="Tidak", state=tk.DISABLED, command=lambda: proses_jawaban(False))
no_btn.grid(column=1, row=3, sticky=(tk.W, tk.E))

yes_btn = ttk.Button(mainframe, text="Ya", state=tk.DISABLED, command=lambda: proses_jawaban(True))
yes_btn.grid(column=2, row=3, sticky=(tk.W, tk.E))

start_btn = ttk.Button(mainframe, text="Mulai Pemilihan Laptop", command=mulai_pemilihan_laptop)
start_btn.grid(column=1, row=4, columnspan=2, sticky=(tk.W, tk.E))

for widget in mainframe.winfo_children():
    widget.grid_configure(padx=5, pady=5)

# Jalankan GUI
root.mainloop()
