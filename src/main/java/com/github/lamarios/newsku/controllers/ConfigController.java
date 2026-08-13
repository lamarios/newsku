package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.models.AppConfig;
import com.github.lamarios.newsku.services.OidcService;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.Optional;
import org.simplejavamail.api.mailer.Mailer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.info.BuildProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/config")
@Tag(name = "misc")
public class ConfigController {
  private final OidcService oidcService;
  private final boolean allowSignUp;
  private final String announcement;
  private final boolean demoMode;
  private final BuildProperties buildProperties;
  private final Optional<Mailer> mailer;

  @Autowired
  public ConfigController(
      OidcService oidcService,
      @Value("${ALLOW_SIGNUP:0}") boolean allowSignUp,
      @Value("${ANNOUNCEMENT:}") String announcement,
      @Value("${DEMO_MODE:0}") boolean demoMode,
      BuildProperties buildProperties,
      Optional<Mailer> mailer) {
    this.oidcService = oidcService;
    this.allowSignUp = allowSignUp;
    this.announcement = announcement;
    this.demoMode = demoMode;
    this.buildProperties = buildProperties;
    this.mailer = mailer;
  }

  @GetMapping
  public AppConfig getConfig() {
    AppConfig config = new AppConfig();
    config.setAnnouncement(announcement);
    config.setAllowSignup(allowSignUp);
    config.setDemoMode(demoMode);
    config.setCanResetPassword(mailer.isPresent());

    config.setBackendVersion(buildProperties.getVersion());

    if (oidcService.getOidcDiscoveryUrl() != null) {
      config.setOidcConfig(oidcService.getOidcConfig());
    }

    return config;
  }
}
