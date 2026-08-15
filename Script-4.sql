CREATE DATABASE AdvancedSQLPractice;
GO

USE AdvancedSQLPractice;
GO


-- =============================================
-- KHOA
-- =============================================
CREATE TABLE Khoa (
    MaKhoa VARCHAR(10) PRIMARY KEY,
    TenKhoa NVARCHAR(100) NOT NULL
);


-- =============================================
-- KHOA TRUONG
-- =============================================
CREATE TABLE KhoaTruong (
    MaKT VARCHAR(10) PRIMARY KEY,
    TenKT NVARCHAR(100) NOT NULL
);


-- =============================================
-- LOP
-- =============================================
CREATE TABLE Lop (
    MaLop VARCHAR(10) PRIMARY KEY,
    TenLop NVARCHAR(100) NOT NULL,
    MaKhoa VARCHAR(10) NOT NULL,

    CONSTRAINT FK_Lop_Khoa
        FOREIGN KEY (MaKhoa)
        REFERENCES Khoa(MaKhoa)
);


-- =============================================
-- SINH VIEN
-- =============================================
CREATE TABLE SinhVien (
    MaSV VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    MaLop VARCHAR(10) NOT NULL,

    CONSTRAINT FK_SinhVien_Lop
        FOREIGN KEY (MaLop)
        REFERENCES Lop(MaLop)
);


-- =============================================
-- MON HOC
-- =============================================
CREATE TABLE MonHoc (
    MaMH VARCHAR(10) PRIMARY KEY,
    TenMH NVARCHAR(100) NOT NULL,
    TinChi INT NOT NULL
);


-- =============================================
-- DIEM
-- =============================================
CREATE TABLE Diem (
    MaSV VARCHAR(10),
    MaMH VARCHAR(10),
    DiemSo DECIMAL(4,2),

    PRIMARY KEY (MaSV, MaMH),

    CONSTRAINT FK_Diem_SinhVien
        FOREIGN KEY (MaSV)
        REFERENCES SinhVien(MaSV),

    CONSTRAINT FK_Diem_MonHoc
        FOREIGN KEY (MaMH)
        REFERENCES MonHoc(MaMH)
);


-- =============================================
-- NHAN VIEN
-- =============================================
CREATE TABLE NhanVien (
    MaNV VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Luong DECIMAL(18,2) NOT NULL
);


-- =============================================
-- LICH SU LUONG
-- =============================================
CREATE TABLE LichSuLuong (
    MaLichSu INT AUTO_INCREMENT PRIMARY KEY,
    MaNV VARCHAR(10),
    LuongCu DECIMAL(18,2),
    LuongMoi DECIMAL(18,2),
    NgayCapNhat DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_LichSuLuong_NhanVien
        FOREIGN KEY (MaNV)
        REFERENCES NhanVien(MaNV)
);


-- =============================================
-- ACCOUNTS
-- =============================================
CREATE TABLE Accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    MaNV VARCHAR(10),
    Username VARCHAR(100) UNIQUE,

    CONSTRAINT FK_Accounts_NhanVien
        FOREIGN KEY (MaNV)
        REFERENCES NhanVien(MaNV)
);


-- =============================================
-- LOGIN HISTORY
-- =============================================
CREATE TABLE LoginHistory (
    LoginID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(100),
    LoginTime DATETIME NULL
);


-- =============================================
-- USERS
-- =============================================
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(100),
    Email VARCHAR(255) NOT NULL
);


-- =============================================
-- SAN PHAM
-- =============================================
CREATE TABLE SanPham (
    MaSP VARCHAR(10) PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,
    SoLuongTon INT NOT NULL DEFAULT 0,
    NgayTao DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- =============================================
-- HOA DON
-- =============================================
CREATE TABLE HoaDon (
    MaHD VARCHAR(10) PRIMARY KEY,
    NgayTao DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- =============================================
-- CHI TIET HOA DON
-- =============================================
CREATE TABLE ChiTietHoaDon (
    MaHD VARCHAR(10),
    MaSP VARCHAR(10),
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,2),

    PRIMARY KEY (MaHD, MaSP),

    CONSTRAINT FK_CTHD_HoaDon
        FOREIGN KEY (MaHD)
        REFERENCES HoaDon(MaHD),

    CONSTRAINT FK_CTHD_SanPham
        FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP)
);
GO

