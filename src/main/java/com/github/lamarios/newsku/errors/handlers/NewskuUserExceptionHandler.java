package com.github.lamarios.newsku.errors.handlers;

import com.github.lamarios.newsku.errors.NewskuException;
import com.github.lamarios.newsku.errors.NewskuUserException;
import java.util.Map;
import java.util.UUID;
import org.jetbrains.annotations.NotNull;
import org.jspecify.annotations.Nullable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class NewskuUserExceptionHandler extends ResponseEntityExceptionHandler {
    @ExceptionHandler({NewskuUserException.class, NewskuException.class})
    @Nullable ResponseEntity<@NotNull Object> handleError(NewskuException exception, WebRequest request) {
        return super.handleExceptionInternal(
                exception,
                Map.of(
                        "message",
                        exception.getMessage(),
                        "type",
                        exception.getClass().getSimpleName(),
                        "uuid",
                        UUID.randomUUID().toString()
                ),
                new HttpHeaders(MultiValueMap.fromSingleValue(Map.of("Content-Type", "application/json"))),
                HttpStatus.BAD_REQUEST,
                request
        );
    }
}
