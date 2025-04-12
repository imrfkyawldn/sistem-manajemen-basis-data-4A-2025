-- Membuat Database
CREATE DATABASE IF NOT EXISTS db_parkir;
USE db_parkir;

-- Membuat Tabel Departemen
CREATE TABLE IF NOT EXISTS departemen (
    id_departemen INT AUTO_INCREMENT PRIMARY KEY,
    nama_departemen VARCHAR(100) NOT NULL UNIQUE
);

-- Membuat Tabel Jabatan
CREATE TABLE IF NOT EXISTS jabatan (
    id_jabatan INT AUTO_INCREMENT PRIMARY KEY,
    nama_jabatan VARCHAR(100) NOT NULL UNIQUE
);

-- Membuat Tabel Karyawan
CREATE TABLE IF NOT EXISTS karyawan (
    id_karyawan INT AUTO_INCREMENT PRIMARY KEY,
    nik VARCHAR(20) NOT NULL UNIQUE,
    nama_karyawan VARCHAR(100) NOT NULL,
    tgl_lahir DATE NOT NULL,
    jk ENUM('L', 'P') NOT NULL,
    id_departemen INT NOT NULL,
    id_jabatan INT NOT NULL,
    tgl_masuk DATE NOT NULL,
    id_kartu VARCHAR(20) NOT NULL UNIQUE,
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_departemen) REFERENCES departemen(id_departemen) ON DELETE CASCADE,
    FOREIGN KEY (id_jabatan) REFERENCES jabatan(id_jabatan) ON DELETE CASCADE
);

-- Membuat Tabel Admin
CREATE TABLE IF NOT EXISTS adminn (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    kata_sandi VARCHAR(255) NOT NULL,
    nama_admin VARCHAR(100) NOT NULL
);

-- Membuat Tabel Kendaraan
CREATE TABLE IF NOT EXISTS kendaraan (
    id_kendaraan INT AUTO_INCREMENT PRIMARY KEY,
    nopol VARCHAR(20) NOT NULL UNIQUE,
    id_kartu VARCHAR(20) NOT NULL,
    tipe_kendaraan ENUM('Mobil', 'Motor') NOT NULL,
    FOREIGN KEY (id_kartu) REFERENCES karyawan(id_kartu) ON DELETE CASCADE
);

-- Membuat Tabel Parkir
CREATE TABLE IF NOT EXISTS parkir (
    id_parkir INT AUTO_INCREMENT PRIMARY KEY,
    id_kartu VARCHAR(20) NOT NULL,
    nopol VARCHAR(20) NOT NULL,
    tgl_masuk DATE NOT NULL,
    jam_masuk TIME NOT NULL,
    tgl_keluar DATE NULL,
    jam_keluar TIME NULL,
    tarif_parkir DECIMAL(10,2) NULL,
    tipe_kendaraan ENUM('Mobil', 'Motor') NOT NULL,
    id_admin INT NOT NULL,
    FOREIGN KEY (id_kartu) REFERENCES karyawan(id_kartu) ON DELETE CASCADE,
    FOREIGN KEY (nopol) REFERENCES kendaraan(nopol) ON DELETE CASCADE,
    FOREIGN KEY (id_admin) REFERENCES adminn(id_admin) ON DELETE CASCADE
);

-- Memasukkan data departemen 
INSERT IGNORE INTO departemen (nama_departemen) VALUES 
('Produksi'),
('Keuangan'),
('SDM'),
('IT'),
('Logistik'),
('Marketing & Sales');

-- Memasukkan data jabatan 
INSERT IGNORE INTO jabatan (nama_jabatan) VALUES 
('Direktur'),
('Manager Departemen'),
('Supervisor'),
('Staff'),
('Operator'),
('Administrasi'),
('Security');

-- Memasukkan data karyawan
INSERT INTO karyawan (nik, nama_karyawan, tgl_lahir, jk, id_departemen, id_jabatan, tgl_masuk, id_kartu, saldo) VALUES
('123456789', 'Budi Santoso', '1985-07-15', 'L', 1, 1, '2015-06-01', 'KARTU001', 500000),
('987654321', 'Siti Rahmawati', '1990-11-21', 'P', 2, 3, '2018-09-12', 'KARTU002', 250000),
('567890123', 'Ahmad Fauzan', '1995-03-10', 'L', 3, 2, '2020-02-20', 'KARTU003', 300000),
('345678901', 'Dewi Lestari', '1998-05-25', 'P', 4, 4, '2022-01-10', 'KARTU004', 150000),
('456789012', 'Rizky Pratama', '1987-09-05', 'L', 5, 5, '2012-08-30', 'KARTU005', 100000)
ON DUPLICATE KEY UPDATE saldo = VALUES(saldo);

-- Memasukkan data adminn
INSERT IGNORE INTO adminn (username, kata_sandi, nama_admin) VALUES
('rifky001', 'rifky123', 'rifky'),
('aldinn002', 'aldin123', 'aldinn');

-- Memasukkan data kendaraan
INSERT IGNORE INTO kendaraan (nopol, id_kartu, tipe_kendaraan) VALUES
('B 1234 CD', 'KARTU001', 'Mobil'),
('L 5678 EF', 'KARTU002', 'Motor'),
('N 9012 GH', 'KARTU003', 'Mobil'),
('W 3456 IJ', 'KARTU004', 'Motor'),
('AG 7890 KL', 'KARTU005', 'Mobil');

-- Memasukkan data parkir
INSERT INTO parkir (id_kartu, nopol, tgl_masuk, jam_masuk, tgl_keluar, jam_keluar, tarif_parkir, tipe_kendaraan, id_admin) VALUES
('KARTU001', 'B 1234 CD', '2025-03-27', '08:30:00', '2025-03-27', '17:30:00', 20000, 'Mobil', 1),
('KARTU002', 'L 5678 EF', '2025-03-27', '09:00:00', '2025-03-27', '12:00:00', 5000, 'Motor', 2),
('KARTU003', 'N 9012 GH', '2025-03-27', '07:45:00', '2025-03-27', '18:15:00', 15000, 'Mobil', 1),
('KARTU004', 'W 3456 IJ', '2025-03-27', '10:00:00', NULL, NULL, NULL, 'Motor', 2),
('KARTU005', 'AG 7890 KL', '2025-03-27', '06:30:00', '2025-03-27', '15:00:00', 10000, 'Mobil', 1);

-- Menampilkan isi tabel untuk memastikan data tersimpan
SELECT * FROM departemen;
SELECT * FROM jabatan;
SELECT * FROM karyawan;
SELECT * FROM adminn;
SELECT * FROM kendaraan;
SELECT * FROM parkir;

-- Untuk mengetahui karyawan berada di mana
SELECT k.nik, k.nama_karyawan, d.nama_departemen, j.nama_jabatan
FROM karyawan k
JOIN departemen d ON k.id_departemen = d.id_departemen
JOIN jabatan j ON k.id_jabatan = j.id_jabatan
WHERE k.nama_karyawan = 'Budi Santoso'; 

-- Untuk mengetahui semua karyawan berada di mana
SELECT k.nik, k.nama_karyawan, d.nama_departemen, j.nama_jabatan
FROM karyawan k
JOIN departemen d ON k.id_departemen = d.id_departemen
JOIN jabatan j ON k.id_jabatan = j.id_jabatan;
