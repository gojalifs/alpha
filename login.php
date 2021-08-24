<?php
    require "connection.php";

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $response = array();
        $id = $_POST['id'];
        $pwd = $_POST['tgl_lahir'];

        $check = "SELECT * FROM user WHERE id = '$id' and tgl_lahir = '$pwd'";
        $result = mysqli_fetch_array(mysqli_query($con, $check));

        if (isset($result)) {
            $response['value'] = 1;
            $response['message'] = 'Login Anda Berhasil';
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = 'Login anda gagal';
            echo json_encode($response);
        }
    }

?>