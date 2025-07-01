# Social Benefits Calculator

A Spring Boot application that evaluates social benefits eligibility using business rules defined in Drools.
The project aims to learn the whole path from UI to server's communications.

---

## 📁 Project Structure

```
/
├── manager.sh                  # Orchestrates Docker setup and app launch
├── postgres_run.sh            # Manages PostgreSQL container : Usefull for small tests (create, start, stop, query)
├── run.sh                     # Builds and runs the Spring Boot app (preferable to run "manager.sh update")
├── stop.sh                    # Gracefully stops the app and DB containers
├── application-dev.properties # DB configuration (generated dynamically)
├── Dockerfile                 # Used to build the Spring Boot Docker image
├── Tree_Generator.py          # Utility for printing project tree
└── social-benefits-calculator/
    ├── pom.xml
    └── src/
        ├── main/
        │   ├── java/com/example/benefits/... # Java backend code
        │   └── resources/
        │       ├── rules/                    # Drools rules files (.drl)
        │       └── templates/                # Thymeleaf HTML templates
        └── test/                             # Unit and integration tests
```

## ⚙️ Technologies Used

* **Backend**: Spring Boot
* **Business Logic**: Drools (`.drl` rule files)
* **Database**: PostgreSQL (Dockerized - `benefits-db`)
* **Frontend**: Thymeleaf templates and static assets
* **Build Tool**: Maven
---

## 🚀 Infrastructure Scripts

* `manager.sh` – Automates orchestration of Docker containers and config generation (Preferable to use)
* `run.sh` – Builds and launches the application
* `stop.sh` – Gracefully stops the app and database containers
* `postgres_run.sh` – Manages the PostgreSQL container (create, start, stop, query)


---

## 📝 Requirements

* **Docker** (must be running)
* **Java 17**
* **Maven**
* Open ports:

  * `5432` for PostgreSQL
  * `8080` for the Spring Boot application

---

## 🧪 Running the Application

### With Docker:

```bash
./manager.sh
```

### Locally (without Docker):

Ensure PostgreSQL is running and configured properly, then:

```bash
./run.sh
```

### To Stop Services:

```bash
./stop.sh
```

