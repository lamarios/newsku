package com.github.lamarios.newsku.persistence.repositories;

import com.github.lamarios.newsku.persistence.entities.LayoutBlock;
import com.github.lamarios.newsku.persistence.entities.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LayoutRepository extends JpaRepository<LayoutBlock, String> {
    List<LayoutBlock> findByUserOrderByOrder(User user);

    void deleteByUser(User user);
}
