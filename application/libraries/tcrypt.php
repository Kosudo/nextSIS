<?php

/* nextSIS Tcrypt class
 *
 * PURPOSE 
 * This creates a class for generating and checking salted hashed passwords. It's a temporary solution right now without key-
 * -lengthening. 
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
 
class Tcrypt
{
	public function password_hash($password)
	{
		/* This function takes a password ($password) from a form where a new password is entered and returns the salted hash.
		 * The function returns the hash of the password as a 128 hexadecimal character string. Note that the salt is randomly
		 * generated for each user so if two users have the same password their hashed passwords will not be the same.
		 */
		 
		// get 256 random bits in hexadecimal
		$salt = bin2hex(mcrypt_create_iv(32, MCRYPT_DEV_URANDOM));
		
		// prepend the salt, then hash
		$hash = hash("sha256",$salt.$password);
		
		// store the salt and hash in the same string so that only one database field is needed
		$hashedpassword = $salt.$hash;
		
		// return the salted hash
		return $hashedpassword;
	}
	
	public function password_validate($password, $correcthash)
	{
		/* This function takes a password from a form ($password) and compares it against the correct hash created by the
		 * password_hash() function which was previously stored in the database. If the two match then the function returns
		 * true.
		 */ 
		 
		// get the prepended salt from the front of the hash and the valid SHA256 hash
		$salt = substr($correcthash,0,64);
		$validhash = substr($correcthash,64,64); // this is the actual SHA256
		
		// hash the password from the form ($password)
		$checkhash = hash("sha256",$salt.$password);
		// echo $checkhash;
		
		// return true if the hashes are exactly (===) the same
		return $checkhash === $validhash;
	}
}
	
?>