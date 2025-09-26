# frozen_string_literal: true

# rubocop:disable Rake/MethodDefinitionInTask
namespace :tech_camp_performance do
  desc 'Seeds required for all exercises'
  task seed: :environment do
    $stdout.sync = true
    @logger = Logger.new($stdout)

    one
    two
    three
    four
  end

  def one
    @logger.info('[Exercise 1] Started.')
    organization =
      Organization.find_by(name: 'ExerciseOne') || Organization.create!(name: 'ExerciseOne')

    # Create 100+ agendas to trigger N+1 performance issues
    100.times do |index|
      agenda_name = [
        "Development Planning #{index}",
        "Bug Tracking #{index}",
        "Feature Requests #{index}",
        "Technical Debt #{index}",
        "Sprint Planning #{index}",
        "Code Review #{index}",
        "Architecture Discussion #{index}",
        "Performance Analysis #{index}",
        "Security Audit #{index}",
        "Database Optimization #{index}",
        "API Design #{index}",
        "Testing Strategy #{index}",
        "Deployment Planning #{index}",
        "Monitoring Setup #{index}",
        "Documentation #{index}"
      ].sample

      organization.agendas.find_or_create_by!(name: "#{agenda_name}")
    end
    @logger.info('[Exercise 1] Agendas created.')

    # Create agenda notes for each agenda to trigger N+1 queries
    organization.agendas.each do |agenda|
      notes_count = rand(3..10) # Random number of notes per agenda
      notes_count.times do |i|
        note_content = [
          "Performance optimization task #{i+1}",
          "Code review item #{i+1}",
          "Development task #{i+1}",
          "Bug fix #{i+1}",
          "Feature request #{i+1}",
          "Technical debt #{i+1}",
          "Sprint item #{i+1}",
          "Security audit #{i+1}",
          "Database optimization #{i+1}",
          "API enhancement #{i+1}"
        ].sample

        note_detail = [
          'Query optimization', 'Cache implementation', 'Database indexing', 'Memory usage', 'API response time',
          'Security audit', 'Performance review', 'Architecture discussion', 'Best practices', 'Refactoring',
          'Feature implementation', 'Testing strategy', 'Documentation', 'Deployment plan', 'Environment setup',
          'Memory leak', 'SQL injection vulnerability', 'Race condition', 'Null pointer exception', 'Performance degradation'
        ].sample

        agenda.agenda_notes.find_or_create_by!(
          note: "#{note_content} - #{note_detail}",
          done: [true, false].sample,
          is_urgent: [true, false].sample
        )
      end
    end
    @logger.info('[Exercise 1] AgendaNotes created.')
    @logger.info('[Exercise 1] Complete.')
  end

  def two
    @logger.info('[Exercise 2] Started.')
    Import::File.find_or_create_by!(filename: 'tech_campus_performance.csv')
    @logger.info('[Exercise 2] Complete.')
  end

  def three
    @logger.info('[Exercise 3] Started.')
    organization =
      Organization.find_by(name: 'Tech Camp') || Organization.create!(name: 'Tech Camp')

    agenda =
      Agenda.find_by(name: 'AgendaExerciseThree') ||
        Agenda.create!(name: 'AgendaExerciseThree', organization: organization)

    # Create 5000 agenda notes with very large text content for pagination test
    large_text_base = "This is a very large agenda note with extensive content designed to test performance when dealing with large text fields. " * 50

    additional_content = [
      "Performance optimization requires careful analysis of database queries, memory usage patterns, and CPU utilization across the entire application stack. We need to examine each component systematically, starting with the database layer where N+1 queries can cause significant performance degradation. The application should implement proper eager loading strategies using includes, preload, or joins as appropriate for each specific use case. ",
      "When dealing with large datasets, pagination becomes critical for maintaining acceptable response times and memory usage. The implementation should use LIMIT and OFFSET clauses efficiently, though for very large datasets, cursor-based pagination might be more appropriate to avoid performance issues with high offset values. ",
      "Caching strategies play a crucial role in application performance. We should implement multi-level caching including database query result caching, application-level object caching, and HTTP response caching where appropriate. Redis or Memcached can be used for distributed caching scenarios. ",
      "Database indexing is fundamental for query performance. We need to analyze query patterns and create appropriate indexes on frequently queried columns, especially for WHERE clauses, JOIN conditions, and ORDER BY operations. However, too many indexes can slow down write operations, so we need to find the right balance. ",
      "Memory management is crucial when processing large datasets. The application should avoid loading entire result sets into memory when possible, instead using streaming or batch processing approaches. Ruby's garbage collection can become a bottleneck with large object allocations, so object pooling or other memory management strategies might be necessary. "
    ]

    5000.times do |i|
      # Create really large note content (approximately 3-4 screens worth)
      large_note_content = "#{large_text_base}\n\n"
      large_note_content += "=== DETAILED ANALYSIS SECTION #{i+1} ===\n\n"
      large_note_content += additional_content.sample * 3
      large_note_content += "\n\n=== TECHNICAL SPECIFICATIONS ===\n\n"
      large_note_content += "Database: PostgreSQL 13.x with connection pooling configured for optimal performance under high load conditions. Connection pool size should be tuned based on available memory and expected concurrent users. " * 5
      large_note_content += "\n\n=== IMPLEMENTATION DETAILS ===\n\n"
      large_note_content += "The implementation requires careful consideration of ActiveRecord query patterns, proper use of scopes and associations, and strategic placement of database indexes. We must also consider the impact on database replication lag and ensure that read-heavy operations can be distributed across read replicas where appropriate. " * 4
      large_note_content += "\n\n=== MONITORING AND METRICS ===\n\n"
      large_note_content += "Comprehensive monitoring should include query execution times, memory usage patterns, garbage collection frequency, cache hit rates, and overall response times. Tools like New Relic, DataDog, or custom metrics collection can provide insights into performance bottlenecks and help identify optimization opportunities. " * 3

      agenda.agenda_notes.find_or_create_by!(
        note: large_note_content,
        done: [true, false].sample,
        is_urgent: [true, false].sample
      )
    end
    @logger.info('[Exercise 3] Complete.')
  end

  def four
    @logger.info('[Exercise 4] Started.')
    organization =
      Organization.find_by(name: 'Doctolib') || Organization.create!(name: 'Doctolib')

    agenda =
      Agenda.find_by(name: 'AgendaExerciseFour') ||
        Agenda.create!(name: 'AgendaExerciseFour', organization: organization)

    # Create many past appointments for performance testing (slow date queries without index)
    insert_appointments(agenda.id, 500000)

    # Create some future appointments
    10.times do |i|
      start_time = (i + 1).days.from_now.beginning_of_day + rand(8..17).hours
      agenda.appointments.find_or_create_by!(
        start_date: start_time,
        end_date: start_time + 1.hour
      )
    end

    @logger.info('[Exercise 4] Complete.')
  end

  def insert_appointments(agenda_id, count)
    agenda = Agenda.find(agenda_id)

    # Create appointments that will ALL match the query (start_date <= Date.current + 1)
    # Spread them over last 3 years to ensure all dates are in the past
    appointments_data = []
    count.times do |i|
      # Spread appointments over last 1095 days (3 years) - all will match the query
      days_ago = rand(2..1095) # Start from 2 days ago to ensure all are in the past
      start_time = days_ago.days.ago.beginning_of_day + rand(8..17).hours + rand(0..59).minutes

      appointments_data << {
        agenda_id: agenda_id,
        start_date: start_time,
        end_date: start_time + rand(30..180).minutes,
        created_at: Time.current,
        updated_at: Time.current
      }

      # Insert in batches of 5000 to optimize for large dataset
      if appointments_data.length >= 5000
        Appointment.insert_all(appointments_data)
        appointments_data = []
        @logger.info("Inserted #{i + 1}/#{count} appointments...")
      end
    end

    # Insert remaining appointments
    Appointment.insert_all(appointments_data) if appointments_data.any?
    @logger.info("Completed inserting #{count} appointments")
  end
end
# rubocop:enable Rake/MethodDefinitionInTask