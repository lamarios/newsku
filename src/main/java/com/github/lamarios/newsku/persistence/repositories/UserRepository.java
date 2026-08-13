package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.User;
import java.util.List;
import org.jetbrains.annotations.NotNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<@NotNull User, @NotNull String> {
  List<User> getUserByUsername(String username);

  User getUserByOidcSub(String oidcSub);

  User findFirstByEmail(String email);

  User findFirstById(String subject);

  long countUserByEmail(String email);

  long countUserByUsername(String username);
}
