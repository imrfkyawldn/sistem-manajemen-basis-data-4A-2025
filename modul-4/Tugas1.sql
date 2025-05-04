-- Membuat Database
CREATE DATABASE IF NOT EXISTS db_parkir;

-- Menggunakan Database
USE db_parkir;

-- Tabel Departemen
CREATE TABLE IF NOT EXISTS departemen (
    id_departemen INT AUTO_INCREMENT PRIMARY KEY,
    nama_departemen VARCHAR(100) NOT NULL UNIQUE
);

-- Tabel Jabatan
CREATE TABLE IF NOT EXISTS jabatan (
    id_jabatan INT AUTO_INCREMENT PRIMARY KEY,
    nama_jabatan VARCHAR(100) NOT NULL UNIQUE
);

-- Tabel Karyawan
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

-- Tabel Admin
CREATE TABLE IF NOT EXISTS adminn (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    kata_sandi VARCHAR(255) NOT NULL,
    nama_admin VARCHAR(100) NOT NULL
);

-- Tabel Kendaraan
CREATE TABLE IF NOT EXISTS kendaraan (
    id_kendaraan INT AUTO_INCREMENT PRIMARY KEY,
    nopol VARCHAR(20) NOT NULL UNIQUE,
    id_kartu VARCHAR(20) NOT NULL,
    tipe_kendaraan ENUM('Mobil', 'Motor') NOT NULL,
    FOREIGN KEY (id_kartu) REFERENCES karyawan(id_kartu) ON DELETE CASCADE
);

-- Tabel Parkir (Sudah diperbaiki - tidak ada duplikasi tipe_kendaraan)
CREATE TABLE IF NOT EXISTS parkir (
    id_parkir INT AUTO_INCREMENT PRIMARY KEY,
    id_kartu VARCHAR(20) NOT NULL,
    nopol VARCHAR(20) NOT NULL,
    tgl_masuk DATE NOT NULL,
    jam_masuk TIME NOT NULL,
    tgl_keluar DATE NULL,
    jam_keluar TIME NULL,
    tarif_parkir DECIMAL(10,2) NULL,
    id_admin INT NOT NULL,
    harga DECIMAL(10,2) NOT NULL DEFAULT 0,
    keterangan VARCHAR(255) DEFAULT 'Masih Parkir',
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
('456789012', 'Rizky Pratama', '1987-09-05', 'L', 5, 5, '2012-08-30', 'KARTU005', 100000),
('112233445', 'Feri Jatmiko', '1982-01-18', 'L', 2, 1, '2010-05-15', 'KARTU006', 600000),
('223344556', 'Maya Pratama', '1993-07-25', 'P', 3, 2, '2016-03-14', 'KARTU007', 450000),
('334455667', 'Andi Widodo', '1991-02-13', 'L', 1, 4, '2019-11-03', 'KARTU008', 350000),
('445566778', 'Rika Nurhadi', '1989-04-22', 'P', 4, 3, '2017-10-11', 'KARTU009', 550000),
('556677889', 'Hendra Wijaya', '1980-12-30', 'L', 5, 5, '2005-07-07', 'KARTU010', 750000),
('667788990', 'Vivi Lestari', '1997-06-12', 'P', 3, 1, '2021-01-25', 'KARTU011', 400000),
('778899001', 'Gilang Setiawan', '1992-08-30', 'L', 2, 2, '2018-05-19', 'KARTU012', 200000),
('889900112', 'Tina Anisa', '1984-09-18', 'P', 1, 4, '2013-11-09', 'KARTU013', 350000),
('990011223', 'Yoga Prasetya', '1996-02-06', 'L', 4, 3, '2020-12-05', 'KARTU014', 450000),
('101112233', 'Indah Rahayu', '1994-10-10', 'P', 5, 2, '2014-06-21', 'KARTU015', 300000),
('202223344', 'Rudi Setiawan', '1988-11-02', 'L', 2, 1, '2011-02-14', 'KARTU016', 650000),
('303334455', 'Yuliana Dewi', '1999-03-14', 'P', 3, 5, '2022-07-22', 'KARTU017', 250000),
('404445566', 'Krisna Wijaya', '1991-04-25', 'L', 4, 4, '2018-11-09', 'KARTU018', 550000),
('505556677', 'Lina Mahendra', '1986-09-17', 'P', 5, 3, '2010-04-04', 'KARTU019', 500000),
('606667788', 'Eko Prasetyo', '1992-07-09', 'L', 1, 5, '2015-05-28', 'KARTU020', 400000);

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
('AG 7890 KL', 'KARTU005', 'Mobil'),
('B 8888 ZY', 'KARTU006', 'Mobil'),
('L 9999 WX', 'KARTU007', 'Motor'),
('N 7777 QP', 'KARTU008', 'Mobil'),
('W 6666 OP', 'KARTU009', 'Motor'),
('AG 5555 MN', 'KARTU010', 'Mobil'),
('B 4444 KL', 'KARTU011', 'Motor'),
('L 3333 JK', 'KARTU012', 'Mobil'),
('N 2222 HI', 'KARTU013', 'Motor'),
('W 1111 FG', 'KARTU014', 'Mobil'),
('AG 0000 DE', 'KARTU015', 'Motor'),
('B 2020 AB', 'KARTU016', 'Mobil'),
('L 3030 CD', 'KARTU017', 'Motor'),
('N 4040 EF', 'KARTU018', 'Mobil'),
('W 5050 GH', 'KARTU019', 'Motor'),
('AG 6060 IJ', 'KARTU020', 'Mobil');

-- Memasukkan data parkir
INSERT INTO parkir (id_kartu, nopol, tgl_masuk, jam_masuk, tgl_keluar, jam_keluar, tarif_parkir, id_admin, harga) 
VALUES
('KARTU001', 'B 1234 CD', '2025-03-27', '08:30:00', '2025-03-27', '17:30:00',
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '08:30:00'), CONCAT('2025-03-27 ', '17:30:00'))) * 2000, 1, 
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '08:30:00'), CONCAT('2025-03-27 ', '17:30:00'))) * 2000),
('KARTU002', 'L 5678 EF', '2025-03-27', '09:00:00', '2025-03-27', '12:00:00',
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '09:00:00'), CONCAT('2025-03-27 ', '12:00:00'))) * 1000, 2, 
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '09:00:00'), CONCAT('2025-03-27 ', '12:00:00'))) * 1000),
('KARTU003', 'N 9012 GH', '2025-03-27', '07:45:00', '2025-03-27', '18:15:00',
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '07:45:00'), CONCAT('2025-03-27 ', '18:15:00'))) * 2000, 1, 
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '07:45:00'), CONCAT('2025-03-27 ', '18:15:00'))) * 2000),
('KARTU004', 'W 3456 IJ', '2025-03-27', '10:00:00', NULL, NULL, NULL, 2, 1000),
('KARTU005', 'AG 7890 KL', '2025-03-27', '06:30:00', '2025-03-27', '15:00:00',
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '06:30:00'), CONCAT('2025-03-27 ', '15:00:00'))) * 2000, 1, 
    (TIMESTAMPDIFF(HOUR, CONCAT('2025-03-27 ', '06:30:00'), CONCAT('2025-03-27 ', '15:00:00'))) * 2000);

