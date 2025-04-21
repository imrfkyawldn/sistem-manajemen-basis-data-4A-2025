CREATE DATABASE akademik;
USE akademik;

-- Membuat tabel kota
CREATE TABLE kota (
    id_kota INT AUTO_INCREMENT PRIMARY KEY,
    nama_kota VARCHAR(100) NOT NULL
);

-- Membuat tabel dosen
CREATE TABLE dosen (
    nip_dosen VARCHAR(20) PRIMARY KEY,
    nama_dosen VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    id_kota INT NOT NULL,
    FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON DELETE CASCADE
);

-- Membuat tabel mahasiswa
CREATE TABLE mahasiswa (
    nim VARCHAR(20) PRIMARY KEY,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    id_kota INT NOT NULL,
    FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON DELETE CASCADE
);

-- Membuat tabel matakuliah
CREATE TABLE matakuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100) NOT NULL,
    sks INT NOT NULL,
    semester INT NOT NULL,
    nip_dosen VARCHAR(20),
    FOREIGN KEY (nip_dosen) REFERENCES dosen(nip_dosen) ON DELETE SET NULL
);

-- Membuat tabel asisten_dosen
CREATE TABLE asisten_dosen (
    id_asisten INT AUTO_INCREMENT PRIMARY KEY,
    nama_asisten VARCHAR(100) NOT NULL,
    no_telp VARCHAR(15) NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    email VARCHAR(100) NOT NULL,
    nip_dosen VARCHAR(20),
    FOREIGN KEY (nip_dosen) REFERENCES dosen(nip_dosen) ON DELETE SET NULL
);

-- Membuat tabel asisten_matakuliah
CREATE TABLE asisten_matakuliah (
    id_asisten INT,
    kode_mk VARCHAR(10),
    PRIMARY KEY (id_asisten, kode_mk),
    FOREIGN KEY (id_asisten) REFERENCES asisten_dosen(id_asisten) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Membuat tabel KRS (Kartu Rencana Studi)
CREATE TABLE krs (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(20) NOT NULL,
    kode_mk VARCHAR(10) NOT NULL,
    semester INT NOT NULL,
    tahun_akademik VARCHAR(10) NOT NULL,
    FOREIGN KEY (nim) REFERENCES mahasiswa(nim) ON DELETE CASCADE,
    FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk) ON DELETE CASCADE
);

-- Insert data ke tabel kota
INSERT INTO kota (nama_kota) VALUES
('Bondowoso'), ('Kediri'), ('Sumenep'), ('Bojonegoro'), ('Surabaya'),
('Jombang'), ('Sidoarjo'), ('Malang'), ('Kamal'), ('Bangkalan'),
('Nganjuk'), ('Depok'), ('Tulungagung');

-- Insert data ke tabel dosen
INSERT INTO dosen (nip_dosen, nama_dosen, jenis_kelamin, id_kota) VALUES
('1970010112345678', 'Dwi Kuswanto, S. Pd., M. T.', 'L', 1),
('1970010112345865', 'Rosida Vivin Nahari, S. Kom., M. T.', 'P', 2),
('1970010112345995', 'Sri Herawati, S. Kom, M. Kom.', 'P', 3),
('1970010112345776', 'Fitri Damayanti, S. Kom, M. Kom.', 'P', 4),
('1970010112345666', 'Doni Abdul Fatah, S. Kom., M. Kom.', 'L', 4),
('1970010112345999', 'Firli Irhamni, S. T., M. Kom.', 'L', 5),
('1970010112345961', 'Eza Rahmanita, S. T, M. T.', 'P', 6),
('1970010112345198', 'Dr. Wahyudi Setiawan, S. Kom, M. Kom.', 'L', 7),
('1970010112345115', 'Mohammad Syarief, S. T., M. Cs.', 'L', 3),
('1970010112345696', 'Yudha Dwi Putra Negara, S. Kom., M. Kom.', 'L', 8);

-- Insert data ke tabel mahasiswa
INSERT INTO mahasiswa (nim, nama_mahasiswa, jenis_kelamin, id_kota) VALUES
('230441100134', 'Muhammad Rifky Awaludin', 'L', 9),
('230441100047', 'Muhammad Maulana Khanif', 'L', 7),
('230441100036', 'Tri Citra Ambarwati', 'P', 7),
('230441100034', 'Agus Wedi', 'L', 10),
('230441100142', 'Dio Ramadhani Pratama', 'L', 3),
('230441100179', 'Taufik Ikram Jamil', 'L', 10),
('230441100088', 'Surya Baihaqi Ahmad', 'L', 11),
('230441100080', 'Waldhan Putranda Pratama', 'L', 12),
('230441100022', 'Lanny Aprilia', 'P', 7),
('230441100192', 'Ahmad Rikhan Arbai', 'L', 13);

