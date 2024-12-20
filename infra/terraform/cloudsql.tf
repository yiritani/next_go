# resource "google_sql_database_instance" "db_instance" {
#   name             = "backend-db-instance"
#   database_version = "POSTGRES_16"
#   region           = var.region
#
#   settings {
#     tier = "db-f1-micro"
#   }
# }
# resource "google_sql_database" "main_database" {
#   name     = "main-database"
#   instance = google_sql_database_instance.db_instance.name
# }
#
# resource "google_sql_user" "db_user" {
#   name     = "backend_user"
#   instance = google_sql_database_instance.db_instance.name
#   password = var.app_db_user_password
# }
#
# resource "google_sql_database" "db" {
#   name     = "backend_db"
#   instance = google_sql_database_instance.db_instance.name
# }
