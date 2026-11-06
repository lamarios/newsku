package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.errors.NewskuUserException;
import com.github.lamarios.newsku.models.CreatedApiKey;
import com.github.lamarios.newsku.persistence.entities.ApiKey;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.persistence.repositories.ApiKeyRepository;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HexFormat;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ApiKeyService {
  public static final String KEY_PREFIX = "nsk_";
  private static final int KEY_BYTES = 32;
  private static final String HASH_ALGORITHM = "HmacSHA256";

  private final ApiKeyRepository apiKeyRepository;
  private final UserService userService;
  private final SecretKeySpec hashKey;
  private final SecureRandom random = new SecureRandom();

  @Autowired
  public ApiKeyService(
      ApiKeyRepository apiKeyRepository, UserService userService, @Value("${SALT}") String salt) {
    this.apiKeyRepository = apiKeyRepository;
    this.userService = userService;
    this.hashKey = new SecretKeySpec(salt.getBytes(StandardCharsets.UTF_8), HASH_ALGORITHM);
  }

  @Transactional
  public CreatedApiKey createApiKey(String name, Long expiresAt) throws NewskuUserException {
    if (name == null || name.isBlank()) {
      throw new NewskuUserException("API key name is empty");
    }

    if (expiresAt != null && expiresAt <= System.currentTimeMillis()) {
      throw new NewskuUserException("API key expiry date must be in the future");
    }

    byte[] bytes = new byte[KEY_BYTES];
    random.nextBytes(bytes);
    String key = KEY_PREFIX + Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);

    ApiKey apiKey = new ApiKey();
    apiKey.setId(UUID.randomUUID().toString());
    apiKey.setUser(userService.getCurrentUser());
    apiKey.setName(name.trim());
    apiKey.setKeyHash(hash(key));
    apiKey.setTimeCreated(System.currentTimeMillis());
    apiKey.setExpiresAt(expiresAt);

    apiKeyRepository.save(apiKey);

    return new CreatedApiKey(apiKey, key);
  }

  @Transactional(readOnly = true)
  public List<ApiKey> getApiKeys() {
    User user = userService.getCurrentUser();
    return apiKeyRepository.getAllByUser(user, Sort.by(Sort.Direction.DESC, "timeCreated"));
  }

  @Transactional
  public boolean deleteApiKey(String id) {
    User user = userService.getCurrentUser();

    ApiKey apiKey = apiKeyRepository.getApiKeyByIdAndUser(id, user);
    if (apiKey != null) {
      apiKeyRepository.delete(apiKey);
      return true;
    } else {
      return false;
    }
  }

  /**
   * Finds the owner of a plain API key, if the key exists and hasn't expired. Also marks the key as
   * used.
   */
  @Transactional
  public Optional<User> getUserFromKey(String key) {
    if (key == null || key.isBlank()) {
      return Optional.empty();
    }

    var apiKey = apiKeyRepository.findByKeyHash(hash(key.trim())).filter(k -> !k.isExpired());

    apiKey.ifPresent(k -> apiKeyRepository.updateLastUsed(k.getId(), System.currentTimeMillis()));

    return apiKey.map(ApiKey::getUser);
  }

  private String hash(String key) {
    try {
      Mac mac = Mac.getInstance(HASH_ALGORITHM);
      mac.init(hashKey);
      return HexFormat.of().formatHex(mac.doFinal(key.getBytes(StandardCharsets.UTF_8)));
    } catch (Exception e) {
      throw new IllegalStateException("Couldn't hash API key", e);
    }
  }
}
