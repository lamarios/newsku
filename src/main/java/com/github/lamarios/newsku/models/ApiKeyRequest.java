package com.github.lamarios.newsku.models;

/**
 * @param name display name of the key
 * @param expiresAt expiry date in epoch millis, null for a key that never expires
 */
public record ApiKeyRequest(String name, Long expiresAt) {}
