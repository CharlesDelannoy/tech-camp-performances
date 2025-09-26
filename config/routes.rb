Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Tech Camp Performance routes
  scope :dev do
    scope :tech_camp_performance do
      get :agenda_notes_for_an_organization, to: 'tech_camp_performance#agenda_notes_for_an_organization'
      get :imported_file_stats, to: 'tech_camp_performance#imported_file_stats'
      get :agenda_notes_for_an_agenda, to: 'tech_camp_performance#agenda_notes_for_an_agenda'
      get :past_appointments_count, to: 'tech_camp_performance#past_appointments_count'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
