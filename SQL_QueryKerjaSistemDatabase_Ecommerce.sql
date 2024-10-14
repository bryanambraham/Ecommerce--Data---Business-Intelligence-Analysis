select * from Orders

--memeriksa apakah Total Amount benar
select od.OrderID, sum(p.Price * od.Quantity) as 'Total Amount' 
from OrderDetails od 
join Products p on od.ProductID = p.productID
group by od.OrderId
order by od.OrderID asc


--Average Total Amount Per Bulan
select sum(TotalAmount) as TotalAmount, month(OrderDate) as 'Month'
from Orders
group by month(OrderDate)
order by 'Month'

--Produk Terlaris Tiap Bulan: Identifikasi produk-produk yang paling banyak terjual dalam periode tertentu.
select ProductID, sum(quantity) as 'Total Sold', month(OrderDate)as 'Month' from OrderDetails od join Orders os
on od.OrderID = os.OrderID
group by ProductID,month(OrderDate)
order by 'Month' asc


--Penjualan per Kategori Produk: Lihat penjualan berdasarkan kategori produk untuk mengidentifikasi kategori yang paling menguntungkan.
select p.Category, sum(od.Quantity) as 'Total Sold'
from Products p join OrderDetails od
on p.ProductID = od.ProductID
group by Category
order by 'Total Sold' desc

--Segmentasi Pelanggan berdasarkan Frekuensi Pembelian: Mengelompokkan pelanggan berdasarkan seberapa sering mereka melakukan pembelian.
select CustomerID, count(OrderID) as TotalOrders, sum(TotalAmount) as MoneySpent
from Orders
group by CustomerID
order by TotalOrders desc

--Customer Lifetime Value (CLV): Hitung total nilai pembelian seorang pelanggan selama waktu tertentu untuk mengetahui nilai pelanggan tersebut bagi bisnis.
select CustomerID, sum(TotalAmount) as MoneySpent
from Orders
group by CustomerID
order by MoneySpent desc

--Tingkat Retensi Pelanggan vs Churn Rate: Analisis tingkat pelanggan yang kembali vs yang berhenti membeli.

--Halaman yang Paling Sering Dikunjungi: Identifikasi halaman website mana yang paling sering dikunjungi untuk memahami perilaku browsing pelanggan.
select PageVisited, count(VisitID) as VisitCount, avg(VisitDuration) as AverageVisitDuration
from WebsiteVisits
group by PageVisited
order by AverageVisitDuration desc

--Durasi Kunjungan Rata-Rata per Halaman: Analisis durasi rata-rata pengunjung di setiap halaman untuk mengetahui bagian mana yang paling menarik.
select PageVisited, avg(VisitDuration) as AverageVisitDuration
from WebsiteVisits
group by PageVisited
Order by AverageVisitDuration desc


--Produk dengan Rating Tertinggi dan Terendah: Analisis produk mana yang mendapatkan rating terbaik dan mana yang butuh perbaikan berdasarkan feedback pelanggan.
select p.ProductName, avg(r.Rating) as AverageRating, count(ReviewID) as TotalReviews
from Products p
join Reviews r on p.ProductID = r.ProductID
group by p.ProductName
order by AverageRating desc


--Analisis Sentimen dari Review Teks (Sederhana): Lakukan analisis sentimen sederhana berdasarkan rating dan review teks untuk memahami persepsi pelanggan terhadap produk.
select p.ProductName, P.ProductID, count(case when Rating >= 4 then 1 end) as GoodReview, 
count(case when Rating = 3 then 1 end) as NeutralReview,
count(case when Rating <=2 then 1 end) as BadReview
from Reviews r
join Products p on r.ProductID = p.ProductID
group by p.ProductName, p.ProductID
order by p.ProductID

--Produk yang Sering Out-of-Stock: Identifikasi produk yang sering habis di stok untuk merencanakan restocking dengan lebih baik (makin banyak sold makin kosong) , quantity di database saya adalah banyak jumlah produk yang dibeli
select p.ProductName,p.ProductID,sum(od.Quantity) as ProductSold
from Products p
join OrderDetails od on p.ProductID = od.ProductID
group by p.ProductName,p.ProductID
having sum(od.Quantity)>50
order by ProductSold desc

--Perputaran Stok: Lihat seberapa cepat produk terjual dari stok untuk mengoptimalkan manajemen inventory.
select p.ProductName,count(distinct od.OrderID)as TotalOrder,sum(od.Quantity) as ProductSold
from Products p
join OrderDetails od on p.ProductID = od.ProductID
group by p.ProductName
order by TotalOrder desc