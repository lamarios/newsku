package com.github.lamarios.newsku.utils;

import org.jsoup.Jsoup;

public class HtmlUtils {
  public static String getTextContent(String html) {
    return Jsoup.parse(html).body().text();
  }
}
