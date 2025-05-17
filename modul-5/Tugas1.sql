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

-- 1. Stored Procedure untuk Menampilkan Data Parkir Selama 1 Bulan Terakhir
DELIMITER //

CREATE PROCEDURE tampil_parkir_1_bulan()
BEGIN
    SELECT *
    FROM parkir
    WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH;
END //

DELIMITER ;

CALL tampil_parkir_1_bulan();
DROP PROCEDURE tampil_parkir_1_bulan;

-- 2. Stored Procedure untuk Menghapus Transaksi Parkir Lebih dari 1 Tahun dengan Status 'Sudah Keluar'
DELIMITER //

CREATE PROCEDURE hapus_transaksi_lebih_1_tahun()
BEGIN
    DELETE FROM parkir
    WHERE tgl_masuk <= CURDATE() - INTERVAL 1 YEAR
    AND keterangan = 'Sudah Keluar';
END //

DELIMITER ;

CALL hapus_transaksi_lebih_1_tahun();
DROP PROCEDURE hapus_transaksi_lebih_1_tahun;

-- 3. Stored Procedure untuk Mengubah Status Transaksi pada Tabel Parkir
DELIMITER //

CREATE PROCEDURE ubah_status_transaksi()
BEGIN
    -- Update status untuk transaksi yang masih parkir
    UPDATE parkir
    SET keterangan = 'Sudah Keluar'
    WHERE keterangan = 'Masih Parkir'
    LIMIT 7;
END //

DELIMITER ;

CALL ubah_status_transaksi();
DROP PROCEDURE tampil_parkir_1_minggu;

-- 4. Stored Procedure untuk Mengedit Data User dengan Kondisi Transaksi Aktif
DELIMITER //

CREATE PROCEDURE edit_user(IN p_id_karyawan INT, IN p_nik VARCHAR(20), IN p_nama_karyawan VARCHAR(100), IN p_tgl_lahir DATE, IN p_jk ENUM('L', 'P'))
BEGIN
    -- Variabel untuk mengecek jumlah transaksi yang masih aktif (belum selesai)
    DECLARE transaksi_aktif INT;
    
    -- Mengecek apakah user masih memiliki transaksi yang belum selesai
    SELECT COUNT(*) INTO transaksi_aktif
    FROM parkir
    WHERE id_kartu = (SELECT id_kartu FROM karyawan WHERE id_karyawan = p_id_karyawan)
    AND keterangan = 'Masih Parkir';

    -- Jika masih ada transaksi aktif, tampilkan pesan kesalahan
    IF transaksi_aktif > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User masih memiliki transaksi yang belum selesai, tidak bisa diedit atau dihapus.';
    ELSE
        -- Jika tidak ada transaksi aktif, lakukan update pada data karyawan
        UPDATE karyawan
        SET nik = p_nik,
            nama_karyawan = p_nama_karyawan,
            tgl_lahir = p_tgl_lahir,
            jk = p_jk
        WHERE id_karyawan = p_id_karyawan;
    END IF;
END //

DELIMITER ;

CALL edit_user(1, '123456789', 'Budi Suparto', '1985-07-15', 'L');
DROP PROCEDURE edit_karyawan;

-- 5. Stored Procedure untuk Mengubah Status Transaksi Berdasarkan Jumlah Transaksi dalam Periode Tertentu
DELIMITER $$

CREATE PROCEDURE update_status_parkir_terakhir()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE id_parkir INT;
    DECLARE jumlah_transaksi INT;
    DECLARE min_transaksi INT;
    DECLARE max_transaksi INT;
    DECLARE STATUS VARCHAR(20);
    DECLARE cur CURSOR FOR 
        SELECT id_parkir, COUNT(*) AS jumlah_transaksi
        FROM parkir
        WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH
        GROUP BY id_parkir;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    -- Cari jumlah transaksi terkecil dan terbesar dalam 1 bulan terakhir
    SELECT MIN(jumlah_transaksi) INTO min_transaksi
    FROM (SELECT COUNT(*) AS jumlah_transaksi
          FROM parkir
          WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH
          GROUP BY id_parkir) AS transaksi;

    SELECT MAX(jumlah_transaksi) INTO max_transaksi
    FROM (SELECT COUNT(*) AS jumlah_transaksi
          FROM parkir
          WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH
          GROUP BY id_parkir) AS transaksi;

    -- Mulai perulangan untuk memeriksa setiap transaksi
    read_loop: LOOP
        FETCH cur INTO id_parkir, jumlah_transaksi;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Tentukan status berdasarkan jumlah transaksi
        IF jumlah_transaksi = min_transaksi THEN
            SET STATUS = 'Non-Aktif';
        ELSEIF jumlah_transaksi = max_transaksi THEN
            SET STATUS = 'Aktif';
        ELSE
            SET STATUS = 'Pasif';
        END IF;

        -- Update status transaksi berdasarkan perhitungan
        UPDATE parkir 
        SET keterangan = STATUS 
        WHERE id_parkir = id_parkir;

    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

CALL update_status_parkir_terakhir();
--
SELECT id_parkir, nopol, tgl_masuk, tarif_parkir, keterangan
FROM parkir
WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH;
--
DROP PROCEDURE update_status_parkir_terakhir;

-- 6. Stored Procedure untuk Menampilkan Jumlah Transaksi Berhasil dalam 1 Bulan Terakhir
DELIMITER $$

CREATE PROCEDURE hitung_transaksi_berhasil()
BEGIN
    DECLARE jumlah_transaksi INT DEFAULT 0;
    DECLARE transaksi_status ENUM('Masih Parkir', 'Sudah Keluar');
    DECLARE done INT DEFAULT FALSE;
    DECLARE transaksi_cursor CURSOR FOR
        SELECT keterangan
        FROM parkir
        WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH; -- Ambil transaksi dalam 1 bulan terakhir

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Membuka cursor untuk memulai looping
    OPEN transaksi_cursor;
    
    -- Looping untuk menghitung transaksi yang berhasil
    transaksi_loop: LOOP
        FETCH transaksi_cursor INTO transaksi_status;
        
        -- Jika cursor sudah tidak memiliki data, keluar dari loop
        IF done THEN
            LEAVE transaksi_loop;
        END IF;
        
        -- Jika transaksi berhasil (status 'Sudah Keluar')
        IF transaksi_status = 'Sudah Keluar' THEN
            SET jumlah_transaksi = jumlah_transaksi + 1;
        END IF;
    END LOOP;

    -- Menampilkan jumlah transaksi yang berhasil
    SELECT jumlah_transaksi AS total_transaksi_berhasil;
    
    -- Menutup cursor setelah selesai
    CLOSE transaksi_cursor;
END $$

DELIMITER ;

CALL hitung_transaksi_berhasil();
SELECT COUNT(*) AS total_transaksi_berhasil
FROM parkir
WHERE tgl_masuk >= CURDATE() - INTERVAL 1 MONTH
  AND keterangan = 'Sudah Keluar';
  
DROP PROCEDURE hitung_transaksi_berhasil;
