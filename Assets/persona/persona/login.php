<?php
header('Content-Type: application/json');

$conn = new mysqli('localhost', 'root', '', 'dbname');

if ($conn->connect_error) {
    die('Connection Error : ' . $conn->connect_error);
}

$return = array();
$return['error'] = false;
$return['message'] = '';
$return['success'] = false;

if (isset($_POST['username']) && isset($_POST['password'])) {
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    $sql = "SELECT * FROM users WHERE username = '$username'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        if (password_verify($password, $row['password'])) {
            $return['success'] = true;
            $return['message'] = 'Login successful';
        } else {
            $return['error'] = true;
            $return['message'] = 'Incorrect password';
        }
    } else {
        $return['error'] = true;
        $return['message'] = 'Username not found';
    }
} else {
    $return['error'] = true;
    $return['message'] = 'Error!';
}

$conn->close();

echo json_encode($return);
