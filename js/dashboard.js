let attendanceData = [];

const renderTable = (data) => {
  const table = document.getElementById("attendanceTable");
  table.innerHTML = data
    .map(
      (entry) => `
      <tr>
        <td>${entry.student_name || "N/A"}</td>
        <td>${entry.student_id || "N/A"}</td>
        <td>${entry.year_level || "N/A"}</td>
        <td>${entry.course || "N/A"}</td>
        <td>${entry.check_in_time || "N/A"}</td>
      </tr>
    `
    )
    .join("");
};

const filterAttendance = () => {
  const searchQuery = document.getElementById("search").value.toLowerCase();
  const yearLevel = document.getElementById("yearLevel").value;
  const course = document.getElementById("course").value;

  const filteredData = attendanceData.filter((entry) => {
    const matchesSearch =
      (entry.student_name || "").toLowerCase().includes(searchQuery) ||
      (entry.student_id || "").includes(searchQuery);
    const matchesYearLevel =
      yearLevel === "All" || entry.year_level === yearLevel;
    const matchesCourse = course === "All" || entry.course === course;

    return matchesSearch && matchesYearLevel && matchesCourse;
  });

  renderTable(filteredData);
};

const endDayEvent = async () => {
  try {
    const response = await axios.post(
      "http://localhost/students-api/archive_attendance.php",
      {}
    );

    if (response.data.success) {
      alert("Day has ended successfully!");
    } else {
      alert("Failed to end the day.");
    }
  } catch (error) {
    console.error("Error ending the day:", error);
    alert("An error occurred while ending the day.");
  }
};

const fetchAttendanceData = async () => {
  try {
    const response = await axios.get(
      "http://localhost/students-api/get_attendance.php"
    );
    if (response.data.success) {
      attendanceData = response.data.data;
      renderTable(attendanceData);
    } else {
      console.error(response.data.message);
    }
  } catch (error) {
    console.error("Error fetching attendance data:", error);
  }
};

// Initialize the dashboard
fetchAttendanceData();
