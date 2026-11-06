package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.ApiKeyRequest;
import com.github.lamarios.newsku.models.CreatedApiKey;
import com.github.lamarios.newsku.persistence.entities.ApiKey;
import com.github.lamarios.newsku.services.ApiKeyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/api-keys")
@Tag(name = "API Keys")
@SecurityRequirement(name = "bearerAuth")
@SecurityRequirement(name = "apiKey")
public class ApiKeyController {
  private final ApiKeyService apiKeyService;
  private final boolean demoMode;

  @Autowired
  public ApiKeyController(ApiKeyService apiKeyService, @Value("${DEMO_MODE:0}") boolean demoMode) {
    this.apiKeyService = apiKeyService;
    this.demoMode = demoMode;
  }

  @GetMapping
  public List<ApiKey> getApiKeys() {
    return apiKeyService.getApiKeys();
  }

  @PutMapping
  @Operation(
      description =
          "Creates an API key. The plain key is only returned in this response, it can't be"
              + " retrieved afterwards. Use it as is in the Authorization header, without the"
              + " Bearer prefix")
  public CreatedApiKey createApiKey(@RequestBody ApiKeyRequest request) throws NewskuUserException {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    return apiKeyService.createApiKey(request.name(), request.expiresAt());
  }

  @DeleteMapping("{id}")
  public boolean deleteApiKey(@PathVariable String id) {
    if (demoMode) {
      throw new AccessDeniedException("App in demoMode");
    }
    return apiKeyService.deleteApiKey(id);
  }
}
