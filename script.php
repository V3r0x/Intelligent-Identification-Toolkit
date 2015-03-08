<!-- Database Connection-->

<?php
	$dbname = "products_db";
	$user = "root";
	$password = "mysql";
	$host = "localhost";
	$con = mysqli_connect($host,$user,$password,$dbname) or die("Error establishing MYSQL Connection");
	$product_present = 0;
	if(isset($_GET['product'])){
		$product = 	mysqli_real_escape_string($con,$_GET['product']);
		$p = mysqli_query($con,"select * from products where link = '$product'");
		if(mysqli_num_rows($p)>0){ 
			$product_present = 1;
			$p = mysqli_fetch_assoc($p);
		}

	}
?>

<html>
  <head>  

 <!-- Meta Tags with added information for databse-->
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta http-equiv="Content-Language" content="en">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php
  if($product_present == 1){
  	?>
  	<meta name="keywords" content="<?php echo $p['Tags'];?>">
  	<meta name="description" content="<?php echo $p['Description'];?>">
  	<meta name="author" content="<?php echo $p['Creator'];?>">
  	<?php
  }
  ?>

   
   <title>Intelligent Identification Toolkit for 3D Printing</title>
   
	 <!-- Latest compiled and minified CSS -->
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	 <link rel="stylesheet" href="//cdn.datatables.net/1.10.5/css/jquery.dataTables.min.css">
	 <style type="text/css">
	 img{
	 	max-height: 200px;
	 }
	 .btn-primary {
	color: #ffffff;
	background-color: #ee8226;
	border-color: #aeaeae;
}
	 </style>
  </head>


   <!-- BODY -->
	<body>
		<div class="container">

		<h1><img src="/img/logo.png" style="margin-right: 15px;">Intelligent Identification Toolkit for 3D Printing</h1>
			   	<hr>

   <!-- Query product from database-->
<?php
	// exception
	if(isset($_GET['product'])){ 
		$product = 	mysqli_real_escape_string($con,$_GET['product']);
		$product_id = $product;
		$p = mysqli_query($con,"select * from products where link = '$product'");
		if(mysqli_num_rows($p)==0){ 
			?>
		<blockquote>Ooops, I couldn't find the Item : /</blockquote>


		<!-- Query product from database, show table-->
		
			<?php 
		}
		else{
			$p = mysqli_fetch_assoc($p);
			?>
			<div itemscope itemtype="http://schema.org/Product">
			<h3><span itemprop="name">
				<?php echo $p['ProductName'];?>
				</span>
			</h3>

			<table class="table table-striped">
				<tr><th>Creator</th><td>
						<span itemprop="manufacturer">
							<?php echo $p['Creator'];?>
						</span>
				</td></tr>

				<tr><th>Publish Date</th><td>
						<span itemprop="releaseDate">
					<?php echo $p['PublishDate'];?>
						</span>
				</td></tr>
				<tr><th>Description</th><td>
						<span itemprop="description">
					<?php echo $p['Description'];?>
						</span>
				</td></tr>
				<tr><th>Image</th><td>
					<span itemprop="logo"><p style="display: none";><?php echo $p['Image'];?></p></span>
					<img src="<?php echo $p['Image'];?>">
				</td></tr>
				<tr><th>Instructions</th><td> 
					<!-- no suitable meta from schema.org -->
					<?php echo $p['Instructions'];?>
				</td></tr>
				<tr><th>Files</th><td>
						<span itemprop="model">
					<a href="<?php echo $p['Files'];?>">Download</a>
						</span>
					 &nbsp; (rightclick: Save As)</td></tr>
				<tr><th>URI</th><td>
					<img src="<?php echo $p['URI'];?>">
				</td></tr>
				<tr><th>License</th><td>
					<!-- no suitable meta from schema.org -->
					<?php echo $p['License'];?>
				</td></tr>
				<tr><th>Tags</th><td>
					<?php echo $p['Tags'];?>
				</td></tr>
			</table>

			<hr>
				
		<!-- Query children or parents from database, show table-->

			<?php
			$children = mysqli_query($con , "select * from parent_child where link_parent='$product_id'");
			if(mysqli_num_rows($children)>0){
				echo "<h3>Children</h3><div class='row'><div class='col-md-12'>";
				while($row = mysqli_fetch_assoc($children)){
					$product = $row['link_child'];
					$p = mysqli_fetch_assoc(mysqli_query($con,"select * from products where link = '$product'"));
					echo "<div class='col-md-2'><a class='btn btn-primary' href='".$p['Link']."'><span itemprop='isAccessoryOrSparePartFor'>".$p['ProductName'].'</a></div>';
				}
				echo "</div></div><hr>";
			}
			$parent = mysqli_query($con , "select * from parent_child where link_child='$product_id'");
			if(mysqli_num_rows($parent)>0){
				echo "<h3>Parents</h3><div class='row'><div class='col-md-12'>";
				while($row = mysqli_fetch_assoc($parent)){
					$product = $row['link_parent'];
					$p = mysqli_fetch_assoc(mysqli_query($con,"select * from products where link = '$product'"));
					echo "<div class='col-md-2'><a class='btn btn-primary' href='".$p['Link']."'><span itemprop='isRelatedTo'>".$p['ProductName'].'</a></div>';
				}
				echo "</div></div>";
			} 
			if(mysqli_num_rows($parent)==0&&mysqli_num_rows($children)==0){
				?>
				<!-- case for no parents or childern-->
					<blockquote><b>This Object does not have related Objects yet</b></blockquote>
				<?php
			}
		}
	}

	else{
		?>
		<!-- false URL-->
		<blockquote>Please pass productname or id in URL

		<br>
		<code>http://localhost/productname</code>
		<code>http://localhost/product_id (link field)</code>
		<code>http://localhost/script.php?product=productname</code>

		<!-- see specified folder URL Override settings in .htaccess file for more URL settings -->

		</blockquote>

		<?php
	}
?>
</div>
<style type="text/css">

	/* Sticky footer styles
-------------------------------------------------- */
html {
  position: relative;
  min-height: 100%;
}
.footer {
	margin-top: 60px;
  bottom: 0;
  width: 100%;
  /* Set the fixed height of the footer here */
  height: 60px;
  background-color: #f5f5f5;
}



.container .text-muted {
  margin: 20px 0;
}

.footer > .container {
  padding-right: 15px;
  padding-left: 15px;
}
</style>

<footer class="footer">
      <div class="container">
        <p class="text-muted">Intelligent Identification Toolkit for 3D Printing</p>
      </div>
</footer>
</body>
</html>

	   
