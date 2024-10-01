# Bygg Maven-prosjektet ved hjelp av Java 17
FROM maven:3.8-eclipse-temurin-17 AS builder
WORKDIR /app
# Kopier pom.xml fra den spesifikke plasseringen til arbeidskatalogen
COPY /spring-docker-dockerhub/pom.xml .
# Kopier src-mappen fra den spesifikke plasseringen til arbeidskatalogen
COPY /spring-docker-dockerhub/src ./src
# Bygg prosjektet med Maven
RUN mvn package

# Bruk et baseimage med Java 17 for å kjøre applikasjonen
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Kopier den bygde JAR-filen fra builder-stadiet
COPY --from=builder /app/target/*.jar /app/application.jar
# Definer kommandoen for å kjøre applikasjonen
ENTRYPOINT ["java", "-jar", "/app/application.jar"]
