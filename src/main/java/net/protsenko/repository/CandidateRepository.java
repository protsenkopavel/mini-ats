package net.protsenko.repository;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class CandidateRepository {

    @Inject
    Db db;

}