package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.persistence.entities.LayoutBlock;
import com.github.lamarios.newsku.services.LayoutService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/layout")
@Tag(name = "Layout")
@SecurityRequirement(name = "bearerAuth")
public class LayoutController {
    private final boolean demoMode;
    private final LayoutService layoutService;

    @Autowired
    public LayoutController(@Value("${DEMO_MODE:0}") boolean demoMode, LayoutService layoutService) {
        this.demoMode = demoMode;
        this.layoutService = layoutService;
    }

    @GetMapping
    public List<LayoutBlock> getLayout() {
        return layoutService.getLayout();
    }

    @PutMapping
    public List<LayoutBlock> setLayout(@RequestBody List<LayoutBlock> blocks) {
        if (demoMode) {
            throw new AccessDeniedException("App in demoMode");
        }

        return layoutService.setLayout(blocks);
    }
}
