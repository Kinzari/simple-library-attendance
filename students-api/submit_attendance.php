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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $student_id = $data['student_id'] ?? null;
    $first_name = $data['first_name'] ?? null;
    $middle_name = $data['middle_name'] ?? null;
    $family_name = $data['family_name'] ?? null;
    $suffix = $data['suffix'] ?? null;
    $year_level = $data['year_level'] ?? null;
    $course = $data['course'] ?? null;

    $current_time = date('H:i:s');

    if ($student_id && $first_name && $family_name && $year_level && $course) {
        try {
            // Prepare and execute query
            $stmt = $pdo->prepare(
                "INSERT INTO attendance (student_id, first_name, middle_name, family_name, suffix, year_level, course, date, check_in_time) 
                 VALUES (:student_id, :first_name, :middle_name, :family_name, :suffix, :year_level, :course, CURDATE(), :check_in_time)"
            );
            $stmt->execute([
                'student_id' => $student_id,
                'first_name' => $first_name,
                'middle_name' => $middle_name,
                'family_name' => $family_name,
                'suffix' => $suffix,
                'year_level' => $year_level,
                'course' => $course,
                'check_in_time' => $current_time
            ]);

            echo json_encode(["success" => true, "message" => "Attendance recorded successfully."]);
        } catch (PDOException $e) {
            echo json_encode(["success" => false, "message" => "Failed to record attendance: " . $e->getMessage()]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "All required fields must be provided."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method."]);
}
