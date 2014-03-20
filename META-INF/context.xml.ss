<Context path="/rms" reloadable="true" docBase="rms">
<Resource name="jdbc/js" auth="Container" type="javax.sql.DataSource" maxActive="100" 
		maxIdle="30" maxWait="10000" username="dev" password="dev123" driverClassName="com.mysql.jdbc.Driver" 
		url="jdbc:mysql://ss:3306/js?autoReconnect=true"/> 
</Context>
