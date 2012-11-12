<!--
 nextSIS login view
 
 PURPOSE 
 This displays the login page.
 
 LICENCE 
 This file is part of nextSIS.
 
 nextSIS is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as
 published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
  
 nextSIS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
  
 You should have received a copy of the GNU General Public License along with nextSIS. If not, see
 <http://www.gnu.org/licenses/>.
  
 Copyright 2012 http://nextsis.org
-->

	<!-- Header -->
	<div class="header">
		<span><a href="<?php echo base_url();?>"><img alt="nextsis logo" height="90" width="90" src="<?php echo base_url('assets/img/nextsis.logo.90.png');?>"></a></span>
		<span class="header">Busan International Foreign School<br><?php echo $this->lang->line('student_information_system');?></span>
	</div>
		
	<!-- Calendar box -->
	<span class="calendar">reserved for calendar block (variable width)</span>
		

	<span class="login">
		<h1><?php echo $this->lang->line('login_sign_in');?> &gt;</h1>
		<p class="subtitle"><?php echo $this->lang->line('login_welcome_message');?></p>
		<?php echo form_open('login/authenticate'); ?>
			<div class="form"><h3><?php echo $this->lang->line('login_username');?></h3></div><br>		
			<div class="form"><input id="username" name="username" class="highlight" type="text" maxlength="100" value=""></div>
			<div class="form"><h3><?php echo $this->lang->line('login_password');?></h3></div><br>
			<div class="form"><input id="password" name="password" class="highlight" type="password" maxlength="100" value=""></div>
			<div class="form"></div>
			<div class="form"><button type="submit" class="btn btn-primary"><?php echo $this->lang->line('login_sign_in');?> &gt;</button></div>
			<!-- <div class="form"><p class="text-error"><i class="icon-remove"></i></p></div> -->
			<div class="form"></div>
			<p class="text-error"><?php echo validation_errors();?></p>
			</div>
		</form>
	</span>
