package com.github.lamarios.newsku.security;

import com.github.lamarios.newsku.models.UserCredentials;
import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.services.OidcService;
import com.github.lamarios.newsku.services.UserService;
import io.jsonwebtoken.Claims;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@Tag(name = "Log in")
public class JwtAuthenticationController {
    private final PasswordEncoder passwordEncoder;
    private final UserService userService;
    private final JwtTokenUtil jwtTokenUtil;
    private final OidcService oidcService;

    @Autowired
    public JwtAuthenticationController(
            PasswordEncoder passwordEncoder,
            UserService userService,
            JwtTokenUtil jwtTokenUtil,
            OidcService oidcService
    ) {
        this.passwordEncoder = passwordEncoder;
        this.userService = userService;

        this.jwtTokenUtil = jwtTokenUtil;
        this.oidcService = oidcService;
    }

    @GetMapping("/oidc-login")
    @Operation(description = "Logs into the system, will return a JWT token to pass to other requests as a bearer "
            + "token via the Authorization header")
    public String loginWithOidcToken(@RequestHeader("Authorization") String authorizationHeader) throws Exception {
        String token = authorizationHeader.replaceAll("Bearer ", "");
        Claims claims = oidcService.getParser().parseSignedClaims(token).getPayload();
        var subject = claims.getSubject();

        var user = oidcLoadUser(subject, token);
        if (user != null) {
            return jwtTokenUtil.generateToken(user);
        } else {
            return null;
        }
    }

    @PostMapping("/login")
    public String login(@RequestBody UserCredentials credentials) throws Exception {
        authenticate(credentials.username(), credentials.password());

        UserDetails userDetails = loadUserByUsername(credentials.username(), null);
        return jwtTokenUtil.generateToken(userDetails);
    }

    private void authenticate(String username, String password) throws Exception {
        Objects.requireNonNull(username);
        Objects.requireNonNull(password);
        final Optional<User> byUsername = userService.getUser(username);

        if (byUsername.isEmpty()) {
            throw new BadCredentialsException("Invalid username or password");
        }

        var user = byUsername.get();

        boolean cryptMatch = passwordEncoder.matches(password, user.getPassword());
        if (!cryptMatch) {
            throw new BadCredentialsException("Invalid username or password");
        }
    }

    public UserDetails oidcLoadUser(String subscription, String accessToken) throws Exception {
        Optional<User> user = oidcService.handleUserSub(subscription, accessToken);
        return user
            .map(u -> {
                List<GrantedAuthority> authorityList = new ArrayList<>();
                return new org.springframework.security.core.userdetails.User(
                        u.getUsername(),
                        u.getPassword(),
                        authorityList
                );
            })
            .orElseThrow(() -> new UsernameNotFoundException("No user with subscription " + subscription));
    }

    public UserDetails loadUserByUsername(String username, String accessToken) throws UsernameNotFoundException {
        try {
            Optional<User> user;
            if (username != null) {
                user = userService.getUser(username);
            } else {
                throw new Exception();
            }

            return user
                .map(u -> {
                    List<GrantedAuthority> authorityList = new ArrayList<>();
                    return new org.springframework.security.core.userdetails.User(
                            u.getUsername(),
                            u.getPassword(),
                            authorityList
                    );
                })
                .orElseThrow(() -> new UsernameNotFoundException("No user with username " + username));
        } catch (Exception e) {
            throw new UsernameNotFoundException("No user with email " + username);
        }
    }
}
