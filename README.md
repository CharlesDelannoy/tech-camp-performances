# Tech Camp Performances

A Rails application for the performance training session at tech camp. This app demonstrates the data model with organizations, agendas, agenda notes, and appointments.

## Data Model

- **Organizations** can have many **Agendas**
- **Agendas** belong to an organization and can have many **AgendaNotes** and **Appointments**
- **AgendaNotes** belong to an agenda and contain text notes
- **Appointments** belong to an agenda and have start/end dates

## Setup

### Prerequisites

- Ruby 3.3.2
- Docker and Docker Compose
- Rails 8.0

### Database Setup

1. Start the PostgreSQL database:
   ```bash
   docker-compose up -d postgres
   ```

2. Create and migrate the database:
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```

3. Load basic seed data (optional):
   ```bash
   bin/rails db:seed
   ```

4. Load performance exercise data:
   ```bash
   bin/rails tech_camp_performance:seed
   ```

### Running the Application

```bash
bin/rails server
```

The database runs on localhost:5433 (to avoid conflicts with existing PostgreSQL instances).

### Sample Data

The basic seed file (`db/seeds.rb`) is currently empty - use the tech camp performance seed instead.

The tech camp performance seed creates:
- **Exercise 1**: 100+ agendas with 3-10 agenda notes each for N+1 query testing
- **Exercise 2**: Import file for performance analysis
- **Exercise 3**: 5,000 agenda notes with large text content for pagination testing
- **Exercise 4**: 500,000+ past appointments for date query performance testing

### Exercises

The performance exercises are available through the `TechCampPerformanceController` located at `app/controllers/tech_camp_performance_controller.rb:1`.

Available exercise endpoints:
- **Exercise 1**: `http://localhost:3000/dev/tech_camp_performance/agenda_notes_for_an_organization`
  - Tests N+1 query performance with organizations and their agenda notes
- **Exercise 2**: `http://localhost:3000/dev/tech_camp_performance/imported_file_stats`
  - Tests performance with large file content analysis (target: improve to < 1sec)
- **Exercise 3**: `http://localhost:3000/dev/tech_camp_performance/agenda_notes_for_an_agenda`
  - Tests pagination performance with 5,000 large agenda notes
- **Exercise 4**: `http://localhost:3000/dev/tech_camp_performance/past_appointments_count`
  - Tests date query performance with 500,000+ appointments (target: < 50ms)

### Development

Test the data relationships:
```bash
bin/rails runner "puts 'Organizations: ' + Organization.count.to_s"
```
