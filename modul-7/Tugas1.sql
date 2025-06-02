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
    keterangan ENUM('Masih Parkir', 'Sudah Keluar') DEFAULT 'Masih Parkir',
    id_admin INT NOT NULL, -- Tambahkan kolom ini
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
('123456784', 'Budi Santoso', '1985-07-15', 'L', 1, 1, '2015-06-01', 'KARTU001', 500000),
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
('B 6789 EF', 'KARTU003', 'Mobil'),
('C 3456 GH', 'KARTU004', 'Motor'),

('D 7890 IJ', 'KARTU005', 'Mobil'),
('E 3456 KL', 'KARTU006', 'Motor'),
('F 4567 LM', 'KARTU007', 'Mobil'),
('G 2345 OP', 'KARTU008', 'Motor'),
('H 6789 PQ', 'KARTU009', 'Mobil'),

('I 2345 RS', 'KARTU001', 'Motor'),
('J 5678 VW', 'KARTU002', 'Mobil'),
('K 3456 ST', 'KARTU003', 'Motor'),
('L 4567 XY', 'KARTU004', 'Mobil'),

('M 2345 QR', 'KARTU005', 'Motor'),
('N 2345 WX', 'KARTU006', 'Mobil'),
('O 3456 YZ', 'KARTU007', 'Motor'),
('P 5678 LM', 'KARTU008', 'Mobil'),
('Q 6789 OP', 'KARTU009', 'Motor'),

('AE 7798 YZ', 'KARTU010', 'Motor'),
('AG 7766 LM', 'KARTU011', 'Mobil'),
('B 9987 OP', 'KARTU012', 'Motor'),

('S 3321 MJ', 'KARTU013', 'Motor'),
('W 9231 LK', 'KARTU014', 'Mobil'),
('P 5535 QQ', 'KARTU015', 'Motor'),
('M 7783 IU', 'KARTU016', 'Mobil');

-- Memasukkan data parkir
INSERT INTO parkir (id_kartu, nopol, tgl_masuk, jam_masuk, tgl_keluar, jam_keluar, tarif_parkir, id_admin, keterangan) VALUES
-- 1 MINGGU
('KARTU001', 'B 1234 CD', '2025-04-28', '08:30:00', NULL, NULL, 0, 1, 'Masih Parkir'),
('KARTU002', 'L 5678 EF', '2025-04-28', '09:00:00', NULL, NULL, 0, 2, 'Masih Parkir'),
('KARTU003', 'B 6789 EF', '2025-04-28', '11:00:00', NULL, NULL, 0, 1, 'Masih Parkir'),
('KARTU004', 'C 3456 GH', '2025-04-28', '12:00:00', NULL, NULL, 0, 2, 'Masih Parkir'),

('KARTU010', 'AE 7798 YZ', '2025-04-28', '09:00:00', NULL, NULL, 0, 2, 'Masih Parkir'),
('KARTU011', 'AG 7766 LM', '2025-04-28', '11:00:00', NULL, NULL, 0, 1, 'Masih Parkir'),
('KARTU012', 'B 9987 OP', '2025-04-28', '12:00:00', NULL, NULL, 0, 2, 'Masih Parkir'),

('KARTU001', 'I 2345 RS', '2025-04-28', '08:30:00', '2025-04-28', '09:30:00', 0, 1, 'Sudah Keluar'),
('KARTU002', 'J 5678 VW', '2025-04-28', '09:00:00', '2025-04-28', '10:30:00', 0, 2, 'Sudah Keluar'),
('KARTU003', 'K 3456 ST', '2025-04-28', '11:00:00', '2025-04-28', '12:30:00', 0, 1, 'Sudah Keluar'),
('KARTU004', 'L 4567 XY', '2025-04-28', '12:00:00', '2025-04-28', '13:30:00', 0, 2, 'Sudah Keluar'),

-- 1 BULAN 
('KARTU005', 'D 7890 IJ', '2025-04-05', '07:45:00', '2025-04-05', '08:45:00', 0, 1, 'Sudah Keluar'),
('KARTU006', 'E 3456 KL', '2025-04-05', '10:00:00', '2025-04-05', '11:00:00', 0, 2, 'Sudah Keluar'),
('KARTU007', 'F 4567 LM', '2025-04-05', '09:00:00', '2025-04-05', '10:15:00', 0, 1, 'Sudah Keluar'),
('KARTU008', 'G 2345 OP', '2025-04-05', '06:30:00', '2025-04-05', '07:30:00', 0, 2, 'Sudah Keluar'),
('KARTU009', 'H 6789 PQ', '2025-04-05', '08:00:00', '2025-04-05', '09:30:00', 0, 1, 'Sudah Keluar'),

('KARTU005', 'M 2345 QR', '2025-04-05', '07:45:00', '2025-04-05', '08:45:00', 0, 1, 'Sudah Keluar'),
('KARTU006', 'N 2345 WX', '2025-04-05', '10:00:00', '2025-04-05', '11:00:00', 0, 2, 'Sudah Keluar'),
('KARTU007', 'O 3456 YZ', '2025-04-05', '09:00:00', '2025-04-05', '10:15:00', 0, 1, 'Sudah Keluar'),
('KARTU008', 'P 5678 LM', '2025-04-05', '06:30:00', '2025-04-05', '07:30:00', 0, 2, 'Sudah Keluar'),
('KARTU009', 'Q 6789 OP', '2025-04-05', '08:00:00', '2025-04-05', '09:30:00', 0, 1, 'Sudah Keluar'),

