class Import::File < ApplicationRecord
  def normalized_content_urgence_count
    normalized_content.count("Urgence")
  end

  def normalized_content_consultation_de_suivi_count
    normalized_content.count("Consultation de suivi")
  end

  def normalized_content_premiere_consultation_count
    normalized_content.count("Premi̬re consultation")
  end

  def normalized_content_laboratoire_count
    normalized_content.count("Laboratoire")
  end

  def normalized_content_paris_count
    normalized_content.count("Paris")
  end

  def normalized_content_miromesnil_count
    normalized_content.count("32, Rue de Miromesnil")
  end

  def normalized_content_17_09_2018_count
    normalized_content.count("17/09/2018")
  end

  def normalized_content_19_09_2018_count
    normalized_content.count("19/09/2018")
  end

  def normalized_content_20_09_2018_count
    normalized_content.count("20/09/2018")
  end

  def normalized_content
    return if anonymized?
    fetch_content
  end

  def anonymized?
    false # Default implementation
  end

  private

  def fetch_content
    # Read from the CSV file in the project
    csv_path = Rails.root.join("db", filename)
    return "" unless File.exist?(csv_path)

    sleep 0.015
    File.read(csv_path)
  rescue StandardError => e
    Rails.logger.error "Error reading CSV file: #{e.message}"
    ""
  end
end