-- Menampilkan Data Setiap Tabel
SELECT * FROM departemen;
SELECT * FROM jabatan;
SELECT * FROM karyawan;
SELECT * FROM adminn;
SELECT * FROM kendaraan;
SELECT * FROM parkir;

----- 1 Menambah kolom keterangan
ALTER TABLE parkir
ADD COLUMN keterangan VARCHAR(255);
UPDATE parkir
SET keterangan = CASE
    WHEN tgl_keluar IS NULL THEN 'Masih Parkir'
    ELSE 'Telah Keluar'
END;

----- 2 Menggabungkan tabel karyawan dengan departemen
SELECT karyawan.nama_karyawan, departemen.nama_departemen
FROM karyawan
JOIN departemen ON karyawan.id_departemen = departemen.id_departemen;

----- 3 Mengurutkan ORDEY BY DESC, dan ASC
----- DESC -----
SELECT nama_karyawan, saldo
FROM karyawan
ORDER BY saldo DESC;

----- ASC -----
SELECT nama_karyawan, saldo
FROM karyawan
ORDER BY saldo ASC;

----- 4 Mengubah tipe data harga INT ke Decimal
ALTER TABLE parkir
MODIFY COLUMN harga DECIMAL(10,2);

----- 5 Kode LEFT JOIN, RIGHT JOIN, dan SELF JOIN
----- LEFT JOIN (Menampilkan semua karyawan, dengan data departemen)
SELECT karyawanA.nama_karyawan AS nama_karyawan, departemenA.nama_departemen AS nama_departemen
FROM karyawan AS karyawanA
LEFT JOIN departemen AS departemenA ON karyawanA.id_departemen = departemenA.id_departemen;

----- RIGHT JOIN (Menampilkan semua data dari tabel jabatan)
SELECT 
    jabatanA.id_jabatan, 
    jabatanA.nama_jabatan, 
    karyawanA.nik, 
    karyawanA.nama_karyawan
FROM jabatan jabatanA
RIGHT JOIN karyawan karyawanA ON jabatanA.id_jabatan = karyawanA.id_jabatan;

----- SELF JOIN (Menampilkan data karyawan yang satu jabatan dengan karyawan lainnya)
SELECT 
    karyawanA.nik AS nik_karyawan_1, 
    karyawanA.nama_karyawan AS nama_karyawan_1, 
    karyawanB.nik AS nik_karyawan_2, 
    karyawanB.nama_karyawan AS nama_karyawan_2,
    karyawanA.id_jabatan
FROM karyawan karyawanA
JOIN karyawan karyawanB 
    ON karyawanA.id_jabatan = karyawanB.id_jabatan
    AND karyawanA.nik != karyawanB.nik;

----- 6 Operator Perbandingan -----
----- Operator = (sama dengan)
SELECT * FROM karyawan WHERE jk = 'P';

----- Operator != (tidak sama dengan)
SELECT * FROM karyawan WHERE id_departemen != 2;

----- Operator > (lebih besar dari)
SELECT * FROM karyawan WHERE saldo > 100000;

----- Operator < (kurang dari)
SELECT * FROM karyawan WHERE saldo < 300000;

----- Operator LIKE
SELECT * FROM karyawan WHERE nama_karyawan LIKE '%AN%';

----- Operator BETWEEN
SELECT * FROM karyawan WHERE saldo BETWEEN 50000 AND 150000;

----- Soal Dari Mas Rosyid -----
SELECT karyawanA.nama_karyawan, jabatanA.nama_jabatan, departemenA.nama_departemen, kendaraanA.tipe_kendaraan, kendaraanA.nopol
FROM karyawan karyawanA
JOIN jabatan jabatanA ON karyawanA.id_jabatan = jabatanA.id_jabatan
JOIN departemen departemenA ON karyawanA.id_departemen = departemenA.id_departemen
JOIN kendaraan kendaraanA ON karyawanA.id_kartu = kendaraanA.id_kartu
WHERE jabatanA.nama_jabatan = 'Manager' OR jabatanA.nama_jabatan = 'Supervisor';

-- Menghapus Database
DROP DATABASE db_parkir;