SHOW TABLES LIKE 'SinhVien';
-- =============================================
-- KHOA
-- =============================================
INSERT INTO Khoa (MaKhoa, TenKhoa)
VALUES
('CNTT', N'Công nghệ thông tin'),
('QTKD', N'Quản trị kinh doanh'),
('KT',   N'Kế toán');


-- =============================================
-- KHOA TRUONG
-- =============================================
INSERT INTO KhoaTruong (MaKT, TenKT)
VALUES
('KT01', N'Nguyễn Văn A'),
('KT02', N'Trần Thị B');


-- =============================================
-- LOP
-- =============================================
INSERT INTO Lop (MaLop, TenLop, MaKhoa)
VALUES
('SE01', N'SE01', 'CNTT'),
('SE02', N'SE02', 'CNTT'),
('BA01', N'BA01', 'QTKD'),
('KT01', N'KT01', 'KT');


-- =============================================
-- SINH VIEN
-- =============================================
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, MaLop)
VALUES
('SV001', N'Nguyễn Văn An', '2003-05-10', 'SE01'),
('SV002', N'Trần Văn Bình', '2002-08-15', 'SE01'),
('SV003', N'Lê Thị Chi',    '2004-01-20', 'SE02'),
('SV004', N'Phạm Văn Dũng', '2003-11-11', 'BA01'),
('SV005', N'Hoàng Thị Em',  '2002-03-25', 'KT01');


-- =============================================
-- MON HOC
-- =============================================
INSERT INTO MonHoc (MaMH, TenMH, TinChi)
VALUES
('JAVA', N'Java', 3),
('SQL',  N'Cơ sở dữ liệu', 3),
('WEB',  N'Web Programming', 3),
('OOP',  N'Lập trình hướng đối tượng', 4);


-- =============================================
-- DIEM
-- =============================================
INSERT INTO Diem (MaSV, MaMH, DiemSo)
VALUES
('SV001', 'JAVA', 8.5),
('SV001', 'SQL',  9.0),
('SV001', 'WEB',  7.5),
('SV001', 'OOP',  8.0),

('SV002', 'JAVA', 7.0),
('SV002', 'SQL',  8.0),
('SV002', 'WEB',  6.5),
('SV002', 'OOP',  7.5),

('SV003', 'JAVA', 9.0),
('SV003', 'SQL',  9.5),
('SV003', 'WEB',  8.5),
('SV003', 'OOP',  9.0),

('SV004', 'JAVA', 6.5),
('SV004', 'SQL',  7.0),

('SV005', 'JAVA', 8.0),
('SV005', 'SQL',  8.5);


-- =============================================
-- NHAN VIEN
-- =============================================
INSERT INTO NhanVien (MaNV, HoTen, Luong)
VALUES
('NV001', N'Nguyễn Văn Minh', 15000000),
('NV002', N'Trần Văn Nam',     18000000),
('NV003', N'Lê Thị Hoa',       20000000);


-- =============================================
-- USERS
-- =============================================
INSERT INTO Users (Username, Email)
VALUES
('nguyenvana', 'vana@gmail.com'),
('tranvanb',   'vanb@gmail.com'),
('lethichi',   'chi@gmail.com');


-- =============================================
-- SAN PHAM
-- =============================================
INSERT INTO SanPham
(MaSP, TenSP, DonGia, SoLuongTon)
VALUES
('SP001', N'Laptop',       20000000, 50),
('SP002', N'Chuột',         500000, 100),
('SP003', N'Bàn phím',     1000000, 80),
('SP004', N'Màn hình',     5000000, 40),
('SP005', N'Tai nghe',      800000, 120),
('SP006', N'USB',           300000, 200),
('SP007', N'Webcam',       1500000, 60),
('SP008', N'Ổ cứng SSD',   2500000, 70),
('SP009', N'RAM',          1800000, 90),
('SP010', N'Loa',           900000, 100);


-- =============================================
-- HOA DON
-- =============================================
INSERT INTO HoaDon (MaHD, NgayTao)
VALUES
('HD001', NOW()),
('HD002', NOW()),
('HD003', NOW());


