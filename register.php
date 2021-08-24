<?php
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        //get the value
        $name = $_POST['nama'];
        $avatar = $_POST['avatar'];
        $hp = $_POST['hp'];
        $birth = $_POST['tgl_lahir'];
        $gender = $_POST['gender'];
        $alamat = $_POST['alamat'];

        //SQL Syntax
        //$sql = "INSERT INTO `namatabel` ('nama kolom', 'nama kolom') VALUES ('$variabel di atas')";
        $sql = "INSERT INTO id_karyawan ('id', 'nama', 'avatar', 'hp', 'tgl_lahir', 'gender', 'alamat') VALUES ('$name', '$avatar', '$hp', '$birth', '$gender', '$alamat' )";

        //import connection database file
        require_once('connection.php');

        //query execution
        if (mysqli_query($con, $sql)) {
            echo 'Berhasil Menambahkan pegawai';
        } else {
            echo 'Gagal Menambahkan Pegawai';
        }
        mysqli_close($con);

    }

?>