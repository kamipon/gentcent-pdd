package org.hibernate.dialect;

import org.hibernate.Hibernate;

import java.sql.Types;

public class WOSQLDialect extends MySQLDialect {
	
	public WOSQLDialect() {
		super();
		registerHibernateType(Types.REAL, Hibernate.FLOAT.getName());
		registerHibernateType(Types.LONGVARCHAR, Hibernate.TEXT.getName());
	}
}