-- =============================================
-- CHI TIET HOA DON
-- =============================================
INSERT INTO ChiTietHoaDon
(MaHD, MaSP, SoLuong, DonGia)
VALUES
('HD001', 'SP001', 2, 20000000),
('HD001', 'SP002', 5, 500000),
('HD001', 'SP003', 3, 1000000),

('HD002', 'SP002', 10, 500000),
('HD002', 'SP004', 4, 5000000),
('HD002', 'SP005', 8, 800000),

('HD003', 'SP001', 3, 20000000),
('HD003', 'SP006', 15, 300000),
('HD003', 'SP008', 6, 2500000);
GO

DELIMITER $$

CREATE TRIGGER TR_SinhVien_CheckAge
BEFORE INSERT ON SinhVien
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.NgaySinh, CURDATE()) < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sinh vien phai du 18 tuoi';
    END IF;
END$$

DELIMITER ;

INSERT INTO SinhVien
(MaSV, HoTen, NgaySinh, MaLop)
VALUES
('SV006', 'Nguyen Van Test', '2003-05-10', 'SE01');

SELECT *
FROM SinhVien
WHERE MaSV = 'SV006';

INSERT INTO SinhVien
(MaSV, HoTen, NgaySinh, MaLop)
VALUES
('SV007', 'Nguoi Chua Du Tuoi', '2012-05-10', 'SE01');

SELECT *
FROM SinhVien
WHERE MaSV = 'SV007';

SELECT *
FROM SinhVien;

SHOW TRIGGERS
WHERE `Trigger` = 'TR_SinhVien_CheckAge';

CREATE TRIGGER TR_ChiTietHoaDon_UpdateStock
AFTER INSERT ON ChiTietHoaDon
FOR EACH ROW
UPDATE SanPham
SET SoLuongTon = SoLuongTon - NEW.SoLuong
WHERE MaSP = NEW.MaSP;

SELECT
    TRIGGER_NAME,
    EVENT_MANIPULATION,
    EVENT_OBJECT_TABLE,
    ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = DATABASE()
AND TRIGGER_NAME = 'TR_ChiTietHoaDon_UpdateStock';

SELECT MaSP, TenSP, SoLuongTon
FROM SanPham
WHERE MaSP = 'SP001';

INSERT INTO ChiTietHoaDon
(MaHD, MaSP, SoLuong, DonGia)
VALUES
('HD004', 'SP001', 2, 20000000);

SELECT MaSP, TenSP, SoLuongTon
FROM SanPham
WHERE MaSP = 'SP001';

CREATE TRIGGER TR_NhanVien_LogSalary
AFTER UPDATE ON NhanVien
FOR EACH ROW
INSERT INTO LichSuLuong
(
    MaNV,
    LuongCu,
    LuongMoi,
    NgayCapNhat
)
SELECT
    NEW.MaNV,
    OLD.Luong,
    NEW.Luong,
    CURRENT_TIMESTAMP
WHERE OLD.Luong <> NEW.Luong;

SELECT
    TRIGGER_NAME,
    EVENT_MANIPULATION,
    EVENT_OBJECT_TABLE,
    ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = DATABASE()
AND TRIGGER_NAME = 'TR_NhanVien_LogSalary';

SELECT *
FROM NhanVien
WHERE MaNV = 'NV001';

UPDATE NhanVien
SET Luong = Luong + 1000000
WHERE MaNV = 'NV001';

SELECT *
FROM LichSuLuong
WHERE MaNV = 'NV001'
ORDER BY MaLichSu DESC;

CREATE TRIGGER TR_Lop_PreventDelete
BEFORE DELETE ON Lop
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM SinhVien
        WHERE MaLop = OLD.MaLop
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong the xoa lop vi lop van con sinh vien';
    END IF;
END

DELETE FROM Lop
WHERE MaLop = 'SE01';

SELECT *
FROM Lop
WHERE MaLop = 'SE01';

INSERT INTO Lop (MaLop, TenLop, MaKhoa)
VALUES ('TEST01', 'Test Class', 'CNTT');

DELETE FROM Lop
WHERE MaLop = 'TEST01';

CREATE TRIGGER TR_NhanVien_CreateAccount
AFTER INSERT ON NhanVien
FOR EACH ROW
INSERT INTO Accounts (MaNV, Username)
VALUES (
    NEW.MaNV,
    LOWER(REPLACE(NEW.HoTen, ' ', ''))
);

