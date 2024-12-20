<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" Culture="auto" UICulture="auto" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CliniCoimbra</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/grayscale.css" rel="stylesheet">
    
    <style type="text/css">
        
    </style>
</head>
<body id="page-top">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="img/logo.png" /></a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <%--<li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#about"></a>
            </li>--%>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#especialidades">Especialidades</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#contactos">Contactos</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Header -->
    <header class="masthead">
      <div class="container d-flex h-100 align-items-center">
        <div class="mx-auto text-center">
          <h1 class="mx-auto my-0 text-uppercase">CliniCoimbra</h1>
          <h2 class="text-white-50 mx-auto mt-2 mb-5"></h2>
          <a href="#especialidades" class="btn btn-primary js-scroll-trigger">Conheça-nos</a>
        </div>
      </div>
    </header>

    <!-- About Section -->
    <%--<section id="about" class="about-section text-center">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
            <h2 class="text-white mb-4">Built with Bootstrap 4</h2>
            <p class="text-white-50">Grayscale is a free Bootstrap theme created by Start Bootstrap. It can be yours right now, simply download the template on
              <a href="http://startbootstrap.com/template-overviews/grayscale/">the preview page</a>. The theme is open source, and you can use it for any purpose, personal or commercial.</p>
          </div>
        </div>
        <img src="img/ipad.png" class="img-fluid" alt="">
      </div>
    </section>--%>

    <!-- Projects Section -->
    <section id="especialidades" class="projects-section bg-light">
      <div class="container" id="divServices" runat="server">

        <!-- Featured Project Row -->
        <%--<div class="row align-items-center no-gutters mb-4 mb-lg-5">
          <div class="col-xl-8 col-lg-7">
            <img class="img-fluid mb-3 mb-lg-0" src="img/bg-masthead.jpg" alt="">
          </div>
          <div class="col-xl-4 col-lg-5">
            <div class="featured-text text-center text-lg-left">
              <h4>Shoreline</h4>
              <p class="text-black-50 mb-0">Grayscale is open source and MIT licensed. This means you can use it for any project - even commercial projects! Download it, customize it, and publish your website!</p>
            </div>
          </div>
        </div>--%>

        

      </div>
    </section>

    <!-- Signup Section -->
    <section id="contactos" class="signup-section">
      <div class="container">
        <div class="row">
          <div class="col-md-10 col-lg-8 mx-auto text-center">

            <i class="far fa-paper-plane fa-2x mb-2 text-white"></i>
            <h2 class="text-white mb-5">Contacte-nos!</h2>

            <%--<form class="form-inline d-flex">--%>
                <input type="text" class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="inputName" placeholder="Nome">
                <input type="email" class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="inputEmail" placeholder="Email">
                <input type="text" class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="inputPhone" placeholder="Telefone">
                <input type="text" class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="inputSubject" placeholder="Assunto">
                <textarea class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="inputText" rows="20" placeholder="Insira aqui o texto"></textarea>
                <input type="button" class="btn btn-primary mx-auto" value="Enviar" onclick="sendEmail();"/>
            <%--</form>--%>


              <h5 style="display:none; color: red" id="errorMsg"></h5>
              <h5 style="display:none; color: green" id="successMsg"></h5>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section class="contact-section bg-black">
      <div class="container">

        <div class="row">

          <div class="col-md-4 mb-3 mb-md-0">
            <div class="card py-4 h-100">
              <div class="card-body text-center">
                <i class="fas fa-map-marked-alt text-primary mb-2"></i>
                <h4 class="text-uppercase m-0">Morada</h4>
                <hr class="my-4">
                <div class="small text-black-50">Av. Calouste Gulbenkian, 60, 1ºG<br />3000-090 Coimbra</div>
              </div>
            </div>
          </div>

          <div class="col-md-4 mb-3 mb-md-0">
            <div class="card py-4 h-100">
              <div class="card-body text-center">
                <i class="fas fa-envelope text-primary mb-2"></i>
                <h4 class="text-uppercase m-0">Email</h4>
                <hr class="my-4">
                <div class="small text-black-50">clinicoimbra@gmail.com</div>
              </div>
            </div>
          </div>

          <div class="col-md-4 mb-3 mb-md-0">
            <div class="card py-4 h-100">
              <div class="card-body text-center">
                <i class="fas fa-mobile-alt text-primary mb-2"></i>
                <h4 class="text-uppercase m-0">Telefone/Fax</h4>
                <hr class="my-4">
                <div class="small text-black-50">+351 239 481 325/26<br />+351 239 481 327</div>
              </div>
            </div>
          </div>
        </div>

          <div class="row" style="margin-top: 20px;">
              <div class="col-md-12 mb-12 mb-md-12" id="divMap" style="width: 100%">
                  <iframe id="map" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3046.761053200941!2d-8.41709388497582!3d40.21437787938917!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd22f9724d3f965f%3A0xe93566ee21a9f720!2sA.R.-Clinicoimbra%2C+Cl%C3%ADnica+M%C3%A9dica+E+Ocupacional%2C+Unipessoal+Lda.!5e0!3m2!1spt-PT!2spt!4v1529448364243" height="500" frameborder="0" style="border:0" allowfullscreen></iframe>
              </div>
          </div>

        <%--<div class="social d-flex justify-content-center">
          <a href="#" class="mx-2">
            <i class="fab fa-twitter"></i>
          </a>
          <a href="#" class="mx-2">
            <i class="fab fa-facebook-f"></i>
          </a>
          <a href="#" class="mx-2">
            <i class="fab fa-github"></i>
          </a>
        </div>--%>

      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-black small text-center text-white-50">
      <div class="container">
        André Afonso Lourenço &copy; clinicoimbra.pt
      </div>
    </footer>
  
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="js/grayscale.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            ajustaTamanhos();
        });

        $(window).on('resize', function () {
            ajustaTamanhos();
        });

        function ajustaTamanhos() {
            $('#map').width($('#divMap').width());
        }

        function sendEmail() {
            var assunto = $('#inputSubject').val().trim();
            var nome = $('#inputName').val().trim();
            var email = $('#inputEmail').val().trim();
            var telefone = $('#inputPhone').val().trim();
            var body = $('#inputText').val().trim();

            if (assunto == '' || nome == '' || email == '' || telefone == '' || body == '') {
                $('#errorMsg').html('Por favor, preencha todos os dados!');
                $('#errorMsg').fadeIn();
                return;
            }

            $.ajax({
                type: "POST",
                url: "index.aspx/sendEmailFromTemplate",
                data: '{"assunto":"' + assunto + '", "nome":"' + nome + '", "email":"' + email + '", "body":"' + body + '", "telefone":"' + telefone + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        if (parseInt(res.d) >= 0) {
                            $('#inputSubject').val('');
                            $('#inputName').val('');
                            $('#inputEmail').val('');
                            $('#inputPhone').val('');
                            $('#inputText').val('');
                            $('#errorMsg').fadeOut();
                            $("#successMsg").html('O seu contacto foi enviado com sucesso! Tentaremos responder o mais brevemenete possível. Obrigado!');
                            $("#successMsg").fadeIn();
                            setTimeout(function() { $("#successMsg").fadeOut(); }, 5000);
                        }
                        else {
                            $('#errorMsg').html('Ocorreu um erro ao enviar o seu contacto. Por favor, tente novamente. Obrigado!');
                            $('#errorMsg').fadeIn();
                        }                            
                    }
                }
            });
        }
    </script>
</body>
</html>