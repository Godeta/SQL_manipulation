<?php
function verifierText($n)
{
	if (!empty($_POST[$n])) {
		$var = $_POST[$n];
		if ($var <> "")
			echo $var;
	}
}
function cocherRadio($civ, $n)
{
	if (isset($_POST[$civ])) {
		if ($_POST[$civ] == $n)
			echo "checked";
	}
}
function VerifierSelect($pa, $n)
{
	if (isset($_POST[$pa])) {
		if ($_POST[$pa] == $n)
			echo "selected";
	}
}
function cocherCase($pref, $n)
{
	if (isset($_POST[$pref]))
		foreach ($_POST[$pref] as $val) {
			if ($n == $val) {
				echo "checked";
			}
		}
}
