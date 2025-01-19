<?php

$dsn = "mysql:host=localhost;dbname=library-mysql;charset=utf8mb4";
$username = "root"; 
$password = "";     

try {

    $pdo = new PDO($dsn, $username, $password);

 
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
  
    die(json_encode(["success" => false, "message" => "Database connection failed: " . $e->getMessage()]));
}
