function mapYearLevel(year) {
  const levels = {
    1: "1st Year",
    2: "2nd Year",
    3: "3rd Year",
    4: "4th Year",
    5: "5th Year",
  };
  return levels[year] || "Unknown";
}

// student data
document.getElementById("load-data").addEventListener("click", async () => {
  const studentID = document.getElementById("student-id").value.trim();
  if (!studentID) {
    toastr.error("Please enter a valid STUDENT ID");
    return;
  }

  try {
    const response = await axios.post(
      "http://localhost/students-api/main.php",
      {
        student_id: studentID,
      }
    );

    if (response.data && response.data.success) {
      const student = response.data.student;

      // format of students full name
      const middleNameInitial = student.middle_name
        ? `${student.middle_name.charAt(0).toUpperCase()}.`
        : ""; 
      const fullName = `${student.family_name}, ${
        student.first_name
      } ${middleNameInitial} ${student.suffix || ""}`.trim();

      // populating the table with students data
      document.getElementById("student-name").textContent = fullName;
      document.getElementById("student-id-data").textContent =
        student.student_id;
      document.getElementById("year-level").textContent = student.year_level;
      document.getElementById("course").textContent = student.course;
      document.getElementById("check-in-time").textContent = "---";

      // shows the table and the check in button
      document.getElementById("table-container").classList.remove("d-none");
      document.getElementById("check-in-container").classList.remove("d-none");

      toastr.success("Student data loaded successfully");
    } else {
      toastr.error(response.data.message || "Student not found");
    }
  } catch (error) {
    console.error("Error fetching student details:", error);
    toastr.error("Error fetching student details");
  }
});

// submitting attendance
document
  .getElementById("check-in-container")
  .addEventListener("click", async (e) => {
    e.preventDefault();

    const studentID = document
      .getElementById("student-id-data")
      .textContent.trim();

    if (!studentID) {
      toastr.error("No student data loaded.");
      return;
    }

    try {
      const response = await axios.post(
        "http://localhost/students-api/submit_attendance.php",
        {
          student_id: studentID,
          first_name: document
            .getElementById("student-name")
            .textContent.split(",")[1]
            .trim(),
          family_name: document
            .getElementById("student-name")
            .textContent.split(",")[0]
            .trim(),
          year_level: document.getElementById("year-level").textContent,
          course: document.getElementById("course").textContent,
        }
      );

      if (response.data.success) {
        const currentTime = new Date().toLocaleTimeString("en-US", {
          hour12: false,
        });
        document.getElementById("check-in-time").textContent = currentTime;

        // hides check in button and clears input form
        document.getElementById("check-in-container").classList.add("d-none");
        document.getElementById("student-id").value = "";

        toastr.success("Attendance recorded successfully");
      } else {
        toastr.error(response.data.message || "Failed to record attendance");
      }
    } catch (error) {
      console.error("Error while submitting attendance:", error);
      toastr.error("Error while submitting attendance");
    }
  });