SELECT *
FROM Accounts;

INSERT INTO NhanVien
(MaNV, HoTen, Luong)
VALUES
('NV005', 'Nguyen Van A', 12000000);

SELECT *
FROM Accounts
WHERE MaNV = 'NV005';

INSERT INTO NhanVien
(MaNV, HoTen, Luong)
VALUES
('NV999', 'Tran Minh Khoa', 12000000);

SELECT *
FROM Accounts
WHERE MaNV = 'NV999';

CREATE TRIGGER TR_LoginHistory_SetTime
BEFORE INSERT ON LoginHistory
FOR EACH ROW
SET NEW.LoginTime = CURRENT_TIMESTAMP;

INSERT INTO LoginHistory (Username)
VALUES ('testuser');

SELECT
    Username,
    LoginTime,
    CURRENT_TIMESTAMP AS CurrentTime
FROM LoginHistory
WHERE Username = 'testuser'
ORDER BY LoginID DESC
LIMIT 1;

SELECT *
FROM LoginHistory
WHERE Username = 'testuser'
ORDER BY LoginID DESC
LIMIT 1;

CREATE INDEX IDX_NhanVien_MaNV
ON NhanVien(MaNV);

SELECT *
FROM SinhVien
WHERE HoTen LIKE 'A%';

SHOW INDEX FROM NhanVien;

CREATE INDEX IDX_ChiTietHoaDon_MaHD_MaSP
ON ChiTietHoaDon(MaHD, MaSP);

SHOW INDEX FROM ChiTietHoaDon;

CREATE INDEX IDX_SanPham_TenSP
ON SanPham(TenSP);

SHOW INDEX FROM SanPham;

CREATE INDEX IDX_SinhVien_MaLop
ON SinhVien(MaLop);

SHOW INDEX FROM SinhVien;

CREATE INDEX IDX_HoaDon_NgayTao
ON HoaDon(NgayTao);

SHOW INDEX FROM HoaDon;

DROP INDEX IDX_HoaDon_NgayTao
ON HoaDon;

SHOW INDEX FROM HoaDon;

EXPLAIN ANALYZE
SELECT
    h.MaHD,
    h.NgayTao,
    c.MaSP,
    c.SoLuong,
    c.DonGia
FROM HoaDon h
JOIN ChiTietHoaDon c
    ON h.MaHD = c.MaHD
WHERE h.NgayTao >= '2026-01-01'
ORDER BY h.NgayTao;

CREATE INDEX IDX_HoaDon_NgayTao
ON HoaDon(NgayTao);

EXPLAIN ANALYZE
SELECT
    h.MaHD,
    h.NgayTao,
    c.MaSP,
    c.SoLuong,
    c.DonGia
FROM HoaDon h
JOIN ChiTietHoaDon c
    ON h.MaHD = c.MaHD
WHERE h.NgayTao >= '2026-01-01'
ORDER BY h.NgayTao;

DESCRIBE SinhVien;
DESCRIBE Diem;
DESCRIBE MonHoc;

CREATE VIEW V_SinhVien_Diem AS
SELECT
    sv.MaSV,
    sv.HoTen,
    mh.TenMH,
    d.DiemSo,
    CASE
        WHEN d.DiemSo >= 8 THEN 'A'
        WHEN d.DiemSo >= 6.5 THEN 'B'
        WHEN d.DiemSo >= 5 THEN 'C'
        WHEN d.DiemSo >= 4 THEN 'D'
        ELSE 'F'
    END AS DiemChu
FROM SinhVien sv
JOIN Diem d
    ON sv.MaSV = d.MaSV
JOIN MonHoc mh
    ON d.MaMH = mh.MaMH;

SELECT *
FROM V_SinhVien_Diem;

CREATE VIEW V_Lop_SoLuongSinhVien AS
SELECT
    l.MaLop,
    l.TenLop,
    COUNT(sv.MaSV) AS SoLuongSinhVien
FROM Lop l
LEFT JOIN SinhVien sv
    ON l.MaLop = sv.MaLop
GROUP BY
    l.MaLop,
    l.TenLop;

