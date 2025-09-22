# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create organizations
tech_camp = Organization.find_or_create_by!(name: "Tech Camp")
doctolib = Organization.find_or_create_by!(name: "Doctolib")
startup = Organization.find_or_create_by!(name: "Startup Inc")

# Create agendas for tech camp
performance_agenda = tech_camp.agendas.find_or_create_by!(name: "Performance Session")
rails_agenda = tech_camp.agendas.find_or_create_by!(name: "Rails Deep Dive")

# Create agendas for other organizations
doctolib_dev_agenda = doctolib.agendas.find_or_create_by!(name: "Development Team")
startup_planning = startup.agendas.find_or_create_by!(name: "Sprint Planning")

# Create agenda notes
performance_agenda.agenda_notes.find_or_create_by!(note: "Focus on database query optimization and N+1 queries")
performance_agenda.agenda_notes.find_or_create_by!(note: "Cover caching strategies and Redis implementation")
performance_agenda.agenda_notes.find_or_create_by!(note: "Discuss background jobs and Sidekiq performance")

rails_agenda.agenda_notes.find_or_create_by!(note: "ActiveRecord deep dive and advanced associations")
rails_agenda.agenda_notes.find_or_create_by!(note: "Rails engine architecture and modularity")

doctolib_dev_agenda.agenda_notes.find_or_create_by!(note: "Code review guidelines and best practices")
startup_planning.agenda_notes.find_or_create_by!(note: "Quarterly goals and technical debt review")

# Create appointments
performance_agenda.appointments.find_or_create_by!(
  start_date: 2.days.from_now.beginning_of_day + 9.hours,
  end_date: 2.days.from_now.beginning_of_day + 12.hours
)

performance_agenda.appointments.find_or_create_by!(
  start_date: 3.days.from_now.beginning_of_day + 14.hours,
  end_date: 3.days.from_now.beginning_of_day + 17.hours
)

rails_agenda.appointments.find_or_create_by!(
  start_date: 1.week.from_now.beginning_of_day + 10.hours,
  end_date: 1.week.from_now.beginning_of_day + 16.hours
)

doctolib_dev_agenda.appointments.find_or_create_by!(
  start_date: 1.day.from_now.beginning_of_day + 15.hours,
  end_date: 1.day.from_now.beginning_of_day + 16.hours
)

startup_planning.appointments.find_or_create_by!(
  start_date: 1.week.from_now.beginning_of_day + 9.hours,
  end_date: 1.week.from_now.beginning_of_day + 11.hours
)

puts "Created #{Organization.count} organizations"
puts "Created #{Agenda.count} agendas"
puts "Created #{AgendaNote.count} agenda notes"
puts "Created #{Appointment.count} appointments"
