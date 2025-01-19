<?php
date_default_timezone_set('Asia/Manila'); // PH Timezone

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require 'db.php';

function mapYearLevel($year_level) {
    $levels = [
        1 => '1st Year',
        2 => '2nd Year',
        3 => '3rd Year',
        4 => '4th Year',
        5 => '5th Year'
    ];
    return $levels[$year_level] ?? 'Unknown';
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $student_id = $data['student_id'] ?? null;

    if ($student_id) {
        try {
            $stmt = $pdo->prepare("SELECT * FROM students WHERE student_id = :student_id");
            $stmt->execute(['student_id' => $student_id]);
            $student = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($student) {
                $student['year_level'] = mapYearLevel($student['year_level']);
                echo json_encode(["success" => true, "student" => $student]);
            } else {
                echo json_encode(["success" => false, "message" => "Student not found."]);
            }
        } catch (PDOException $e) {
            echo json_encode(["success" => false, "message" => "Database error: " . $e->getMessage()]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Student ID is required."]);
    }
} else {
    error_log("Invalid request method: " . $_SERVER['REQUEST_METHOD']);
    echo json_encode(["success" => false, "message" => "Invalid request method."]);
}
?>