SELECT *
FROM V_Lop_SoLuongSinhVien;

CREATE VIEW V_SinhVien_DiemCaoNhat AS
SELECT
    sv.MaSV,
    sv.HoTen,
    AVG(d.DiemSo) AS DiemTrungBinh
FROM SinhVien sv
JOIN Diem d
    ON sv.MaSV = d.MaSV
GROUP BY
    sv.MaSV,
    sv.HoTen
HAVING AVG(d.DiemSo) = (
    SELECT MAX(DiemTrungBinh)
    FROM (
        SELECT AVG(DiemSo) AS DiemTrungBinh
        FROM Diem
        GROUP BY MaSV
    ) AS X
);

SELECT *
FROM V_SinhVien_DiemCaoNhat;

CREATE VIEW V_DoanhThu_HoaDon AS
SELECT
    hd.MaHD,
    hd.NgayTao,
    SUM(ct.SoLuong * ct.DonGia) AS TongTien
FROM HoaDon hd
JOIN ChiTietHoaDon ct
    ON hd.MaHD = ct.MaHD
GROUP BY
    hd.MaHD,
    hd.NgayTao;

SELECT *
FROM V_DoanhThu_HoaDon;

-- =========================================
-- CÂU 15: STORED PROCEDURE THÊM SINH VIÊN
-- =========================================

DROP PROCEDURE IF EXISTS AddStudent;

DELIMITER $$

