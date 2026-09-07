package net.protsenko;

import io.agroal.api.AgroalDataSource;
import io.quarkus.runtime.StartupEvent;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@ApplicationScoped
public class MiniAtsApp {

    private static final Logger LOG = Logger.getLogger(MiniAtsApp.class);

    @Inject
    AgroalDataSource dataSource;

    void onStart(@Observes StartupEvent ev) {
        String sql = """
                SELECT (SELECT count(*) FROM company)   AS companies,
                       (SELECT count(*) FROM vacancy)   AS vacancies,
                       (SELECT count(*) FROM candidate) AS candidates,
                       (SELECT count(*) FROM application) AS applications,
                       (SELECT count(*) FROM interview) AS interviews
                """;
        try (Connection c = dataSource.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            rs.next();
            LOG.infof("DB ready: companies=%d, vacancies=%d, candidates=%d, applications=%d, interviews=%d",
                    rs.getLong("companies"), rs.getLong("vacancies"), rs.getLong("candidates"),
                    rs.getLong("applications"), rs.getLong("interviews"));
        } catch (Exception e) {
            throw new IllegalStateException("Не удалось прочитать данные из БД", e);
        }
    }
}
