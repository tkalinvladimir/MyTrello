package com.tkalin.MyTrello_letscode.repos;

import com.tkalin.MyTrello_letscode.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long> {

    User findByUsername(String username);

}
