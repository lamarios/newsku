package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.ApiKey;
import com.github.lamarios.newsku.persistence.entities.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ApiKeyRepository extends JpaRepository<ApiKey, String> {
  Optional<ApiKey> findByKeyHash(String keyHash);

  ApiKey getApiKeyByIdAndUser(String id, User user);

  List<ApiKey> getAllByUser(User user, Sort sort);

  @Modifying
  @Query("update ApiKey k set k.lastUsed = :lastUsed where k.id = :id")
  void updateLastUsed(@Param("id") String id, @Param("lastUsed") long lastUsed);
}
