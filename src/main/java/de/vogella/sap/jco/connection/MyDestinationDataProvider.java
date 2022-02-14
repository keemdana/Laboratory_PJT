package de.vogella.sap.jco.connection;

import java.util.Properties;

import com.sap.conn.jco.ext.DestinationDataEventListener;
import com.sap.conn.jco.ext.DestinationDataProvider;

/*
 * Provides the data connection to the SAP system
 *
 */
class MyDestinationDataProvider implements DestinationDataProvider {
    private static final String sapServer = "SAP_SERVER";
    private DestinationDataEventListener eventListener;
    private Properties abapAsProperties;

    @Override
    public Properties getDestinationProperties(String desNam) {
        if (desNam.equals(sapServer) && abapAsProperties != null) {
            return abapAsProperties;
        }
        return null;
    }

    public void setDestinationDataEventListener(
            DestinationDataEventListener eventListener) {
        this.eventListener = eventListener;
    }

    @Override
    public boolean supportsEvents() {
        return true;
    }

    public void changePropertiesForAbapAS(Properties properties) {
        if (properties == null) {

            abapAsProperties = null;
            eventListener.deleted(sapServer);

        } else {
            if (abapAsProperties != null &&
                    !abapAsProperties.equals(properties)) {
                eventListener.updated("SAP_SERVER");
            }
            abapAsProperties = properties;
        }
    }
}