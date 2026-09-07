package net.protsenko.repository;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class CompanyRepository {

    @Inject
    Db db;

}