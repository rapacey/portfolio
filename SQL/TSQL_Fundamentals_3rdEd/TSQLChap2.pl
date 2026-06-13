#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use Text::Table;

#TSQL Fundamentals - Chapter 2 Exercises
#Robert Pacey

#Define database parameters

my $server = 'localhost';
my $database = 'TSQLV4'; 
my $user = 'sa';
my $password = '0123456789Ta@#';

#Construct the Data Source Name (DSN)

my $dsn = "dbi:ODBC:Driver={ODBC Driver 18 for SQL Server};
	Server=$server;Database=$database;TrustServerCertificate=yes;";

#Open the database connection

my $dbh = DBI -> connect ($dsn,$user,$password, {
			RaiseError	=> 1,		#Die on database errors
			PrintError	=> 0,		#Turn off since raise error is on
			AutoCommit	=> 1, 		#Auto-commit of transactions
			LongReadLen	=> 65336,	#Large text/binary column handling
		}) or die "Connection failed: " . $DBI::errstr;

print "Successfully connect to SQL Server\n";

#Query 1

print "\n=========================================\n";
print " QUERY #1 OUTPUT \n";
print "=========================================\n";

my $sth = $dbh -> prepare( "	
	SELECT orderid, orderdate, custid, empid
	FROM Sales.Orders
	WHERE orderdate >= '20150601'
	AND orderdate < '20150701'
	" );

$sth -> execute();

#Fetch and print the results

print "OrderID | OrderDate | CustID | EmpID\n";
print "------------------------------------\n";

while (my $row = $sth -> fetchrow_hashref()) {
	print "$row->{orderid} | $row->{orderdate} | $row->{custid} | $row->{empid}\n";
}

$sth -> finish();

#Query 2

print "\n=========================================\n";
print " QUERY #2 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare( "
	SELECT orderid, orderdate, custid, empid
	FROM Sales.Orders
	WHERE orderdate = EOMONTH(orderdate);
	" );

$sth -> execute();

my $rows = $sth -> dump_results();

$sth -> finish();

#Query 3

print "\n=========================================\n";
print " QUERY #3 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare( "
	SELECT empid, firstname, lastname
	FROM HR.Employees
	WHERE lastname LIKE '%e%e%';
	" );

$sth -> execute();

#Define the table headers using the statement's column names

my $tb = Text::Table -> new (@{ $sth -> {NAME} });

#Load all the data rows into the table object

while (my @row = $sth -> fetchrow_array()) {
	$tb -> load(\@row);
}

print $tb;

$sth -> finish();

#Query 4

print "\n=========================================\n";
print " QUERY #4 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare( "
	SELECT orderid, SUM(qty*unitprice) AS totalvalue
	FROM Sales.OrderDetails
	GROUP BY orderid
	HAVING SUM(qty*unitprice) > 10000
	ORDER BY totalvalue DESC;
	" );

$sth -> execute();

while ( ( my $orderid, my $totalvalue ) = $sth -> fetchrow_array ) {
	print "Order ID $orderid has a total value of $totalvalue\n";
}

$sth -> finish();

#Query 5

print "\n=========================================\n";
print " QUERY #5 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare ( "
	SELECT empid, lastname
	FROM HR.Employees
	WHERE lastname COLLATE Latin1_General_CS_AS LIKE N'[abcdefghijklmnopqrstuvwxyz]%';
	" );

$sth -> execute();

my @rows = $sth -> dump_results();

$sth -> finish();

#Query 6

print "\n=========================================\n";
print " QUERY #6 OUTPUT \n";
print "=========================================\n";

#Create a composite index 

my $index = $dbh -> do( "
	CREATE INDEX idx_orders_empid_orderdate
	ON Sales.Orders (empid, orderdate);
	" );

$sth = $dbh -> prepare ( "
	SELECT empid, COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY empid
	HAVING MAX(orderdate) < '20160501';
	" );

$sth -> execute();

print "EmpID | NumOrders\n";
print "-----------------\n";

while (my $row = $sth -> fetchrow_hashref()) {
	print "$row->{empid} | $row->{numorders}\n";
}

$sth -> finish();

#Query 7

print "\n=========================================\n";
print " QUERY #7 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare ( "
	SELECT TOP(3) shipcountry, AVG(freight) AS avgfreight
	FROM Sales.Orders
	WHERE orderdate >= '20150101' 
	AND orderdate < '20160101'
	GROUP BY shipcountry
	ORDER BY avgfreight DESC;
	" );

$sth -> execute();

#Define the table headers using the statement's column names

my $tb2 = Text::Table -> new (@{ $sth -> {NAME} });

#Load all the data rows into the table object

while (my @row = $sth -> fetchrow_array()) {
	$tb2 -> load(\@row);
}

print $tb2;

$sth -> finish();

#Query 8

print "\n=========================================\n";
print " QUERY #8 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare ( "
	SELECT custid, orderdate, orderid,

	ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS rownum
	
	FROM Sales.Orders
	ORDER BY custid, rownum;
	" );

$sth -> execute();

@rows = $sth -> dump_results();

$sth -> finish();

#Query 9

print "\n=========================================\n";
print " QUERY #9 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare ("
	SELECT empid, firstname, lastname, titleofcourtesy,
	CASE titleofcourtesy
		WHEN 'Ms.' THEN 'Female'
		WHEN 'Mrs.' THEN 'Female'
		WHEN 'Mr.' THEN 'Male'
		ELSE 'Unknown'
		END AS gender
	FROM HR.Employees
	ORDER BY empid;
	" );

$sth -> execute();

print "EmpID | FirstName | LastName | Gender\n";
print "-------------------------------------\n";

while (my $row = $sth -> fetchrow_hashref()) {
	print "$row->{empid} | $row->{firstname} | $row->{lastname} | $row->{gender}\n";
}

$sth -> finish();

#Query 10

print "\n=========================================\n";
print " QUERY #10 OUTPUT \n";
print "=========================================\n";

$sth = $dbh -> prepare ( "
	SELECT custid, region
	FROM Sales.Customers
	ORDER BY
		CASE WHEN region IS NULL
		THEN 1 ELSE 0 END, region;
	" );

$sth -> execute();

@rows = $sth -> dump_results();

$sth -> finish();

$dbh -> disconnect()
	or warn "Disconnection failed: $DBI::errstr\n";

exit;

