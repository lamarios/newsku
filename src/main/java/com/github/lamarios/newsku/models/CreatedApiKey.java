package com.github.lamarios.newsku.models;

import com.github.lamarios.newsku.persistence.entities.ApiKey;

/**
 * Returned only once, when the key is created. The plain key is never stored and can't be retrieved
 * afterwards.
 */
public record CreatedApiKey(ApiKey apiKey, String key) {}
