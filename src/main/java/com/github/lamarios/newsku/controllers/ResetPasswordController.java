package com.github.lamarios.newsku.controllers;

import com.github.lamarios.newsku.services.ResetPasswordService;
import freemarker.template.TemplateException;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.io.IOException;
import org.springframework.web.bind.annotation.*;

@RestController
@Tag(name = "Reset password")
@RequestMapping("/")
public class ResetPasswordController {
    private final ResetPasswordService resetPasswordService;

    public ResetPasswordController(ResetPasswordService resetPasswordService) {
        this.resetPasswordService = resetPasswordService;
    }

    @PostMapping("/forgot-password")
    public void forgotPassword(@RequestBody String email) throws TemplateException, IOException {
        resetPasswordService.forgotPassword(email);
    }

    @PostMapping("/reset-password")
    public void resetPassword(@RequestBody String password, @RequestParam("token") String token) {
        resetPasswordService.resetPassword(token, password);
    }
}
