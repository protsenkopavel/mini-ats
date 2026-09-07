package net.protsenko.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import net.protsenko.repository.ApplicationRepository;

@ApplicationScoped
public class ApplicationService {

    @Inject
    ApplicationRepository applicationRepository;

}