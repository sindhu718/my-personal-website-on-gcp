provider "google" {
  credentials = file("gcp-key.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}
