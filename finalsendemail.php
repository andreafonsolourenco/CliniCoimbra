<?php
	function EnviaCorreoDesdeWeb($name, $email, $phone, $subject, $text)
    { 
       // sendemail.php
		$name = $_POST['inputName'];
		$email = $_POST['inputEmail'];
		$phone = $_POST['inputPhone'];
		$subject = $_POST['inputSubject'];
		$text = $_POST['inputText'];

		// Basic control
		if (!isset($name))
		{
			$errorMsg = 'Nome inválido!';
	
			// Stop PHP execution
			return;
		}

		if (!isset($email))
		{
			$errorMsg = 'Email inválido!';
	
			// Stop PHP execution
			return;
		}

		if (!isset($phone))
		{
			$errorMsg = 'Contacto inválido!';
	
			// Stop PHP execution
			return;
		}

		if (!isset($subject))
		{
			$errorMsg = 'Assunto do Email inválido!';
	
			// Stop PHP execution
			return;
		}

		if (!isset($text))
		{
			$errorMsg = 'Conteúdo do Email inválido!';
	
			// Stop PHP execution
			return;
		}

		if(isset($_POST['submit'])) {
		 $mailto = "clinicoimbra@gmail.com";  //My email address
		 $fromEmail = "no-reply@clinicoimbra.pt"; //getting customer email
		 $phone = $_POST['tel']; //getting customer Phome number
		 $subject = $_POST['subject']; //getting subject line from client
		 $subject2 = "Confirmation: Message was submitted successfully | HMA WebDesign"; // For customer confirmation
 
		 //Email body I will receive
		 $message = "Cleint Name: " . $name . "\n"
		 . "Phone Number: " . $phone . "\n\n"
		 . "Client Message: " . "\n" . $text;
 
		 //Message for client confirmation
		 $message2 = "Car@" . $name . "\n"
		 . "Obrigado pelo seu contacto! Entraremos em contacto o mais breve possível!" . "\n\n"
		 . "A sua mensagem:" . "\n" . $text . "\n\n"
		 . "Atenciosamente," . "\n" . "CliniCoimbra";
 
		 //Email headers
		 $headers = "From: " . $fromEmail;
 
		 //PHP mailer function
 
		  $result1 = mail($mailto, $subject, $text, $headers); // This email sent to My address
		  $result2 = mail($email, $subject, $message2, $headers); //This confirmation email to client
 
		  //Checking if Mails sent successfully
 
		  if ($result1 && $result2) {
			echo "0";
		  } else {
			echo "-1";
		  }
    } 
}