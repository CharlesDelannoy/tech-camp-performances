class TechCampPerformanceController < ApplicationController
  # http://localhost:3000/dev/tech_camp_performance/agenda_notes_for_an_organization
  def agenda_notes_for_an_organization
    agenda_notes =
      Organization
        .find_by(name: 'ExerciseOne')
        .agendas
        .map { |agenda| { agenda_id: agenda.id, agenda_notes: agenda.agenda_notes&.map(&:note) } }

    render json: agenda_notes
  end

  # http://localhost:3000/dev/tech_camp_performance/imported_file_stats
  # Returns information about the content of a specific Import File.
  # Note: you won't be able to improve it under 1sec, but an important improvement can still be made.
  def imported_file_stats
    import_file = ::Import::File.find_by(filename: 'tech_campus_performance.csv')

    render json: {
             normalized_content_consultation_de_suivi_count: import_file.normalized_content_consultation_de_suivi_count,
             normalized_content_premiere_consultation_count: import_file.normalized_content_premiere_consultation_count,
             normalized_content_laboratoire_count: import_file.normalized_content_laboratoire_count,
             normalized_content_urgence_count: import_file.normalized_content_urgence_count,
             normalized_content_paris_count: import_file.normalized_content_paris_count,
             normalized_content_miromesnil_count: import_file.normalized_content_miromesnil_count,
             normalized_content_17_09_2018_count: import_file.normalized_content_17_09_2018_count,
             normalized_content_19_09_2018_count: import_file.normalized_content_19_09_2018_count,
             normalized_content_20_09_2018_count: import_file.normalized_content_20_09_2018_count,
           }
  end

  # http://localhost:3000/dev/tech_camp_performance/agenda_notes_for_an_agenda
  # Returns the number of agenda_notes and the id, name and description of each of them for a specific agenda.
  def agenda_notes_for_an_agenda
    pagination_size = 5_000 # business rule, do not change
    agenda = Agenda.find_by(name: 'AgendaExerciseThree')
    agenda_notes = agenda.agenda_notes.limit(pagination_size).select(:id, :done, :is_urgent)

    render json: { data: agenda_notes.map(&:to_processable_format), count: agenda_notes.count }
  end

  # http://localhost:3000/dev/tech_camp_performance/past_appointments_count
  # Returns the number of appointments before a date for a specific agenda.
  # Count should generally be < 50ms
  def past_appointments_count
    agenda = Agenda.find_by(name: 'AgendaExerciseFour')
    count = agenda.appointments.where('date(start_date) <= ?', Date.current).count
    render json: count
  end
end