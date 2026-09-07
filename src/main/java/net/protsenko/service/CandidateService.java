package net.protsenko.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import net.protsenko.repository.CandidateRepository;

@ApplicationScoped
public class CandidateService {

    @Inject
    CandidateRepository candidateRepository;

}