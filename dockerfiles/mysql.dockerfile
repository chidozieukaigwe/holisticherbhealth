FROM mysql:8.0

# Set ownership of the data directory
RUN chown -R mysql:mysql /var/lib/mysql 
RUN chmod -R 750 /var/lib/mysql


# Configure MySQL settings (if necessary)
COPY ./mysql/my.cnf /etc/mysql/conf.d/my.cnf 

# Expose the MySQL port
EXPOSE 3306

# Set the working directory
WORKDIR /var/lib/mysql


CMD ["mysqld"]
