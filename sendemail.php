<?php
   // data sent in header are in JSON format
   header('Content-Type: application/json');

   // takes the value from variables and Post the data
   $name = $_POST['name'];
   $email = $_POST['email'];
   $contact = $_POST['contact'];
   $postmessage = $_POST['message']; 
   $subject = $_POST['subject'];
   $to = "clinicoimbra@gmail.com";
   $from = "no-reply@clinicoimbra.pt";

   // Email Template
   // Message
   $message = '	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
					<html xmlns="http://www.w3.org/1999/xhtml"> 
						<head> 
							<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
							<link href="https://afeld.github.io/emoji-css/emoji.css" rel="stylesheet" /> 
							<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
							<meta name="viewport" content="width=device-width, initial-scale=1.0" />
							<link rel="icon" type="image/x-icon" href="http://www.clinicoimbra.pt/img/favicon.ico" />
							<title>Contacto através do website clinicoimbra.pt: '.$subject.'</title> 
							<style type="text/css"> 
								@media screen and (max-width: 600px) {table [class="container"] {width: 95% !important;}}
								#outlook a {padding:0;}
								body{width:100% !important; -webkit-text-size-adjust:100%;  -ms-text-size-adjust:100%; -moz-text-size-adjust:100%; text-size-adjust:100%; margin:0; padding:0;}
								.ExternalClass {width:100%;}
								.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}
								#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}
								img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}
								a img {border:none;}
								.image_fix {display:block;}
								p {margin: 1em 0;}
								h1, h2, h3, h4, h5, h6 {color: black !important;}
								h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}
								h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}
								h1 a:visited, h2 a:visited, h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}
								table td {border-collapse: collapse;}
								table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }
								a {color: #000;}
								@media only screen and (max-device-width: 480px) {
									a[href^="tel"], a[href^="sms"] { text-decoration: none; color: black; pointer-events: none; cursor: default; }
									.mobile_link a[href^="tel"], .mobile_link a[href^="sms"] { text-decoration: default;color: orange !important; pointer-events: auto; cursor: default; }
								}
								@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {
									a[href^="tel"], a[href^="sms"] { text-decoration: none; color: black; pointer-events: none; cursor: default; }
									.mobile_link a[href^="tel"], .mobile_link a[href^="sms"] { text-decoration: default;color: orange !important; pointer-events: auto; cursor: default; }
								}
								@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}
								@media only screen and (-webkit-device-pixel-ratio:.75) {/* Put CSS for low density (ldpi) Android layouts in here */}
								@media only screen and (-webkit-device-pixel-ratio:1) {/* Put CSS for medium density (mdpi) Android layouts in here */}
								@media only screen and (-webkit-device-pixel-ratio:1.5) {/* Put CSS for high density (hdpi) Android layouts in here */}
								h2{ color:#181818; font-family: "Roboto", sans-serif; font-size:22px; line-height: 22px; font-weight: normal; }
								a.link1{ color:#fff; text-decoration:none; font-family: "Roboto", sans-serif; font-size:16px; color:#fff; border-radius:4px; }
								a.link2{ color:#fff; text-decoration:none; font-family: "Roboto", sans-serif; font-size:16px; color:#fff; border-radius:4px; }
								p{ color:#555; font-family: "Roboto", sans-serif; font-size:16px; line-height:160%; }
							</style>
						</head>
						<body style="background-color:#F2F2F2">
							<table cellpadding="0" width="100%" cellspacing="0" border="0" id="backgroundTable" class="bgBody">
								<tr>
									<td>
										<table cellpadding="0" width="620" class="container" align="center" cellspacing="0" border="0" style="background-color:white; margin-top:30px; margin-bottom:30px">
											<tr>
												<td>
													<table cellpadding="0" cellspacing="0" border="0" width="600" class="container" style="margin-left:30px; margin-right:30px;text-align:center">
														<tr>
															<td class="movableContentContainer bgItem">
																<div class="movableContent">
																	<table cellpadding="0" cellspacing="0" border="0" style="text-align:center" width="600" class="container">
																		<tr style="height:20px">
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																		</tr>
																		<tr>
																			<td style="width:200px" valign="top">&nbsp;</td>
																			<td style="width:200px" valign="top" align="center">
																				<div class="contentEditableContainer contentImageEditable">
					                												<div class="contentEditable" style="text-align:center" >
					                  														<!--[EMAIL_INTROIMAGE]-->
																						<img src="http://clinicoimbra.pt/img/logo.png" style="width:100%; height: 100%"/>
					                												</div>
					              												</div>
																			</td>
																			<td style="width:200px" valign="top">&nbsp;</td>
																		</tr>
																		<tr style="height:25px">
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																		</tr>
																	</table>
																</div>
																<hr style="width:99%; border: 0; height: 0;border-top: 1px solid rgba(0, 0, 0, 0.1); border-bottom: 1px solid rgba(255, 255, 255, 0.3);"/>
																<div class="movableContent">
																	<table cellpadding="0" cellspacing="0" border="0" style="text-align:center" width="600" class="container">
																		<tr>
																			<td style="width:100%" colspan="3" style="padding-bottom:10px;padding-top:25px;text-align:center">
																				<div class="contentEditableContainer contentTextEditable">
					                												<div class="contentEditable" style="text-align:center">
					                  													<h2>Contacto através do website clinicoimbra.pt<br />'.$subject.'</h2>
					                												</div>
					              												</div>
																			</td>
																		</tr>
																		<tr>
																			<td style="text-align:left; width: 100%">
																				<div class="contentEditableContainer contentTextEditable">
					                												<div class="contentEditable" style="text-align:left" >
					                  													<p style="font-size:13px">
																							<b>Nome: </b>'.$name.'<br />
																							<b>Email: </b>'.$email.'<br />
																							<b>Telefone: </b>'.$contact.'
																						</p>
																						<p style="font-size:13px">'.$postmessage.'</p>
					                												</div>
					              												</div>
																			</td> 
																		</tr>
																	</table>
																</div>
																<div class="movableContent">
																	<table cellpadding="0" cellspacing="0" border="0" style="text-align:center;" width="600" class="container">
																		<tr>
																			<td style="padding-top:65px; width: 100%">
																				<hr style="height:1px;border:none;color:#333;background-color:#ddd;" />
																			</td>
																		</tr>
																		<tr>
																			<td valign="middle" style="padding-bottom:20px; width: 100%; height: 70px;">
																				<div class="contentEditableContainer contentTextEditable">
					                												<div class="contentEditable" style="text-align: left">
					                  													<span style="font-size:13px;color:#181818;font-family:"Roboto", sans-serif; line-height: 200%">
																							<b>CliniCoimbra Lda</b>
					                  													</span>
																						<br/>
																						<span style="font-size:11px;color:#555;font-family:"Roboto", sans-serif;line-height:200%;">
																							<b>Avenida Calouste Gulbenkian, 60</b>
																							<br />
																							<b>3000-090 Coimbra</b>
																							<br />
																							<b>Email: </b>clinicoimbra@gmail.com
																							<br />
																							<b>Contactos: </b>+351 239 481 325/26
																							<br />
																							<b>Fax: </b>+351 239 481 327
																						</span>
																						<!--<br/>
																						<span style="font-size:13px;color:#181818;font-family:"Roboto", sans-serif;line-height:200%;">
																							<b>Por favor não responda a este email</b>
																						</span>-->
					                												</div>
					              												</div>
																			</td>
																		</tr>
																	</table>
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</body>
					</html>';
	
	$message2 = '	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
					<html xmlns="http://www.w3.org/1999/xhtml"> 
						<head> 
							<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
							<link href="https://afeld.github.io/emoji-css/emoji.css" rel="stylesheet" /> 
							<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
							<meta name="viewport" content="width=device-width, initial-scale=1.0" />
							<link rel="icon" type="image/x-icon" href="http://www.clinicoimbra.pt/img/favicon.ico" />
							<title>Contacto através do website clinicoimbra.pt: '.$subject.'</title> 
							<style type="text/css"> 
								@media screen and (max-width: 600px) {table [class="container"] {width: 95% !important;}}
								#outlook a {padding:0;}
								body{width:100% !important; -webkit-text-size-adjust:100%;  -ms-text-size-adjust:100%; -moz-text-size-adjust:100%; text-size-adjust:100%; margin:0; padding:0;}
								.ExternalClass {width:100%;}
								.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}
								#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}
								img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}
								a img {border:none;}
								.image_fix {display:block;}
								p {margin: 1em 0;}
								h1, h2, h3, h4, h5, h6 {color: black !important;}
								h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}
								h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}
								h1 a:visited, h2 a:visited, h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}
								table td {border-collapse: collapse;}
								table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }
								a {color: #000;}
								@media only screen and (max-device-width: 480px) {
									a[href^="tel"], a[href^="sms"] { text-decoration: none; color: black; pointer-events: none; cursor: default; }
									.mobile_link a[href^="tel"], .mobile_link a[href^="sms"] { text-decoration: default;color: orange !important; pointer-events: auto; cursor: default; }
								}
								@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {
									a[href^="tel"], a[href^="sms"] { text-decoration: none; color: black; pointer-events: none; cursor: default; }
									.mobile_link a[href^="tel"], .mobile_link a[href^="sms"] { text-decoration: default;color: orange !important; pointer-events: auto; cursor: default; }
								}
								@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}
								@media only screen and (-webkit-device-pixel-ratio:.75) {/* Put CSS for low density (ldpi) Android layouts in here */}
								@media only screen and (-webkit-device-pixel-ratio:1) {/* Put CSS for medium density (mdpi) Android layouts in here */}
								@media only screen and (-webkit-device-pixel-ratio:1.5) {/* Put CSS for high density (hdpi) Android layouts in here */}
								h2{ color:#181818; font-family: "Roboto", sans-serif; font-size:22px; line-height: 22px; font-weight: normal; }
								a.link1{ color:#fff; text-decoration:none; font-family: "Roboto", sans-serif; font-size:16px; color:#fff; border-radius:4px; }
								a.link2{ color:#fff; text-decoration:none; font-family: "Roboto", sans-serif; font-size:16px; color:#fff; border-radius:4px; }
								p{ color:#555; font-family: "Roboto", sans-serif; font-size:16px; line-height:160%; }
							</style>
						</head>
						<body style="background-color:#F2F2F2">
							<table cellpadding="0" width="100%" cellspacing="0" border="0" id="backgroundTable" class="bgBody">
								<tr>
									<td>
										<table cellpadding="0" width="620" class="container" align="center" cellspacing="0" border="0" style="background-color:white; margin-top:30px; margin-bottom:30px">
											<tr>
												<td>
													<table cellpadding="0" cellspacing="0" border="0" width="600" class="container" style="margin-left:30px; margin-right:30px;text-align:center">
														<tr>
															<td class="movableContentContainer bgItem">
																<div class="movableContent">
																	<table cellpadding="0" cellspacing="0" border="0" style="text-align:center" width="600" class="container">
																		<tr style="height:20px">
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																		</tr>
																		<tr>
																			<td style="width:200px" valign="top">&nbsp;</td>
																			<td style="width:200px" valign="top" align="center">
																				<div class="contentEditableContainer contentImageEditable">
					                												<div class="contentEditable" style="text-align:center" >
					                  														<!--[EMAIL_INTROIMAGE]-->
																						<img src="http://clinicoimbra.pt/img/logo.png" style="width:100%; height: 100%"/>
					                												</div>
					              												</div>
																			</td>
																			<td style="width:200px" valign="top">&nbsp;</td>
																		</tr>
																		<tr style="height:25px">
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																			<td style="width:200px">&nbsp;</td>
																		</tr>
																	</table>
																</div>
																<hr style="width:99%; border: 0; height: 0;border-top: 1px solid rgba(0, 0, 0, 0.1); border-bottom: 1px solid rgba(255, 255, 255, 0.3);"/>
																<div class="movableContent">
																	<table cellpadding="0" cellspacing="0" border="0" style="text-align:center" width="600" class="container">
																		<tr>
																			<td style="width:100%" colspan="3" style="padding-bottom:10px;padding-top:25px;text-align:center">
																				<div class="contentEditableContainer contentTextEditable">
					                												<div class="contentEditable" style="text-align:center">
					                  													<h2>OBRIGADO PELO SEU CONTACTO!<br />RESPONDEREMOS COM A MAIOR BREVIDADE POSSÍVEL!</h2>
					                												</div>
					              												</div>
																			</td>
																		</tr>
																		<tr>
																			<td style="text-align:left; width: 100%">
																				<div class="contentEditableContainer contentTextEditable">
					                												<div class="contentEditable" style="text-align:center" >
																						<h3>'.$subject.'</h3>
																						<br />
					                  													<p style="font-size:13px">'.$postmessage.'</p>
					                												</div>
					              												</div>
																			</td> 
																		</tr>
																	</table>
																</div>
																<div class="movableContent">
																	<table cellpadding="0" cellspacing="0" border="0" style="text-align:center;" width="600" class="container">
																		<tr>
																			<td style="padding-top:65px; width: 100%">
																				<hr style="height:1px;border:none;color:#333;background-color:#ddd;" />
																			</td>
																		</tr>
																		<tr>
																			<td valign="middle" style="padding-bottom:20px; width: 100%; height: 70px;">
																				<div class="contentEditableContainer contentTextEditable">
					                												<div class="contentEditable" style="text-align: left">
					                  													<span style="font-size:13px;color:#181818;font-family:"Roboto", sans-serif; line-height: 200%">
																							<b>CliniCoimbra Lda</b>
					                  													</span>
																						<br/>
																						<span style="font-size:11px;color:#555;font-family:"Roboto", sans-serif;line-height:200%;">
																							<b>Avenida Calouste Gulbenkian, 60</b>
																							<br />
																							<b>3000-090 Coimbra</b>
																							<br />
																							<b>Email: </b>clinicoimbra@gmail.com
																							<br />
																							<b>Contactos: </b>+351 239 481 325/26
																							<br />
																							<b>Fax: </b>+351 239 481 327
																						</span>
																						<br/>
																						<span style="font-size:13px;color:#181818;font-family:"Roboto", sans-serif;line-height:200%;">
																							<b>Por favor não responda a este email</b>
																						</span>
					                												</div>
					              												</div>
																			</td>
																		</tr>
																	</table>
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</body>
					</html>';

   $header = "From: CliniCoimbra <".$from.">\r\n";
   $header .= "MIME-Version: 1.0\r\n";
   $header .= "Content-Type: text/html; charset=utf-8\r\n";

   $retval = mail ($to,$subject,$message,$header);
   // message Notification
	if( $retval == true ) {
		$retval2 = mail ($email,$subject,$message2,$header);
		if( $retval == true ) {
			echo json_encode(array( 'success' => true, 'message' => 'Message sent successfully' ));
		}
		else {
			echo json_encode(array( 'error'=> true, 'message' => 'Error sending message' ));
		}
	}
	else {
		echo json_encode(array( 'error'=> true, 'message' => 'Error sending message' ));
	}
?>