package com.example.benefits.service.login;

import com.example.benefits.model.login.*;
import com.example.benefits.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private UserRepository userRepository;

    public LoginResult manageLogin(LoginRequest request) {
        LoginResult result = new LoginResult();

        // Check by username or email
        var userOpt = userRepository.findByUsername(request.getIdentifier());
        if (userOpt.isEmpty()) {
            userOpt = userRepository.findByEmail(request.getIdentifier());
        }

        if (userOpt.isPresent()) {
            var user = userOpt.get();
            if (user.getPassword().equals(request.getPassword())) {
                result.setUsername(user.getUsername());
                result.setMail(user.getEmail());
                result.setErrorCode(0);
            } else {
                result.setErrorMsg("Incorrect password");
                result.setErrorCode(2);
            }
        } else {
            result.setErrorMsg("User not found");
            result.setErrorCode(1);
        }

        return result;
    }
}
