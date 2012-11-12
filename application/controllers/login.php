<?php if (!defined('BASEPATH')) exit('No direct script access allowed.');

/* nextSIS login controller
 *
 * PURPOSE 
 * This is the default controller as defined by /application/config/routes.php. It creates a login class with methods which
 * handle the authentication and login form.
 * 
 * LICENCE 
 * This file is part of nextSIS.
 * 
 * nextSIS is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 * 
 * nextSIS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with nextSIS. If not, see
 * <http://www.gnu.org/licenses/>.
 * 
 * Copyright 2012 http://nextsis.org
 */
  
class Login extends CI_Controller
{
	public function __construct()
 	{
   		parent::__construct();
 	}

 	public function index()
 	{
		$this->load->helper(array('form', 'url')); // load the html form helper
		$this->lang->load('login'); // load the login language file - the default language option (unused second parameter) is taken from config.php file 		
		$this->load->view('templates/header'); // load the page's visible header
		$this->load->view('login_view'); // load the standard login form
		$this->load->view('templates/footer'); // load the page's visible footer
 	}

	public function authenticate()
	{
		$this->load->model('user','',TRUE);
   		
   		// use the CodeIgniter form validation library
   		$this->load->library('form_validation');

   		// field is trimmed, required and xss cleaned respectively
   		$this->form_validation->set_rules('username', 'Username', 'trim|required|xss_clean');
		
		// apply rules and then callback to validate_password method below
   		$this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean|callback_validate_password');

   		if($this->form_validation->run() == FALSE) // authentication failed - display the login form 
   		{
			$this->load->helper(array('form', 'url')); // load the html form helper
			$this->lang->load('login'); // default language option taken from config.php file 		
			$this->load->view('templates/header'); // load the page's visible header
			$this->load->view('login_view'); // load the standard login form
			$this->load->view('templates/footer'); // load the page's visible footer
   		}
		else // authentication succeeded - display the homepage
   		{
     		redirect('home', 'refresh');
   		}			
	}
	
 	public function validate_password($password)
 	{
   		// take the posted username
   		$username = $this->input->post('username');

   		// return the result of the user model login method (an array if true)
   		$result = $this->user->login($username, $password);

   		if($result)
   		{
     		$session = array();
     		foreach($result as $row)
     		{
       			
       			$session = array('id'=>$row->id,'username'=>$row->username);
       			$this->session->set_userdata('logged_in', $session);
     		}
     		return TRUE; // validation succeeded
   		}
   		else
   		{
   			// load in the login language file (login_lang)
			$this->lang->load('login');
			
			// set the validation message as 'login incorrect' 
     		$this->form_validation->set_message('validate_password', $this->lang->line('login_incorrect'));
						
     		return FALSE; // validation failed
   		}	
	}
	
}

?>