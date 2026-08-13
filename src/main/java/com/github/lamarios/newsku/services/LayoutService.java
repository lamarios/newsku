package com.github.lamarios.newsku.services;

import com.github.lamarios.newsku.models.LayoutBlockSettings;
import com.github.lamarios.newsku.models.LayoutBlockType;
import com.github.lamarios.newsku.persistence.entities.LayoutBlock;
import com.github.lamarios.newsku.persistence.repositories.LayoutRepository;
import java.util.List;
import java.util.UUID;
import org.apache.tomcat.util.http.InvalidParameterException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LayoutService {
    private final LayoutRepository layoutRepository;
    private final UserService userService;

    @Autowired
    public LayoutService(LayoutRepository layoutRepository, UserService userService) {
        this.layoutRepository = layoutRepository;
        this.userService = userService;
    }

    @Transactional(readOnly = true)
    public List<LayoutBlock> getLayout() {
        var blocks = layoutRepository.findByUserOrderByOrder(userService.getCurrentUser());

        if (blocks == null || blocks.isEmpty()) {
            return defaultLayout();
        }

        return blocks;
    }

    @Transactional
    public List<LayoutBlock> setLayout(List<LayoutBlock> layoutBlocks) {
        var user = userService.getCurrentUser();
        // we allow empty so the user will revert back to default layout
        if (layoutBlocks == null || layoutBlocks.isEmpty()) {
            layoutRepository.deleteByUser(user);
            return defaultLayout();
        }
        // we validate the blocks to make sure that the last one is not fixed
        if (layoutBlocks.getLast().getType().isFixedSize()) {
            throw new InvalidParameterException("layout must end by a flexible block");
        }
        // we remove feed categories from the latest of the layout
        layoutBlocks.getLast().getSettings().setCategoryId(null);
        // if we're good, we remove all the items from the user then we insert all the new ones.
        layoutRepository.deleteByUser(user);

        layoutBlocks.forEach(layoutBlock -> {
            layoutBlock.setId(UUID.randomUUID().toString());
            layoutBlock.setUser(user);
        });

        layoutRepository.saveAll(layoutBlocks);

        return layoutBlocks;
    }

    private List<LayoutBlock> defaultLayout() {
        // one top stories
        LayoutBlock topStories = new LayoutBlock();
        LayoutBlockSettings topStoriesSettings = new LayoutBlockSettings();
        topStoriesSettings.setTitle("★ Top Stories");
        topStories.setSettings(topStoriesSettings);
        topStories.setOrder(0);
        topStories.setType(LayoutBlockType.topStories);
        // a big grid of 6 items
        LayoutBlock grid = new LayoutBlock();
        LayoutBlockSettings gridSettings = new LayoutBlockSettings();
        gridSettings.setItems(6);
        grid.setSettings(gridSettings);
        grid.setOrder(1);
        grid.setType(LayoutBlockType.bigGrid);
        // small grid
        LayoutBlock smallGrid = new LayoutBlock();
        LayoutBlockSettings smallGridSettings = new LayoutBlockSettings();
        smallGridSettings.setItems(2);
        smallGrid.setSettings(smallGridSettings);
        smallGrid.setType(LayoutBlockType.smallGrid);
        smallGrid.setOrder(2);

        return List.of(topStories, grid, smallGrid);
    }
}
