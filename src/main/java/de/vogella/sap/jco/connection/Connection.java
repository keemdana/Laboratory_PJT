package de.vogella.sap.jco.connection;

import java.util.Properties;

import com.sap.conn.jco.JCoContext;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoRepository;
import com.sap.conn.jco.ext.DestinationDataProvider;

import de.vogella.sap.jco.model.SapSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Connection allows to get and execute SAP functions. The constructor expect a
 * SapSystem and will save the connection data to a file. The connection will
 * also be automatically be established.
 */
public class Connection {

    /**
     * logger
     */
    private final Logger log = LoggerFactory.getLogger(Connection.class);

    private static final String sapServer = "SAP_SERVER";
    private JCoRepository repos;
    private JCoDestination dest;
    private final Properties properties;

    public Connection(String mode) {

        SapSystem system = new SapSystem();

//        String mode = CommonProperties.load("SAP_MODE");
        String client = CommonProperties.load(mode + ".SAP.Client");
        String host = CommonProperties.load(mode + ".SAP.Host");
        String systemNumber = CommonProperties.load(mode + ".SAP.SystemNumber");
        String user = CommonProperties.load(mode + ".SAP.User");
        String password = CommonProperties.load(mode + ".SAP.Pw");
        String language = CommonProperties.load(mode + ".SAP.Lang");

        system.setSystemNumber(systemNumber);
        system.setHost(host);
        system.setClient(client);
        system.setUser(user);
        system.setPassword(password);
        system.setLanguage(language);

        if(!"OP".equals(mode)){
            // DEBUG
            log.debug("system=" + system.toString());
        }

        properties = new Properties();
        properties.setProperty(DestinationDataProvider.JCO_ASHOST,
                system.getHost());
        properties.setProperty(DestinationDataProvider.JCO_SYSNR,
                system.getSystemNumber());
        properties.setProperty(DestinationDataProvider.JCO_CLIENT,
                system.getClient());
        properties.setProperty(DestinationDataProvider.JCO_USER,
                system.getUser());
        properties.setProperty(DestinationDataProvider.JCO_PASSWD,
                system.getPassword());
        properties.setProperty(DestinationDataProvider.JCO_LANG,
                system.getLanguage());
        properties.setProperty(DestinationDataProvider.JCO_R3NAME,
                system.getSystemId());

        MyDestinationDataProvider myProvider = new MyDestinationDataProvider();
        if (!com.sap.conn.jco.ext.Environment
                .isDestinationDataProviderRegistered()) {
            com.sap.conn.jco.ext.Environment
                    .registerDestinationDataProvider(myProvider);
        }

        myProvider.changePropertiesForAbapAS(properties);
        try {
            dest = null;
            dest = JCoDestinationManager.getDestination(sapServer);

            // DEBUG
            log.debug("Attributes:");
            log.debug(dest.getAttributes().toString());

            repos = dest.getRepository();

        } catch (JCoException e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    private Connection(SapSystem system) {
        properties = new Properties();
        properties.setProperty(DestinationDataProvider.JCO_ASHOST,
                system.getHost());
        properties.setProperty(DestinationDataProvider.JCO_SYSNR,
                system.getSystemNumber());
        properties.setProperty(DestinationDataProvider.JCO_CLIENT,
                system.getClient());
        properties.setProperty(DestinationDataProvider.JCO_USER,
                system.getUser());
        properties.setProperty(DestinationDataProvider.JCO_PASSWD,
                system.getPassword());
        properties.setProperty(DestinationDataProvider.JCO_LANG,
                system.getLanguage());

        MyDestinationDataProvider myProvider = new MyDestinationDataProvider();
        if (!com.sap.conn.jco.ext.Environment
                .isDestinationDataProviderRegistered()) {
            com.sap.conn.jco.ext.Environment
                    .registerDestinationDataProvider(myProvider);
        }

        myProvider.changePropertiesForAbapAS(properties);
        try {
            dest = null;
            dest = JCoDestinationManager.getDestination(sapServer);

            // DEBUG
            log.debug("Attributes:");
            log.debug(dest.getAttributes().toString());

            repos = dest.getRepository();

        } catch (JCoException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Method getFunction read a SAP Function and return it to the caller. The
     * caller can then set parameters (import, export, tables) on this function
     * and call later the method execute.
     * <p>
     * getFunction translates the JCo checked exceptions into a non-checked
     * exceptions
     */
    public JCoFunction getFunction(String functionStr) {
        JCoFunction function = null;
        try {
            function = repos.getFunction(functionStr);
        } catch (Exception e) {
            log.error(e.toString());
            throw new RuntimeException(
                    "Problem retrieving JCO.Function object.");
        }
        if (function == null) {
            throw new RuntimeException("Not possible to receive function. ");
        }
        return function;
    }

    /**
     * Method execute will call a function. The Caller of this function has
     * already set all required parameters of the function
     */
    public void execute(JCoFunction function) {
        try {
            JCoContext.begin(dest);
            function.execute(dest);
            JCoContext.end(dest);
        } catch (JCoException e) {
            log.error(e.toString());
        }
    }
}