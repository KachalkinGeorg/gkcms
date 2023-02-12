<!DOCTYPE html>
<html><head>
<link href="http://fonts.googleapis.com/css?family=Oxygen:400,300,700" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset={{ lang.encoding }}"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-language" content="{{ lang.langcode }}"/>
<meta name="generator" content="{{ what }} {{ version }}"/>
<meta name="document-state" content="dynamic"/>
<title>Сайт недоступен..</title>
<meta name="description" content="Сайт находится на временной реконструкции">

<link href="{{ tpl_url }}/off/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="{{ tpl_url }}/off/css/animate.css">
<link href="{{ tpl_url }}/off/css/font-awesome.min.css" rel="stylesheet">
<link href="{{ tpl_url }}/off/css/main.css" rel="stylesheet">

</head>
<body>

<div class="animation-container">
  <div class="clouds"></div>
</div>

<div class="container"> 
  <!--header-->
  <header class="row top-header" >
    <div class="col-md-12">
      <h1 class="text-center bounceInDown animated">Сайт недоступен..</h1>
    </div>
  </header>
  <!--end header--> 
  
  <!--social media-->
  <section class="row text-center social bounceInUp animated">
    <div class="col-md-12">
      <p>{{ lock_reason }}</p>
<!--       <ul class="social-icons">
        <li><a href="#"><i class="fa fa-twitter fa-2x"></i></a></li>
        <li><a href="#"><i class="fa fa-facebook fa-2x"></i></a></li>
        <li><a href="#"><i class="fa fa-google-plus fa-2x"></i></a></li>
        <li><a href="#"><i class="fa fa-youtube fa-2x"></i></a></li>
      </ul> -->
    </div>
  </section>
  
  <!--end social media--> 
  
</div>

</body>
</html>