CREATE PROCEDURE AddStudent(
    IN p_MaSV VARCHAR(20),
    IN p_HoTen VARCHAR(100),
    IN p_NgaySinh DATE,
    IN p_MaLop VARCHAR(20)
)
BEGIN
    -- Kiểm tra MaSV đã tồn tại chưa
    IF EXISTS (
        SELECT 1
        FROM SinhVien
        WHERE MaSV = p_MaSV
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'MaSV da ton tai!';

    -- Kiểm tra lớp có tồn tại không
    ELSEIF NOT EXISTS (
        SELECT 1
        FROM Lop
        WHERE MaLop = p_MaLop
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lop khong ton tai!';

    -- Nếu tất cả đều hợp lệ
    ELSE

        INSERT INTO SinhVien(
            MaSV,
            HoTen,
            NgaySinh,
            MaLop
        )
        VALUES(
            p_MaSV,
            p_HoTen,
            p_NgaySinh,
            p_MaLop
        );

    END IF;
END $$

DELIMITER ;

CALL AddStudent(
    'SV999',
    'Nguyen Van Test',
    '2005-01-01',
    'L01'
);

-- =========================================
-- CÂU 16: CẬP NHẬT LƯƠNG THEO %
-- =========================================

DROP PROCEDURE IF EXISTS UpdateSalary;

DELIMITER $$

CREATE PROCEDURE UpdateSalary(
    IN p_MaNV VARCHAR(20),
    IN p_percent_increase DECIMAL(5,2)
)
BEGIN

    -- Kiểm tra nhân viên tồn tại
    IF NOT EXISTS (
        SELECT 1
        FROM NhanVien
        WHERE MaNV = p_MaNV
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nhan vien khong ton tai!';

    ELSE

        UPDATE NhanVien
        SET Luong = Luong * (1 + p_percent_increase / 100)
        WHERE MaNV = p_MaNV;

    END IF;

END $$

DELIMITER ;

CALL UpdateSalary('NV01', 10);

SELECT MaNV, Luong
FROM NhanVien
WHERE MaNV = 'NV01';

-- =========================================
-- CÂU 17: FUNCTION TÍNH TUỔI
-- =========================================

DROP FUNCTION IF EXISTS TinhTuoi;

DELIMITER $$

CREATE FUNCTION TinhTuoi(
    p_NgaySinh DATE
)
RETURNS INT
DETERMINISTIC
BEGIN

    RETURN TIMESTAMPDIFF(
        YEAR,
        p_NgaySinh,
        CURDATE()
    );

END $$

DELIMITER ;

SELECT TinhTuoi('2005-08-20') AS Tuoi;

SELECT
    MaSV,
    HoTen,
    NgaySinh,
    TinhTuoi(NgaySinh) AS Tuoi
FROM SinhVien;

-- =========================================
-- CÂU 18: FUNCTION TÍNH GPA 4.0
-- =========================================

DROP FUNCTION IF EXISTS TinhGPA;

DELIMITER $$

CREATE FUNCTION TinhGPA(
    p_MaSV VARCHAR(20)
)
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN

    DECLARE v_GPA DECIMAL(4,2);

    SELECT
        SUM(d.Diem * mh.TinChi) / SUM(mh.TinChi)
    INTO v_GPA
    FROM Diem d
    JOIN MonHoc mh
        ON d.MaMon = mh.MaMon
    WHERE d.MaSV = p_MaSV;

    RETURN IFNULL(v_GPA, 0);

END $$

DELIMITER ;

SELECT TinhGPA('SV01') AS GPA;

-- =========================================
-- CÂU 19: BẢNG KHOA TRƯỞNG
-- =========================================

CREATE TABLE KhoaTruong (
    MaKhoaTruong INT PRIMARY KEY AUTO_INCREMENT,
    TenKhoaTruong VARCHAR(100) NOT NULL
);

-- =========================================
-- BẢNG KHOA
-- =========================================

CREATE TABLE Khoa (
    MaKhoa INT PRIMARY KEY AUTO_INCREMENT,
    TenKhoa VARCHAR(100) NOT NULL,
    MaKhoaTruong INT,

    CONSTRAINT FK_Khoa_KhoaTruong
        FOREIGN KEY (MaKhoaTruong)
        REFERENCES KhoaTruong(MaKhoaTruong)
);

-- =========================================
-- BẢNG LỚP
-- =========================================

CREATE TABLE Lop (
    MaLop VARCHAR(20) PRIMARY KEY,
    TenLop VARCHAR(100) NOT NULL,
    MaKhoa INT,

    CONSTRAINT FK_Lop_Khoa
        FOREIGN KEY (MaKhoa)
        REFERENCES Khoa(MaKhoa)
);

-- =========================================
-- BẢNG SINH VIÊN
-- =========================================

CREATE TABLE SinhVien (
    MaSV VARCHAR(20) PRIMARY KEY,
    TenSV VARCHAR(100) NOT NULL,
    MaLop VARCHAR(20),

    CONSTRAINT FK_SinhVien_Lop
        FOREIGN KEY (MaLop)
        REFERENCES Lop(MaLop)
);

-- =========================================
-- CÂU 20: KHÁCH HÀNG
-- =========================================

CREATE TABLE KhachHang (
    MaKH INT PRIMARY KEY AUTO_INCREMENT,
    TenKH VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(255)
);

-- =========================================
-- ĐƠN HÀNG
-- =========================================

CREATE TABLE DonHang (
    MaDH INT PRIMARY KEY,
    MaKH INT NOT NULL,

    CONSTRAINT FK_DonHang_KhachHang
        FOREIGN KEY (MaKH)
        REFERENCES KhachHang(MaKH)
);

-- =========================================
-- SẢN PHẨM
-- =========================================

CREATE TABLE SanPham (
    MaSP INT PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL,
    DonGia DECIMAL(15,2) NOT NULL
);

-- =========================================
-- CHI TIẾT ĐƠN HÀNG
-- =========================================

CREATE TABLE ChiTietDonHang (
    MaDH INT,
    MaSP INT,
    SoLuong INT NOT NULL,

    PRIMARY KEY (MaDH, MaSP),

    CONSTRAINT FK_ChiTietDonHang_DonHang
        FOREIGN KEY (MaDH)
        REFERENCES DonHang(MaDH),

    CONSTRAINT FK_ChiTietDonHang_SanPham
        FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP)
);

SELECT *
FROM SinhVien
WHERE MaSV = 'SV999';


SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

SHOW TABLES;
SHOW TRIGGERS;
SELECT * FROM Accounts;
SELECT * FROM ChiTietHoaDon;
SELECT * FROM Diem;
SELECT * FROM HoaDon;
SELECT * FROM Khoa;
SELECT * FROM KhoaTruong;
SELECT * FROM LichSuLuong;
SELECT * FROM LoginHistory;
SELECT * FROM Lop;
SELECT * FROM MonHoc;
SELECT * FROM NhanVien;
SELECT * FROM SanPham;
SELECT * FROM SinhVien;
SELECT * FROM Users;
SHOW TABLES;