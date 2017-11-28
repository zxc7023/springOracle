package com.my.controller;

import java.util.HashMap;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.vo.Product;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	@RequestMapping(value="/addcart" ,method=RequestMethod.POST)
	public String add(HttpSession session, @ModelAttribute Product p, int quantity) {
		HashMap<Product, Integer> cart = (HashMap) session.getAttribute("cart");
		if (cart == null) {
			cart = new HashMap<>();
			session.setAttribute("cart", cart);
		}
		// 장바구니에 상품추가, 동일상품(이전에 장바구니에 넣어둔 상품)인 경우
		Integer inCartQuantity = cart.get(p);
		System.out.println(inCartQuantity);
		if (inCartQuantity == null) {// 상품이 없는 경우
		} else {// 상품이 이미 있는경우
			quantity += inCartQuantity;
		}
		cart.put(p, quantity);

		System.out.println("장바구니 내용");
		Set<Product> products = cart.keySet();
		for (Product inCartProduct : products) {
			int q = cart.get(inCartProduct);
			System.out.println(inCartProduct.getProd_no() + ":" + q);
		}
		String forwardURL = "cart/cartlistresult";
		return forwardURL;
	}

	@RequestMapping("/cartlist")
	public String execute() {
		String forwardURL = "cart/cartlistresult";
		return forwardURL;
	}
}
