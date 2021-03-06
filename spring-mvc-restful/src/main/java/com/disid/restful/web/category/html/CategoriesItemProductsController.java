package com.disid.restful.web.category.html;

import com.disid.restful.datatables.Datatables;
import com.disid.restful.datatables.DatatablesData;
import com.disid.restful.model.Category;
import com.disid.restful.model.Product;
import com.disid.restful.service.api.CategoryService;
import com.disid.restful.service.api.ProductService;

import io.springlets.data.domain.GlobalSearch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/categories/{category}/products", produces = MediaType.TEXT_HTML_VALUE)
public class CategoriesItemProductsController {

  public CategoryService categoryService;

  public ProductService productService;

  @Autowired
  public CategoriesItemProductsController(CategoryService categoryService,
      ProductService productService) {
    this.categoryService = categoryService;
    this.productService = productService;
  }

  @ModelAttribute
  public Category getCategory(@PathVariable("category") Long id) {
    return categoryService.findOne(id);
  }

  @GetMapping(produces = Datatables.MEDIA_TYPE)
  @ResponseBody
  public DatatablesData<Product> listProduct(@ModelAttribute Category category, GlobalSearch search,
      Pageable pageable, @RequestParam("draw") Integer draw) {
    Page<Product> products = productService.findByCategoriesContains(category, search, pageable);
    long allAvailableProducts = productService.countByCategoriesContains(category);
    return new DatatablesData<Product>(products, allAvailableProducts, draw);
  }

}
