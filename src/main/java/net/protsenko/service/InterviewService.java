package net.protsenko.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import net.protsenko.repository.InterviewRepository;

@ApplicationScoped
public class InterviewService {

    @Inject
    InterviewRepository interviewRepository;

}