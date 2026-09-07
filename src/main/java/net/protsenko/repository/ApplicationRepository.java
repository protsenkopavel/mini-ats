package net.protsenko.repository;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class ApplicationRepository {

    @Inject
    Db db;

}