package com.my.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.my.dao.ProductDAOOracle;
import com.my.service.ProductService;
import com.my.vo.Product;

@Controller
@RequestMapping(value = "/product/*")
public class ProductController {

	@Autowired
	ProductService service =null;
	
	@RequestMapping("/productlist")
	public String list(@RequestParam(required=false,defaultValue="no")String searchItem,
					   @RequestParam(required=false,defaultValue="")String searchValue, Model model){

		List<Product> list = new ArrayList<>();
		try {
			if (searchValue.equals("")) { // 전체검색
				list = service.listAll();
			} else if ("name".equals(searchItem)) { // 이름으로검색
				list = service.listName(searchValue);
			} else if ("no".equals(searchItem)) { // 번호로검색
/*				Product p = dao.selectByNo(searchValue);
				if (p != null) {
					list.add(p);
				}*/
			}
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("list", list);
		String forwardURL = "product/productlistresult";
		return forwardURL;
	}
/*	@RequestMapping("/productdetail.do")
	@ResponseBody
	public Product productdetail(String no) {
	     ModelAndView mnv = new ModelAndView();

		try {
			Product p = dao.selectByNo(no);
			return p;
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Product pError = new Product();
		pError.setProd_no("-1");
		return pError;

		model.addAttribute("productDetail", p);
		String forwardURL = "/productdetailresult.jsp";
		return forwardURL;
	}*/
}
