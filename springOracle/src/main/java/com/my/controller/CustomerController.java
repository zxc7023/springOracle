package com.my.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.my.service.CustomerService;
import com.my.vo.Customer;

@Controller
@SessionAttributes("loginInfo")
@RequestMapping("/member/*")
public class CustomerController {
	
	@Autowired
	private CustomerService service;
	
	@RequestMapping(value = "/login.do", method=RequestMethod.POST)
	public String login() {
		
		return "/result.jsp";
	}

}
