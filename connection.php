<?php
    //define the constanta
    define('HOST','localhost');
    define('USER','root');
    define('PASS','');
    define('DB','perusahaan');

    //connection to database
    $con = mysqli_connect(HOST,USER,PASS,DB) or die ('unable to connect');

?>