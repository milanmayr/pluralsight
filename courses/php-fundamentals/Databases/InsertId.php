<?php

$dbPassword = "PHPFundamentals";
$dbUserName = "PHPFundamentals";
$dbServer = "172.17.0.4:3306";
$dbName = "PHPFundamentals";

$connection = new mysqli($dbServer, $dbUserName, $dbPassword, $dbName);

if($connection->connect_errno)
{
    exit("Database Connection failed. Reason: ".$connection->connect_error);
}

$query = "INSERT INTO Authors (first_name, last_name, pen_name) VALUES ('John Ronald Reuel', 'Tolkien', 'J.R.R. Tolkien')";

$connection->query($query);

echo "Newly Created Author Id: ".$connection->insert_id;

$connection->close();