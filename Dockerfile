FROM openjdk:17
WORKDIR /app
COPY . .
RUN javac Calculator.java
CMD ["java", "Calculator"]
EXPOSE 8080

