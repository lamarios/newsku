package com.github.lamarios.newsku.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {
    private static final Logger logger = LogManager.getLogger();
    private final JwtTokenUtil jwtTokenUtil;
    private final JwtAuthenticationController jwtAuthenticationController;
    private final String[] AUTH_CHECK = new String[] {"/api/"};

    @Autowired
    public JwtRequestFilter(JwtTokenUtil jwtTokenUtil, JwtAuthenticationController jwtAuthenticationController) {
        //        this.jwtUserDetailsService = jwtUserDetailsService;
        this.jwtTokenUtil = jwtTokenUtil;
        this.jwtAuthenticationController = jwtAuthenticationController;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException,
            IOException {
        if (Arrays
            .stream(AUTH_CHECK)
            .anyMatch(s -> request.getRequestURI().contains(s))) {
            try {
                final String requestTokenHeader = request.getHeader("Authorization");

                String username = null;
                String jwtToken = null;
                boolean fromApiKey = false;
                // JWT Token is in the form "Bearer token". Remove Bearer word and get only the Token
                if (requestTokenHeader != null && requestTokenHeader.startsWith("Bearer ")) {
                    jwtToken = requestTokenHeader.substring(7);
                    username = jwtTokenUtil.getUsernameFromToken(jwtToken);
                }
                // Once we get the token validate it.
                if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                    UserDetails userDetails = this.jwtAuthenticationController.loadUserByUsername(username, jwtToken);
                    // if token is valid configure Spring Security to manually set authentication
                    if (fromApiKey || jwtTokenUtil.validateToken(jwtToken, userDetails)) {
                        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                                new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                        usernamePasswordAuthenticationToken.setDetails(new WebAuthenticationDetailsSource()
                            .buildDetails(request)
                        );
                        // After setting the Authentication in the context, we specify
                        // that the current user is authenticated. So it passes the Spring Security
                        // Configurations successfully.
                        SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
                    }
                }
            } catch (Exception e) {
                logger.error("Error while authenticating", e);
                response.setStatus(401);
            }
        }

        chain.doFilter(request, response);
    }
}
