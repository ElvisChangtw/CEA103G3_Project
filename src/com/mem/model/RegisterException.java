package com.mem.model;

public class RegisterException extends Exception{
	  
      public void registerException(){
      }
      public String getMessage(){
              return ("信箱已經有人使用，請更改信箱");
      }
}
