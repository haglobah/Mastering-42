<?php
if(!isset($_POST["comment"])) return;
if($_POST["comment"] == "") return;
$from = "From: " . $_POST["email"];
$link = $_POST["link"];
$to = "it@hacker-school.de";
$subject = $_POST["title"] . ": " . $link;
$message = $link . "\r\n\r\n" . $_POST["comment"];
mail($to, $subject, $message, $from);
header("location: ".$link);

?>
