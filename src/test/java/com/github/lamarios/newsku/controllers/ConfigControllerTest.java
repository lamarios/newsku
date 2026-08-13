package com.github.lamarios.newsku.controllers;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import com.github.lamarios.newsku.TestConfig;
import com.github.lamarios.newsku.TestContainerTest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

@Import(TestConfig.class)
public class ConfigControllerTest extends TestContainerTest {
    @Autowired
    private ConfigController configController;

    @Test
    public void testConfigController() {
        System.out.println("testConfigController");
        var config = configController.getConfig();
        assertNotNull(config);
        assertTrue(config.isAllowSignup());
    }
}
