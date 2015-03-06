<!-- Monitor change of txt file -->
<?php

$pathtofile = "cam.txt";
$last =  exec('tail -n 1 '.$pathtofile);

$page = file_get_contents($last);
echo $page;
?>


<!-- Page refreshing.-->
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script>
var last = "<?php echo $last?>";
function check(){
	jQuery.ajax({
		url:"get.php",
		type:"GET",
		success:function(data){
			if(data!=last)
				location.reload();
			console.log(data);
		}
	});
}
window.onload = function(){
  setInterval(check, 2000);
};
</script>
            