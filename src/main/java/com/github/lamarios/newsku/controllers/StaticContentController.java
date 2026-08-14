package com.github.lamarios.newsku.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StaticContentController {
  @RequestMapping(value = "/")
  public String serveIndex() {
    return "index.html";
  }
}
