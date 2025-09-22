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

3. Load seed data:
   ```bash
   bin/rails db:seed
   ```

### Running the Application

```bash
bin/rails server
```

The database runs on localhost:5433 (to avoid conflicts with existing PostgreSQL instances).

### Sample Data

The seed file creates:
- 3 organizations (Tech Camp, Doctolib, Startup Inc)
- 4 agendas with various topics
- 7 agenda notes covering performance, Rails, and development topics
- 5 appointments scheduled for upcoming dates

### Development

Test the data relationships:
```bash
bin/rails runner "puts 'Organizations: ' + Organization.count.to_s"
```
