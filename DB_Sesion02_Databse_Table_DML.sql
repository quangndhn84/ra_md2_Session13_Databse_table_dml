/*
	Lưu ý: Trong mysql không phân biệt hoa thường: 'a' và 'A' là 1
	Database:
		1. Cú pháp tạo mới 1 database
        CREATE DATABASE [database_name]
        2. Cú pháp xóa 1 database
        DROP DATABASE [database_name]
        3. Sử dụng database - làm việc với database
        USE [database_name]
*/
-- 1. Tạo database có tên session02_db
create database session02_db;
-- 2. Làm việc với CSDL session02_db
use session02_db;
-- 3. Xóa database sesion02_db
drop database session02_db;
/*
	TABLE
    1. Tạo table
    CREATE TABLE [table_name](
		--Khai báo các column trong bảng
        [column_name] [datatype] [0...N constraints]
    )
    2. Xóa table
    DROP TABLE [table_name]
*/

/*
	4. Tạo bảng danh mục sản phẩm gồm các cột: 
		- mã danh mục: int, khóa chính và tự tăng
        - tên danh mục: varchar(100), not null, không được trùng lặp
        - mô tả danh mục: text
        - trạng thái danh mục: bit và mặc định giá trị là 1
*/
create table categories(
	-- primary key: not null + unique
	cat_id int primary key auto_increment,
    cat_name varchar(100) not null unique,
    descriptions text,
    cat_status bit default(1)    
);
/*
	5. Tạo bảng sản phẩm gồm các cột sau:
		- Mã sản phẩm: char(5) khóa chính
        - Tên sản phẩm: varchar(100) not null không trùng lặp
        - Giá: float, not null và có giá trị lớn hơn 0
        - Ngày tạo sản phẩm: date not null
        - Tiêu đề sản phẩm: varchar(200) not null,
        - Mô tả sản phẩm: text
        - trạng thái sản phẩm: bit default(1)
        Lưu ý: Liên kết giữa Danh mục và sản phẩm là 1:N
        - Mã danh mục: int khóa ngoại của bảng sản phẩm tham chiếu tới khóa chính của bảng categories
*/
create table product(
	product_id char(5) primary key,
    product_name varchar(100) not null unique,
    price float not null check(price>0),
    created date not null,
    title varchar(200) not null,
    descriptions text,
    product_status bit default(1),
    cat_id int,
    foreign key(cat_id) references categories(cat_id)
);

-- 6. Xóa bảng product
drop table product;
-- 7. Xóa bảng categories
drop table categories;

-- 8. Thêm cột image có kiểu dữ liệu text vào bảng product
alter table product
	add column image text;
-- 9. Sửa tên cột image thành tên product_image
alter table product
	rename column image to product_image;
-- 10. Sửa kiểu dữ liệu của cột product_image thành varchar(200)
alter table product
	modify column product_image varchar(200);
-- 11. Xóa cột product_image trong bảng product
alter table product
	drop column product_image;
/*
	DML: Các câu lệnh thao tác dữ liệu
    - Thêm dữ liệu vào bảng
    insert into [table_name](column1, column2,....)
    values(value1, value2, .....)
    - Cập nhật dữ liệu trên bảng
    update [table_name]
    set column1 = value1,
		column2 = value2,
        ....
	where condition;
    - Xóa dữ liệu trên bảng
    delete from [table_name] where condition
*/
select * from product;
-- 12. Thêm một sản phẩm đầy đủ thông tin vào bảng product
insert into Product
values('P001','Áo polo',10,'2024-05-30','Áo polo', 'Đây là áo polo',1,1);
-- 13. Thêm 2 sản phẩm đầy đủ thông tin vào bảng product
insert into Product
values ('P002','Quần âu',20,'2024-05-25','Quần âu', 'Đây là quần âu',1,1),
('P003','Váy nữ',30,'2024-05-10','Váy nữ', 'Đây là váy nữ',0,2);
-- 14. Thêm sản phẩm gồm mã sản phẩm, tên sản phẩm, tiêu đề, giá, ngày tạo, mã danh mục
insert into Product(product_id, product_name,title,price,created,cat_id)
values('P004','Vòng cổ','Vòng cổ',50,'2024-04-09',3);
-- 15. Cập nhật title của sản phẩm có mã là P003 thành 'Chân váy nữ'
update product
	set title = 'Chân váy nữ 123'
    where product_id = 'P003';
-- 16. Cập nhát giá thành 100 và trạng thái là 0 cho sản phẩm P002
update product
	set price = 100,
		product_status = 0
	where product_id = 'P002';
select * from product;
-- 17. Xóa sản phẩm có mã là P004
delete from product where product_id = 'P004';
	



