package com.github.lamarios.newsku.security;

import com.github.lamarios.newsku.persistence.entities.User;
import com.github.lamarios.newsku.services.ApiKeyService;
import com.github.lamarios.newsku.services.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {
  private static final Logger logger = LogManager.getLogger();

  /** Authority given to requests authenticated with an API key instead of a login session */
  public static final String API_KEY_AUTHORITY = "API_KEY";

  private final JwtTokenUtil jwtTokenUtil;
  private final UserService userService;
  private final ApiKeyService apiKeyService;
  private final String[] AUTH_CHECK = new String[] {"/api/"};

  @Autowired
  public JwtRequestFilter(
      JwtTokenUtil jwtTokenUtil, UserService userService, ApiKeyService apiKeyService) {
    this.jwtTokenUtil = jwtTokenUtil;
    this.userService = userService;
    this.apiKeyService = apiKeyService;
  }

  @Override
  protected void doFilterInternal(
      HttpServletRequest request, HttpServletResponse response, FilterChain chain)
      throws ServletException, IOException {
    if (Arrays.stream(AUTH_CHECK).anyMatch(s -> request.getRequestURI().contains(s))) {
      try {
        final String requestTokenHeader = request.getHeader("Authorization");

        User user = null;
        boolean fromApiKey = false;
        // JWT Token is in the form "Bearer token". Remove Bearer word and get only the Token
        if (requestTokenHeader != null && requestTokenHeader.startsWith("Bearer ")) {
          final String jwtToken = requestTokenHeader.substring(7);
          user =
              userService
                  .getUser(jwtTokenUtil.getUsernameFromToken(jwtToken))
                  .filter(u -> jwtTokenUtil.validateToken(jwtToken, u))
                  .orElse(null);
        } else if (requestTokenHeader != null && !requestTokenHeader.isBlank()) {
          // Anything else in the Authorization header is treated as an API key
          user = apiKeyService.getUserFromKey(requestTokenHeader).orElse(null);
          fromApiKey = user != null;
        }

        if (user != null && SecurityContextHolder.getContext().getAuthentication() == null) {
          List<GrantedAuthority> authorities =
              fromApiKey ? List.of(new SimpleGrantedAuthority(API_KEY_AUTHORITY)) : List.of();
          UserDetails userDetails =
              new org.springframework.security.core.userdetails.User(
                  user.getUsername(), user.getPassword(), authorities);
          UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
              new UsernamePasswordAuthenticationToken(userDetails, null, authorities);
          usernamePasswordAuthenticationToken.setDetails(
              new WebAuthenticationDetailsSource().buildDetails(request));
          // After setting the Authentication in the context, we specify
          // that the current user is authenticated. So it passes the Spring Security
          // Configurations successfully.
          SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
        }
      } catch (Exception e) {
        logger.error("Error while authenticating", e);
        response.setStatus(401);
      }
    }

    chain.doFilter(request, response);
  }
}