-- Insert data ke tabel matakuliah
INSERT INTO matakuliah (kode_mk, nama_mk, sks, semester, nip_dosen) VALUES
('MK001', 'Desain Manajemen Jaringan', 3, 2, '1970010112345678'),
('MK002', 'Manajemen Proyek IT', 3, 4, '1970010112345865'),
('MK003', 'Sistem Pendukung Keputusan', 3, 4, '1970010112345995'),
('MK004', 'Kepemimpinan dan Manajemen Organisasi', 2, 1, '1970010112345776'),
('MK005', 'E-Business dan E-Commerce', 3, 3, '1970010112345666'),
('MK006', 'Rekayasa Perangkat Lunak', 3, 3, '1970010112345999'),
('MK007', 'Perencanaan Sumber Daya Perusahaan', 3, 4, '1970010112345961'),
('MK008', 'Data Mining', 3, 4, '1970010112345198'),
('MK009', 'Sistem Manajemen Basis Data', 4, 4, '1970010112345115'),
('MK010', 'Etika Profesi Sistem Informasi', 2, 2, '1970010112345696');

-- Insert data ke tabel asisten_dosen
INSERT INTO asisten_dosen (nama_asisten, no_telp, jenis_kelamin, email, nip_dosen) VALUES
('Dina Sari', '081234567890', 'P', 'dina.sari@example.com', '1970010112345678'),
('Budi Setiawan', '081298765432', 'L', 'budi.setiawan@example.com', '1970010112345865'),
('Sucipto', '085612345678', 'L', 'sucipto@example.com', '1970010112345995'),
('Rizki Pratama', '082134567899', 'L', 'rizki.pratama@example.com', '1970010112345776'),
('Andi Wijaya', '083245678912', 'L', 'andi.wijaya@example.com', '1970010112345666'),
('Tina Rahmawati', '081345678921', 'P', 'tina.rahmawati@example.com', '1970010112345999'),
('Wahyu Prasetyo', '085678912345', 'L', 'wahyu.prasetyo@example.com', '1970010112345961');

-- Insert data ke tabel asisten_matakuliah
INSERT INTO asisten_matakuliah (id_asisten, kode_mk) VALUES
(1, 'MK001'), (1, 'MK002'), (2, 'MK003'), (2, 'MK004'),
(3, 'MK005'), (4, 'MK006'), (4, 'MK007'), (5, 'MK008'),
(6, 'MK009'), (6, 'MK010'), (7, 'MK001');

-- Insert data ke tabel KRS dengan semua semester 4
INSERT INTO krs (nim, kode_mk, semester, tahun_akademik) VALUES
('230441100134', 'MK001', 4, '2024/2025'),
('230441100134', 'MK002', 4, '2024/2025'),
('230441100134', 'MK003', 4, '2024/2025'),

('230441100047', 'MK004', 4, '2024/2025'),
('230441100047', 'MK005', 4, '2024/2025'),
('230441100047', 'MK006', 4, '2024/2025'),

('230441100036', 'MK007', 4, '2024/2025'),
('230441100036', 'MK008', 4, '2024/2025'),
('230441100036', 'MK009', 4, '2024/2025'),

('230441100034', 'MK001', 4, '2024/2025'),
('230441100034', 'MK003', 4, '2024/2025'),
('230441100034', 'MK005', 4, '2024/2025'),

('230441100142', 'MK002', 4, '2024/2025'),
('230441100142', 'MK004', 4, '2024/2025'),
('230441100142', 'MK006', 4, '2024/2025'),

('230441100179', 'MK007', 4, '2024/2025'),
('230441100179', 'MK008', 4, '2024/2025'),
('230441100179', 'MK009', 4, '2024/2025'),

('230441100088', 'MK001', 4, '2024/2025'),
('230441100088', 'MK002', 4, '2024/2025'),
('230441100088', 'MK003', 4, '2024/2025'),

('230441100080', 'MK004', 4, '2024/2025'),
('230441100080', 'MK005', 4, '2024/2025'),
('230441100080', 'MK006', 4, '2024/2025'),

('230441100022', 'MK007', 4, '2024/2025'),
('230441100022', 'MK008', 4, '2024/2025'),
('230441100022', 'MK009', 4, '2024/2025'),

('230441100192', 'MK001', 4, '2024/2025'),
('230441100192', 'MK003', 4, '2024/2025'),
('230441100192', 'MK005', 4, '2024/2025');

-- Menampilkan semua data
SELECT * FROM kota;
SELECT * FROM dosen; 
SELECT * FROM mahasiswa; 
SELECT * FROM matakuliah; 
SELECT * FROM asisten_dosen; 
SELECT * FROM asisten_matakuliah; 
SELECT * FROM krs;

-- Mengubah Nama Tabel
ALTER TABLE dosen RENAME TO pengajar;

-- Menghapus Database
DROP DATABASE akademik;
