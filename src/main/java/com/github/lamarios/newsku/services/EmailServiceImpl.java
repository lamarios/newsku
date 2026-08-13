package com.github.lamarios.newsku.services;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;
import java.util.Optional;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.simplejavamail.api.email.Email;
import org.simplejavamail.api.mailer.Mailer;
import org.simplejavamail.email.EmailBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {
    private static final Logger logger = LogManager.getLogger();
    private final Configuration templateEngine;
    private final Optional<Mailer> mailer;
    private final String rootUrl;
    @Value("${SMTP_FROM:}")
    private String smtpFrom;

    @Autowired
    public EmailServiceImpl(Configuration templateEngine, Optional<Mailer> mailer, String rootUrl) {
        this.templateEngine = templateEngine;
        this.mailer = mailer;
        this.rootUrl = rootUrl;
    }

    @Override
    public boolean isEnabled() {
        return mailer.isPresent();
    }

    @Override
    public void sendHtml(String to, String subject, String message) {
        try {
            mailer
                .filter(m -> !smtpFrom.trim().isEmpty())
                .ifPresent(m -> {
                    logger.info("Sending email [{}]", subject);
                    Email email =
                            EmailBuilder
                        .startingBlank()
                        .to(to)
                        .from(smtpFrom)
                        .withSubject(subject)
                        .withHTMLText(message)
                        //                        .withPlainText(message)
                        .buildEmail();

                    m.sendMail(email);
                });
        } catch (Exception e) {
            logger.error("Error while sending email", e);
        }
    }

    @Override
    public void sendTemplate(String to, String subject, String template, Map<String, Object> data)
            throws IOException,
            TemplateException {
        data.put("footerUrl", rootUrl);
        final String s = processTemplate(template, data);
        sendHtml(to, subject, s);
    }

    @Override
    public String processTemplate(String templateName, Map<String, Object> data) throws IOException, TemplateException {
        try (StringWriter templateStr = new StringWriter()) {
            final Template template = templateEngine.getTemplate(templateName);
            template.process(data, templateStr);

            return templateStr.toString();
        }
    }
}
