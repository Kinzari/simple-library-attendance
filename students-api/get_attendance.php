<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

require 'db.php';

try {
    $stmt = $pdo->query("
        SELECT 
            student_id,
            CONCAT(family_name, ', ', first_name, ' ', COALESCE(middle_name, ''), ' ', COALESCE(suffix, '')) AS student_name,
            year_level,
            course,
            TIME_FORMAT(check_in_time, '%H:%i:%s') AS check_in_time
        FROM attendance
        ORDER BY check_in_time DESC
    ");
    $attendance = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['success' => true, 'data' => $attendance]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
