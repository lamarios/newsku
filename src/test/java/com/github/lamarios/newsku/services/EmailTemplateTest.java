package com.github.lamarios.newsku.services;

import static org.junit.jupiter.api.Assertions.*;

import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import java.util.HashMap;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class EmailTemplateTest extends TestContainerTest {
  @Autowired private EmailService emailService;

  @Test
  public void valuesAreHtmlEscaped() throws Exception {
    var data = new HashMap<String, Object>();
    data.put("username", "<script>alert(1)</script>");
    data.put("url", "https://newsku.test/#/reset-password?token=a&b=\"c\"");
    data.put("footerUrl", "https://newsku.test");

    String html = emailService.processTemplate("email/reset-password.ftl", data);

    assertFalse(html.contains("<script>"));
    assertTrue(html.contains("&lt;script&gt;alert(1)&lt;/script&gt;"));
    assertTrue(html.contains("token=a&amp;b=&quot;c&quot;"));
  }
}