-- 1 TAHUN YANG LALU (April 2024)
('KARTU013', 'S 3321 MJ', '2024-04-28', '08:30:00', '2024-04-28', '10:00:00', 0, 1, 'Sudah Keluar'),
('KARTU014', 'W 9231 LK', '2024-04-28', '09:00:00', '2024-04-28', '10:45:00', 0, 2, 'Sudah Keluar'),
('KARTU015', 'P 5535 QQ', '2024-04-28', '11:00:00', '2024-04-28', '12:15:00', 0, 1, 'Sudah Keluar'),
('KARTU016', 'M 7783 IU', '2024-04-28', '12:00:00', '2024-04-28', '13:30:00', 0, 2, 'Sudah Keluar');

-- Menampilkan Data Setiap Tabel
SELECT * FROM departemen;
SELECT * FROM jabatan;
SELECT * FROM karyawan;
SELECT * FROM adminn;
SELECT * FROM kendaraan;
SELECT * FROM parkir;

-- Menghapus Data
DROP DATABASE db_parkir;

-- 1. 
-- BEFORE INSERT (memastikan saldo tidak boleh negatif saat menambah karyawan)
DELIMITER //

CREATE TRIGGER before_insert_karyawan
BEFORE INSERT ON karyawan
FOR EACH ROW
BEGIN
    IF NEW.saldo < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo tidak boleh negatif!';
    END IF;
END//

DELIMITER ;

INSERT INTO karyawan (nik, nama_karyawan, tgl_lahir, jk, id_departemen, id_jabatan, tgl_masuk, id_kartu, saldo)
VALUES ('865290865', 'Sumiarti', '1999-07-10', 'L', 1, 1, '2024-05-05', 'KARTU021', -100);

DROP TRIGGER before_insert_karyawan;

-- BEFORE UPDATE (memastikan bahwa data karyawan tidak bisa diubah ketika kendaraan yang dimilikinya masih terparkir)
DELIMITER //
CREATE TRIGGER before_update_karyawan
BEFORE UPDATE ON karyawan
FOR EACH ROW
BEGIN
    -- Memastikan jika karyawan memiliki kendaraan yang terparkir
    IF EXISTS (SELECT 1 FROM parkir WHERE id_kartu = NEW.id_kartu AND keterangan = 'Masih Parkir') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak dapat mengubah data karyawan karena kendaraan masih terparkir!';
    END IF;
END//

DELIMITER ;

UPDATE karyawan
SET nama_karyawan = 'Tinanto'
WHERE id_karyawan = 13;

DROP TRIGGER before_update_karyawan;

-- BEFORE DELETE (untuk mencegah penghapusan data karyawan jika kendaraan mereka masih terparkir)
DELIMITER //

CREATE TRIGGER before_delete_karyawan
BEFORE DELETE ON karyawan
FOR EACH ROW
BEGIN
    -- Cek apakah ada kendaraan yang masih terparkir
    IF EXISTS (
        SELECT 1
        FROM kendaraan k
        JOIN parkir p ON k.nopol = p.nopol
        WHERE k.id_kartu = OLD.id_kartu
          AND p.keterangan = 'Masih Parkir'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak dapat menghapus data karyawan karena kendaraan masih terparkir!';
    END IF;
END//

DELIMITER ;

DELETE FROM karyawan WHERE id_karyawan = 2;

DROP TRIGGER before_delete_karyawan;

-- 2. 
-- AFTER INSERT(memastikan bahwa ketika ada data yang dimasukkan ke tabel kendaraan, tipe kendaraan yang diterima hanya 'Mobil' atau 'Motor')
DELIMITER //

CREATE TRIGGER after_insert_kendaraan
AFTER INSERT ON kendaraan
FOR EACH ROW
BEGIN
    IF NEW.tipe_kendaraan NOT IN ('Mobil', 'Motor') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipe kendaraan tidak valid!';
    END IF;
END//

DELIMITER ;

INSERT INTO kendaraan (nopol, id_kartu, tipe_kendaraan)
VALUES ('B 9876 GG', 'KARTU002', 'Sepeda');

DROP TRIGGER after_insert_kendaraan;

-- AFTER UPDATE (untuk mengelola saldo karyawan secara otomatis saat kendaraan yang diparkir keluar)
DELIMITER //

CREATE TRIGGER after_update_saldo_karyawan
AFTER UPDATE ON parkir
FOR EACH ROW
BEGIN
    -- Mengecek apakah status kendaraan telah berubah menjadi 'Sudah Keluar'
    IF NEW.keterangan = 'Sudah Keluar' AND NEW.tarif_parkir > 0 THEN
        -- Mengecek apakah saldo mencukupi
        IF (SELECT saldo FROM karyawan WHERE id_kartu = NEW.id_kartu) >= NEW.tarif_parkir THEN
            -- Jika saldo cukup, lakukan pengurangan
            UPDATE karyawan
            SET saldo = saldo - NEW.tarif_parkir
            WHERE id_kartu = NEW.id_kartu;
        ELSE
            -- Jika saldo tidak mencukupi, munculkan error
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Saldo tidak mencukupi untuk membayar tarif parkir.';
        END IF;
    END IF;
END//

DELIMITER ;

UPDATE parkir
SET keterangan = 'Sudah Keluar', tarif_parkir = 10
WHERE nopol = 'C 3456 GH';

DROP TRIGGER after_update_saldo_karyawan;

-- AFTER DELETE (menghapus data kendaraan milik karyawan yang dihapus agar tidak ada kendaraan yang tidak memiliki pemilik)
DELIMITER //

CREATE TRIGGER after_delete_karyawan
AFTER DELETE ON karyawan
FOR EACH ROW
BEGIN
    DELETE FROM kendaraan
    WHERE id_kartu = OLD.id_kartu;
END//

DELIMITER ;

DELETE FROM karyawan WHERE id_kartu = 'KARTU002';

DROP TRIGGER after_delete_karyawan;
