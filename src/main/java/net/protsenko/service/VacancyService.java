package net.protsenko.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import net.protsenko.repository.VacancyRepository;

@ApplicationScoped
public class VacancyService {

    @Inject
    VacancyRepository vacancyRepository;

}