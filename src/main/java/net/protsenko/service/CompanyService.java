package net.protsenko.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import net.protsenko.repository.CompanyRepository;

@ApplicationScoped
public class CompanyService {

    @Inject
    CompanyRepository companyRepository;

}