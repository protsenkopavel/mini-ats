package net.protsenko.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import net.protsenko.repository.SkillRepository;

@ApplicationScoped
public class SkillService {

    @Inject
    SkillRepository skillRepository;

}